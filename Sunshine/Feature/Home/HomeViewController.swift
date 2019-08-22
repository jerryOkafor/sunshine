//
//  ViewController.swift
//  Sunshine
//
//  Created by Jerry Hanks on 18/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import FSPagerView

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.do{
            $0.colors = [UIColor(hex: "#484b5b").cgColor, UIColor(hex: "#2c2d35").cgColor]
            $0.locations = [0.0 , 1.0]
            $0.startPoint = CGPoint(x: 0.0, y: 1.0)
            $0.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
    }
    
}

class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()

    private let vm  = HomeViewModel(rxDisposeBag: DisposeBag())
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var hourlyCollectionViewFlowlayout: UICollectionViewFlowLayout!
    
    
    @IBOutlet weak var pagerControl: FSPageControl!{
        didSet{
            self.pagerControl.numberOfPages = self.forcasts.count
            self.pagerControl.contentHorizontalAlignment = .center
            self.pagerControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pagerControl.hidesForSinglePage = true
        }
    }
    @IBOutlet weak var pagerView: FSPagerView!
    
    private var forcasts = [(String,[ForcastItem])]()
    private var forcastDictKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       self.configureToolBar()
        
        let refreshBarItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refrsh(_:)))
        let settingBarItem = UIBarButtonItem(image: R.image.ic_settings(), style: .plain, target: self, action: #selector(settings(_:)))
        refreshBarItem.tintColor = UIColor(hex: "#73767f")
        settingBarItem.tintColor = UIColor(hex: "#73767f")

        self.navigationItem.rightBarButtonItems = [refreshBarItem,settingBarItem]
        
        
        self.configureFspagerView()
        self.configureHourlyCollectionView()
        
        //bind vm
        vm.forcastProgressEvent.bind{progress in
            UIApplication.shared.isNetworkActivityIndicatorVisible = progress
        }.disposed(by: disposeBag)
        
        vm.errorEvent.bind{error in
            self.showError(error: error)
        }.disposed(by: disposeBag)
        
        vm.infoEvent.bind{info in
            self.showInfo(info: info)
        }.disposed(by: disposeBag)
        
        vm.forcasResponseEvent.bind{response in
            self.navigationItem.title = response.city.name
            
            self.forcasts = Dictionary(grouping: response.list, by: { (element: ForcastItem) in
            return self.parseDate(element.dateString,displayFormat: "yyyy-MM-dd")!
            }).sorted(by: { $0.0 < $1.0 })
            
            
            self.pagerView.reloadData()
            self.pagerControl.numberOfPages  = self.forcasts.count
        }.disposed(by: disposeBag)
        
        //load forcast
        vm.forcastByCityId(cityId: "")

    }
    
    private func configureHourlyCollectionView(){
        self.hourlyCollectionView.delegate = self
        self.hourlyCollectionView.dataSource = self
        
        //configure collectionView flowlayout item size
        let space: CGFloat = 2.0
        let dimension = (view.frame.size.width - (3 * space)) / 4.0
        
        self.hourlyCollectionViewFlowlayout.minimumInteritemSpacing = space
        self.hourlyCollectionViewFlowlayout.minimumLineSpacing = space
        
        //set the item size to square
        self.hourlyCollectionViewFlowlayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    private func configureFspagerView(){
        self.pagerView.itemSize = CGSize(width: 230, height: 320)
        self.pagerView.interitemSpacing = 20
    
        //register nib
        let nib = UINib(resource: R.nib.forcastPagerViewCell)
        self.pagerView.register(nib, forCellWithReuseIdentifier: R.reuseIdentifier.forcastPagerViewCell.identifier)
        
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
    }
    
    @objc
    private func refrsh(_ sender:UIBarButtonItem){
        //load forcast
        vm.forcastByCityId(cityId: "")
    }
    
    @objc
    private func settings(_ sender:UIBarButtonItem){
        let settingsVC = R.storyboard.main.settingsViewController()!
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

    private func configureToolBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }

}


//FSPageView Datasource
extension HomeViewController : FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.forcasts.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell  = pagerView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.forcastPagerViewCell.identifier, at: index) as! ForcastPagerViewCell
        
        let forcast = self.forcasts[index]
        print("Binding forcast Item : \(forcast)")
        
        cell.dateLabel.text = self.parseDate(forcast.0,readFormat: "yyyy-MM-dd",displayFormat: "MMM d, yyyy")
        
        return cell
    }
    
    
}

//FSPageView Datasource
extension HomeViewController : FSPagerViewDelegate{
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        print("Target Index : \(targetIndex)")
        self.pagerControl.currentPage = targetIndex
    }
    
    private func parseDate(_ dateStr:String,readFormat:String = "yyyy-MM-dd HH:mm:ss",displayFormat:String = "MMM d, yyyy @ HH:mm:ss") -> String?{
        let readDateFormatter = DateFormatter()
        readDateFormatter.dateFormat = readFormat
        
        if let date = readDateFormatter.date(from: dateStr){
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.dateFormat = displayFormat
            return  displayDateFormatter.string(from: date)
            
        }else{
            return nil
        }
    }
}


//UICollectoinViewDatasource
extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dailyItemViewCell.identifier, for: indexPath) as! DailyItemViewCell
        
        return cell
    }
    
    
}

//UICollectionViewDelegate
extension HomeViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let settingsVC = R.storyboard.main.detailViewController()!
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
}


class DailyItemViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

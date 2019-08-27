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
import CoreData

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).do{
            $0.colors = [UIColor(hex: "#484b5b").cgColor, UIColor(hex: "#2c2d35").cgColor]
            $0.locations = [0.0 , 1.0]
            $0.startPoint = CGPoint(x: 0.0, y: 1.0)
            $0.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
    }
    
}

class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var dataController : DataController!
    private var fetchResultController:NSFetchedResultsController<City>!
    
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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var forcasts = [(String,[Forcast])]()
    private var hourlyForcast = [Forcast]()
    private var city:City? = nil
    private var initiallyLoaded = false
    
    private var preferredCityName:String{
        get{return LocalStorage.preferredCityName ?? ApiClient.defaultCityName}
    }
    
    
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
        self.setUpFetchResulController()
        
        //bind vm
        vm.forcastProgressEvent.bind{progress in
            progress ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = progress
            }.disposed(by: disposeBag)
        
        vm.errorEvent.bind{error in
            self.showError(error: error)
            }.disposed(by: disposeBag)
        
        vm.infoEvent.bind{info in
            self.showInfo(info: info)
            }.disposed(by: disposeBag)
        
        vm.forcasResponseEvent.bind{[unowned self]response in
            //build a city
            let city = City(context: self.dataController.backgroundContext)
            city.id =  response.city.id
            city.country  = response.city.country
            city.name = response.city.name
            city.sunset = response.city.sunset
            city.sunrise = response.city.sunrise
            city.timezone = response.city.timezone
            
            response.list.forEach{
                let forecast =  Forcast(context: self.dataController.backgroundContext)
                forecast.date = $0.dateString
                forecast.dateMilli = $0.dateMilli
                
                let summary = Summary(context: self.dataController.backgroundContext)
                summary.groundLevel = $0.main.groundLevel
                summary.humidity = $0.main.humidity
                summary.maxTemperature = $0.main.maxTemp
                summary.minTemperature = $0.main.minTemp
                summary.temperature = $0.main.temp
                summary.pressure = $0.main.pressure
                
                forecast.summary = summary
                
                let weatherItem = $0.weather[0]
                let weather = Weather(context: self.dataController.backgroundContext)
                weather.desc  = weatherItem.description
                weather.id = weatherItem.id
                weather.main = weatherItem.main
                weather.icon = weatherItem.icon
                
                forecast.weather = weather
                forecast.city = city
            }
            
            
            do{
                try self.dataController.backgroundContext.save()
            }catch{
                print("Unable to save city and forcasts")
            }
    
            }.disposed(by: disposeBag)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(citNamePrefChange(_:)), name: .cityNamePrefChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unitPrefChanged(_:)), name: .unitPrefChanged, object: nil)
        
    }
    
    private func setUpFetchResulController(){
        let fetchRequest:NSFetchRequest<City> = City.fetchRequest()
        let predicate = NSPredicate(format: "name ==[c] %@",preferredCityName)
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        
        do{
            try fetchResultController.performFetch()
            
            self.selectAndBindCityAndForcast()
        }catch{
            fatalError("Could not peform fetch result: \(error)")
        }
    }
    

    
    private func selectAndBindCityAndForcast(){
        
        if let fetchedObjects = fetchResultController?.fetchedObjects{
            if let savedCity  = fetchedObjects.first(where: {$0.name == preferredCityName}){
                self.city = savedCity
                self.bindFetchedCityAndForcast(savedCity)
            }else{
                vm.forcastByCityName(cityName: preferredCityName)
            }
        }else{
            vm.forcastByCityName(cityName: preferredCityName)
            self.initiallyLoaded  = true
        }
        
        
    }
    
    
    private func bindFetchedCityAndForcast(_ city:City){
        
        self.navigationItem.title = city.name
        
        let allObjects =  (city.forcast!.allObjects as! [Forcast])
        
        self.forcasts = Dictionary(grouping:allObjects, by: { (element: Forcast) in
            return  Util.parseDate(element.date!,displayFormat: "yyyy-MM-dd")!
        }).sorted(by: { $0.0 < $1.0 })
        
        self.pagerView.reloadData()
        self.pagerControl.numberOfPages  = self.forcasts.count
        
        self.loadHourlyForcast(forIndex: self.pagerView.currentIndex)
    }
    
    
    @objc
    private func citNamePrefChange(_ notification:Notification){
    
        //call this so that coredata can reload new data
        self.setUpFetchResulController()
    }
    
    @objc
    private func unitPrefChanged(_ notifcation:Notification){
        
        //reload hourly forcast collection view
        self.hourlyCollectionView.reloadData()
        
        //reload dialy forcast collection view
        self.pagerView.reloadData()
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
        self.pagerView.itemSize = CGSize(width: 230, height: 300)
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
        
        //clear data from coredata
        if let savedCity =  self.city{
            self.dataController.viewContext.delete(savedCity)
            self.city = nil
            
            //try to save the context
            do{
                try self.dataController.viewContext.save()
            }catch{
                debugPrint("Error deleting : \(error)")
            }
        }
        
        //get new forcast from api
        vm.forcastByCityName(cityName:preferredCityName)

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
        
        cell.contentView.addGradient(self.getColorForIndex(index))
        
        let forcast:(date:String,forcasts:[Forcast]) = self.forcasts[index]
        
        cell.nameLabel.text = Util.getDayOfWeekText(forcast.0,readFormat:"yyyy-MM-dd")
        cell.dateLabel.text = Util.parseDate(forcast.0,readFormat: "yyyy-MM-dd",displayFormat: "MMM d, yyyy")
        
        let sumIds = forcast.forcasts.reduce(0) { (result, item) -> Int in
            return Int(item.weather!.id) + result
        }
        
        let averageWeatherId = sumIds/forcast.forcasts.count
        cell.iconImageView.image = Util.getImageForWeatherCondition(weatherId: averageWeatherId) ?? Util.getImageForWeatherCondition(weatherId:Int(forcast.forcasts[0].weather!.id))
        
        let sumTemp = forcast.forcasts.reduce(0.0) { (result, item) -> Double in
            return item.summary!.temperature + result
        }
        
        let averageTemp = sumTemp / Double(forcast.forcasts.count)
        cell.tempLabel.text = Util.formatTemperature(temp: averageTemp)
        
        
        return cell
    }
    
    func getColorForIndex(_ index:Int) -> [CGColor]{
        switch index {
        case 0 : return [UIColor(hex: "#0d7af3").cgColor, UIColor(hex: "#849ff1").cgColor]
            
        case 1 : return [UIColor(hex: "#f06d08").cgColor, UIColor(hex: "#f3d458").cgColor]
            
        case 2 : return [UIColor(hex: "#127cf1").cgColor, UIColor(hex: "#f184eca6").cgColor]
            
        case 3 : return [UIColor(hex: "#0ce0d9").cgColor, UIColor(hex: "#84f1d6").cgColor]
            
        case 4 : return [UIColor(hex: "#127cf1").cgColor, UIColor(hex: "#84cef1").cgColor]
            
        default: return [UIColor(hex: "#0d7af3").cgColor, UIColor(hex: "#0d7af3").cgColor]
        }
    }
    
}
//FSPageView Datasource
extension HomeViewController : FSPagerViewDelegate{
    
    func loadHourlyForcast(forIndex index : Int){
        let forcastDays = self.forcasts[index].1
        self.hourlyForcast  = forcastDays
        self.hourlyCollectionView.reloadData()
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pagerControl.currentPage = targetIndex
        self.loadHourlyForcast(forIndex: targetIndex)
    }
}


//UICollectoinViewDatasource
extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hourlyForcast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dailyItemViewCell.identifier, for: indexPath) as! DailyItemViewCell
        
        let forcastHour = self.hourlyForcast[indexPath.row]
        
        cell.timeLabel.text = Util.parseDate(forcastHour.date!,displayFormat:"ha")?.lowercased()
        cell.tempLabel.text = "22°"
        cell.iconImageView.image =  Util.getImageForWeatherCondition(weatherId: Int(forcastHour.weather!.id))
        cell.tempLabel.text = Util.formatTemperature(temp: forcastHour.summary!.temperature)
        return cell
    }
    
    
}

//UICollectionViewDelegate
extension HomeViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsVC = R.storyboard.main.detailViewController()!
        detailsVC.city = self.city!
        detailsVC.forecasts = self.hourlyForcast
        detailsVC.hourIndex = indexPath.row
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//DataController Delegate
extension HomeViewController : NSFetchedResultsControllerDelegate{

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        guard let city  = anObject as? City else {return}
        self.city = city

        switch type {
        case .insert,.update:
            self.bindFetchedCityAndForcast(city)
            
            break
        case .delete:
            //clear data
            self.forcasts.removeAll(keepingCapacity: false)
            self.hourlyForcast.removeAll(keepingCapacity: false)
            
            //reload hourly forcast collection view
            self.hourlyCollectionView.reloadData()
            
            //reload dialy forcast collection view
            self.pagerView.reloadData()
            self.pagerControl.numberOfPages  = self.forcasts.count
            
            break
            
        default:
            break
        }
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

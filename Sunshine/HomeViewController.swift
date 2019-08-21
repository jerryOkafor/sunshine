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
    private let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       self.configureToolBar()
        
        let refreshBarItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refrsh(_:)))
        let settingBarItem = UIBarButtonItem(image: R.image.ic_settings(), style: .plain, target: self, action: #selector(settings(_:)))
        refreshBarItem.tintColor = UIColor(hex: "#73767f")
        settingBarItem.tintColor = UIColor(hex: "#73767f")
        
        self.navigationItem.rightBarButtonItems = [refreshBarItem,settingBarItem]
        
        ApiClient.forcastByCityId(id: "524901").observeOn(MainScheduler.instance)
            .subscribe(onNext:{response in
                print(response)
            },onError:{error in
                print(error)
            }).disposed(by: disposebag)
        
    }
    
    
    @objc
    private func refrsh(_ sender:UIBarButtonItem){
        
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


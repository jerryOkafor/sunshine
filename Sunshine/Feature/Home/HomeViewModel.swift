//
//  HomeViewModel.swift
//  Sunshine
//
//  Created by Jerry Hanks on 22/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    private let disposeBag:DisposeBag!
    
    let forcastProgressEvent = PublishRelay<Bool>()
    let forcasResponseEvent = PublishRelay<ForcastResponse>()
    let errorEvent = PublishRelay<String>()
    let infoEvent = PublishRelay<String>()
    

    init(rxDisposeBag:DisposeBag) {
        self.disposeBag = rxDisposeBag
    }
    
    func forcastByCityName(cityName:String){
        print("Loading forcast for \(cityName)")
        self.forcastProgressEvent.accept(true)
        
        ApiClient.forcastByCityName(cityName: cityName).observeOn(MainScheduler.instance)
            .subscribe(onNext:{[weak self]response in
                guard let strongSelf = self else {return}
                strongSelf.forcastProgressEvent.accept(false)
                
                strongSelf.forcasResponseEvent.accept(response)
                
            },onError:{[weak self]error in
                guard let strongSelf = self else {return}
                strongSelf.forcastProgressEvent.accept(false)
                
            }).disposed(by: disposeBag)
    }
}

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
import RxReachability
import Reachability

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
        
        guard networkStateRx.value.isConnected else {
            self.errorEvent.accept("No network connection, please try again later.")
            return
        }
        
        self.forcastProgressEvent.accept(true)
        
        ApiClient.forcastByCityName(cityName: cityName).observeOn(MainScheduler.instance)
            .subscribe(onNext:{[weak self]response in
                guard let strongSelf = self else {return}
                strongSelf.forcastProgressEvent.accept(false)

                strongSelf.forcasResponseEvent.accept(response)

            },onError:{[weak self]error in
                guard let strongSelf = self else {return}
                strongSelf.forcastProgressEvent.accept(false)
                
                if let message = (error as? ApiError)?.message{
                    strongSelf.errorEvent.accept(message)
                }else{
                    strongSelf.errorEvent.accept("Unable to get forcast for choosen location")
                }

            }).disposed(by: disposeBag)
    }
    
    
    let networkStateRx = HomeViewModel.networkStateRx
    
    static let networkStateRx: BehaviorRelay<Reachability.Connection> = {
        let reachability = Reachability()!
        let relay = BehaviorRelay<Reachability.Connection>(value: reachability.connection)
        _ = Reachability.rx.status.subscribe(onNext: {
            relay.accept($0)
        })
        return relay
    }()
}


extension Reachability.Connection {
    
    var isConnected: Bool {
        return self != .none
    }
    
    var isNotConnected: Bool {
        return !isConnected
    }
    
}

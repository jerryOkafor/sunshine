//
//  ApiClient.swift
//  Sunshine
//
//  Created by Jerry Hanks on 20/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa



class ApiClient {
    
    static func forcastByCityName(cityName:String) -> Observable<ForcastResponse> {
        return request(ApiRouter.forcastByCityName(id: cityName))
    }
    
    enum ApiRouter : URLRequestConvertible {
        case forcastByCityName(id:String)
        /// Returns the encoding for the given endpoint route.
        private var encoding : ParameterEncoding {
            switch self {
            default:
                return JSONEncoding.default
            }
        }
        
        /// Returns the HttpMethod type for the given endpoint route.
        private var method : HTTPMethod{
            switch self {
            default: return .post
            }
        }
        
        /// Returns the parameter set for the given api endpoint
        private var parameters : Parameters{
            switch self {
            default : return [:]
            }
        }
        
        
        /// Returns the endpoint path that we append to the base url
        private var path : String {
            switch self {
            case .forcastByCityName(let cityName) : return "forecast/daily?q=\(cityName)&cnt=16&appid=\(Configuration.apiKey)"
                
            }
        }
        
        
        func asURLRequest() throws -> URLRequest {
            //convert the base URL and append path
            let url = URL(string: "\(ApiClient.baseUrl)\(path)")!
            
            //remove percentage encoding
            let urlwithPath = URL(string: url.absoluteString.removingPercentEncoding!)!
            
            //create urlRequest
            var urlRequest = URLRequest(url: urlwithPath)
            
            //set the http method
            urlRequest.httpMethod = method.rawValue
            
            //apend request payload
            if let parameters = self.parameters.removeNullValues() as? Parameters, !parameters.isEmpty{
                urlRequest = try encoding.encode(urlRequest, with: parameters)
            }
            
            //add common headers
            [
                "Accept" : "application/json"
                ].forEach{
                    urlRequest.addValue($1, forHTTPHeaderField: $0)
            }
            
            return urlRequest
        }
        
    }
    
    static func request<T : Codable>(_ urlRequestConvertible:URLRequestConvertible) -> Observable<T>{
        return Observable<T>.create{ observer in
            let request = Session.default.request(urlRequestConvertible).validate()
                .responseDecodable{ (response:DataResponse<T,AFError>) in
                    switch response.result{
                    case .success(let value):
                        //Everything is fine, return the value in onNext
                        observer.onNext(value)
                        observer.onCompleted()
                        break
                        
                    case .failure( let error):
                        print(error)
                        var  errorData:ErrorResponse? = nil
                        
                        if let data = response.data {
                            errorData = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                        }
                        
                        switch response.response?.statusCode{
                        case 400:
                            observer.onError(ApiError.badRequest(errorData?.message))
                        case 401:
                            observer.onError(ApiError.unAthorised(errorData?.message))
                        case 404:
                            observer.onError(ApiError.notFound(errorData?.message))
                        case 500:
                            observer.onError(ApiError.innternalServrError(errorData?.message))
                        default:
                            observer.onError(ApiError.unknown(error.localizedDescription))
                        }
                    }
            }
            
            
            //Finally, we return a dispossable to stop the request
            return Disposables.create{
                request.cancel()
            }
        }
    }
}

struct ErrorResponse : Codable{
    let code : Int
    let message:String
    
    enum CodingKeys :String,CodingKey {
        case code = "cod"
        case message
    }
}

enum ApiError : Error, LocalizedError{
    case badRequest(String?)
    case unAthorised(String?)
    case notFound(String?)
    case innternalServrError(String?)
    case unknown(String?)
    
    var localizedDescription: String {
        switch self {
        case .badRequest : return "Bad Request"
        case .unAthorised : return "Unathorized"
        case .notFound : return "Resource not found"
        case .innternalServrError : return "Internal server error"
        case .unknown : return "Unknown error"
        }
    }
    
    var message:String?{
        switch self {
        case .badRequest(let message) : return message
        case .unAthorised(let message) : return  message
        case .notFound(let message) : return  message
        case .innternalServrError(let message) :  return message
        case .unknown(let message) : return  message
        }
    }
}

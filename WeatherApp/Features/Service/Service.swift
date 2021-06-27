//
//  Service.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 25.06.2021.
//

import Foundation
import Alamofire

//MARK: Protocol

protocol ServiceProtocol {
    func fethAllPosts(onSuccess: @escaping ([Location]) -> Void, onFail: @escaping (String?) -> Void, url: String)
    func fetchCitys(onSuccess: @escaping ([CityWeather]) -> Void, onFail: @escaping (String?) -> Void, url:String)
}

//MARK: Get Datas

struct Service: ServiceProtocol {
    func fethAllPosts(onSuccess: @escaping ([Location]) -> Void, onFail: @escaping (String?) -> Void, url: String) {
        AF.request(url, method: .get).validate().responseDecodable(of: [Location].self) { (response) in
                guard let items = response.value else {
                    onFail(response.debugDescription)
                    return
                }
                onSuccess(items)
            }
        }
    
    func fetchCitys(onSuccess: @escaping ([CityWeather]) -> Void, onFail: @escaping (String?) -> Void, url:String) {
            AF.request(url, method: .get).validate().responseDecodable(of: CityWeatherResult.self) { (response) in
                guard let items = response.value else {
                    onFail(response.debugDescription)
                    return
                }
                onSuccess(items.consolidated_weather)
            }
        }
    }



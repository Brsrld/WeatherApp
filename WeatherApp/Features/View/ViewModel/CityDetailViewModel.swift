//
//  CityDetailViewModel.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import Foundation

//MARK: Protocols

protocol CityDetailViewModelProtocol {
    func service(url:String, onSuccess: @escaping ([CityWeather]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Model Logic

final class CityDetailViewModel {
    
    private let cityDetailViewModelService: ServiceProtocol = Service()
    
    func service(url:String, onSuccess: @escaping ([CityWeather]) -> Void, onFail: @escaping (String?) -> Void) {
        cityDetailViewModelService.fetchCitys(onSuccess: onSuccess, onFail: onFail, url: url)
    }
}

//MARK:  - MainMenuViewModelProtocol

extension CityDetailViewModel: CityDetailViewModelProtocol {}


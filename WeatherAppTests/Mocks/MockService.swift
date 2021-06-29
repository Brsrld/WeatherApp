//
//  MockService.swift
//  WeatherAppTests
//
//  Created by Baris Saraldi on 29.06.2021.
//

import XCTest
@testable import WeatherApp

final class MockService: ServiceProtocol {
    
    // MARK: Properties
    
    var location :[Location] = []
    var cityWeather :[CityWeather] = []
    
    // MARK: Funcs
    
    func fethAllPosts(onSuccess: @escaping ([Location]) -> Void, onFail: @escaping (String?) -> Void, url: String){
        onSuccess(location)
    }
    
    func fetchCitys(onSuccess: @escaping ([CityWeather]) -> Void, onFail: @escaping (String?) -> Void, url: String) {
        onSuccess(cityWeather)
    }
    

}

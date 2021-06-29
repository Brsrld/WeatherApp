//
//  MockView.swift
//  WeatherAppTests
//
//  Created by Baris Saraldi on 29.06.2021.
//

import XCTest
@testable import WeatherApp

class MockView: MainMenuViewModelProtocol {
    
    // MARK: Properties
    
    var outputsLocation: [Location] = []
    var outputsCity: [CityWeather] = []
    
    // MARK: Funcs
    
    func service(onSuccess: @escaping ([Location]) -> Void, onFail: @escaping (String?) -> Void, url: String) {
        onSuccess(outputsLocation)
    }
}

//MARK:  - CityDetailViewModelProtocol

extension MockView: CityDetailViewModelProtocol {
    func service(url: String, onSuccess: @escaping ([CityWeather]) -> Void, onFail: @escaping (String?) -> Void) {
        onSuccess(outputsCity)
    }
}

//
//  Constant.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 25.06.2021.
//

import Foundation

//MARK: Constant

struct Constants {
    
    //MARK: Service Constants
    
    static let locaionURL = "https://www.metaweather.com/api/location/"
    static let latlongExtension = "search/?lattlong="
    static let weatherImageUrl = "https://www.metaweather.com/static/img/weather/png/64/"
    static let weatherImageUrlExtension = ".png"
    
    //MARK: Cell Constants
    
    static let mainMenuCollectionViewCellID = "MainMenuCollectionViewCell"
    static let nearestCitysCollectionViewCellID = "NearestCitysCollectionViewCell"
    static let cityDetailCollectionViewCellID = "CityDetailCollectionViewCell"
    
    //MARK: UI Constants
    
    static let cityDetailViewControllerTitle = "City Detail"
    static let nilValue = " "
    static let internetNotConnected = "Device did not connected to internet"
    static let internetConnected = "Device connected to internet"
    static let mainScreenTitle = "Main Screen"
    static let defaultLattLong = "36.58718,36.17347"
    static let thermometer = "thermometer"
    static let wind = "wind"
    static let pressure = "pressure"
    static let schedule = "schedule"
    static let city = "City"
    static let location = "location"
    static let nearestLocation = "Nearest Locations"
    static let nearestCitys = "Nearest City's"
    static let weeklyForecast = "Weekly Weather Forecast"
    static let weeklyTemp = "Weekly Temp"
}

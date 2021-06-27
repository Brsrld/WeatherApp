//
//  CityWeatherModel.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import Foundation

struct CityWeather: Codable {
    
    let weather_state_name: String
    let weather_state_abbr: String
    let wind_direction_compass: String
    let applicable_date: String
    let the_temp: Double
    let wind_speed: Double
    let humidity: Double
    let visibility: Double
    let air_pressure: Double
}

struct CityWeatherResult: Codable {
    let consolidated_weather: [CityWeather]
}

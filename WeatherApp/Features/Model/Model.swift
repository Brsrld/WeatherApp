//
//  Model.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 25.06.2021.
//

import Foundation

struct Location: Codable {
    let title: String
    let location_type: String
    let woeid: Int
    let latt_long: String
    let distance: Int
}

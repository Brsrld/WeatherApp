//
//  ServiceTest.swift
//  WeatherAppTests
//
//  Created by Baris Saraldi on 29.06.2021.
//

import XCTest
@testable import WeatherApp

class ServiceTest: XCTestCase {

    func testParsing() throws {
        do {
            let bundle = Bundle(for: ServiceTest.self)
            guard let url = bundle.url(forResource: "Weather", withExtension: "json") else {
                XCTFail()
                return
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let weather = try decoder.decode([Location].self, from: data)
            
            XCTAssertEqual(weather.first?.distance , 1512)
            XCTAssertEqual(weather.first?.latt_long, "37.777119, -122.41964")
            XCTAssertEqual(weather.first?.location_type, "City")
            XCTAssertEqual(weather.first?.woeid, 2487956)
        } catch {
            XCTFail()
        }
    }
}

//
//  WeatherData.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import UIKit

struct SubWeatherData: Codable {
    var subData: WeatherAPIData?
    var subCityName: String?
}

struct SubLocationData: Codable {
    var latitude: Double
    var longitude: Double
}

struct WeatherCoordinate {
    public var latitude: Double
    public var longitude: Double
}

enum TemperatureType: Int {
    case celsius = 0
    case fahrenheit = 1
}

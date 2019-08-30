//
//  WeatherData.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import UIKit

 // Review: 하나의 파일에 하나의 구초제, 하나의 열거형이 좋을것 같습니다. ( Review By Milkyo )

struct WeatherData: Codable {
    var subData: WeatherAPIData?
    var subCityName: String?
}

struct LocationData: Codable {
    var latitude: Double?
    var longitude: Double?
}

struct WeatherCoordinate {
    public var latitude: Double
    public var longitude: Double
}

enum TemperatureType: Int {
    case celsius = 0
    case fahrenheit = 1
}

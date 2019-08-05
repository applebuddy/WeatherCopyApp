//
//  WeatherData.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

struct WeatherCoordinate {
    var latitude: Double
    var longitude: Double
}

enum TemperatureType: Int {
    case celsius = 0
    case fahrenheit = 1
}

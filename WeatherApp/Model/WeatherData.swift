//
//  WeatherData.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import UIKit

public struct SubWeatherData {
    public var subData: WeatherAPIData?
    public var subCityName: String
    public var cityLocation: CLLocationCoordinate2D?
}

public struct WeatherCoordinate {
    public var latitude: Double
    public var longitude: Double
}

public enum TemperatureType: Int {
    case celsius = 0
    case fahrenheit = 1
}

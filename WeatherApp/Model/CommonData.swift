//
//  CommonData.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

final class CommonData {
    static let shared = CommonData()

    var temperatureType: TemperatureType = .celsius
    var isLocationAuthority = UserDefaults.standard.bool(forKey: DataIdentifier.isLocationAuthority)
    var mainCoordinate = WeatherCoordinate(latitude: 0, longitude: 0)
    var selectedMainCellIndex = 0
    var mainCityName = "-"
    var weatherURLString = "https://weather.com/ko-KR/weather/today/"
    var isAppForeground = false
    var mainWeatherData: WeatherAPIData?

    // MARK: - Set Method

    func setLocationAuthData(isAuth: Bool) {
        UserDefaults.standard.set(isAuth, forKey: DataIdentifier.isLocationAuthority)
        isLocationAuthority = isAuth
    }

    func setMainCoordinate(latitude: Double, longitude: Double) {
        mainCoordinate.latitude = latitude
        mainCoordinate.longitude = longitude
    }

    func setMainCityName(cityName: String) {
        mainCityName = cityName
    }

    func setSelectedMainCellIndex(index: Int) {
        selectedMainCellIndex = index
    }

    func changeTemperatureType() {
        switch temperatureType {
        case .celsius:
            temperatureType = .fahrenheit
        case .fahrenheit:
            temperatureType = .celsius
        }
    }

    func setMainWeatherData(weatherData: WeatherAPIData) {
        mainWeatherData = weatherData
    }

    func setIsAppForegroundValue(isForeground: Bool) {
        isAppForeground = isForeground
    }

    // MARK: Action Method

    func openWeatherURL(latitude: Double, longitude: Double) {
        let CustomUrlString = "\(CommonData.shared.weatherURLString)\(latitude),\(longitude)?par=apple_widget&locale=ko_KR"
        if latitude != 0.0, longitude != 0.0 {
            if let url = NSURL(string: CustomUrlString) {
                UIApplication.shared.open(url as URL)
            }
        } else {
            if let url = NSURL(string: "\(CommonData.shared.weatherURLString)") {
                UIApplication.shared.open(url as URL)
            }
        }
    }

    // MARK: Check Method

    func checkLocationAuthority() -> Bool {
        return isLocationAuthority
    }

    // MARK: - Get Method

    func getSelectedMainCellIndex() -> Int {
        return selectedMainCellIndex
    }

    func getIsAppForegroundValue() -> Bool {
        return isAppForeground
    }
}

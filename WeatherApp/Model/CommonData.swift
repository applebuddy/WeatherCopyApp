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

    // MARK: Check Method

    func checkLocationAuthority() -> Bool {
        return isLocationAuthority
    }

    // MARK: - Get Method

    func getSelectedMainCellIndex() {
        return selectedMainCellIndex
    }
}

//
//  CommonData.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

final class WeatherCommonData {
    static let shared = WeatherCommonData()

    var isLocationAuthority = UserDefaults.standard.bool(forKey: DataIdentifier.isLocationAuthority)

    func checkLocationAuthority() -> Bool {
        return isLocationAuthority
    }

    func setLocationAuthData(isAuth: Bool) {
        UserDefaults.standard.set(isAuth, forKey: DataIdentifier.isLocationAuthority)
        isLocationAuthority = isAuth
    }
}

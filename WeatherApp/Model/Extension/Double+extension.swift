//
//  Double+extension.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 25/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

// Double+.swift
extension Double {
    func roundedValue(roundSize: Int) -> Double {
        let roundSize = pow(10.0, Double(roundSize))
        return (self * roundSize).rounded() / roundSize
    }

    func changeTemperatureFToC() -> Double {
        return (self - 32) / 1.8
    }

    func changeTemperatureCToF() -> Double {
        return (self * 1.8) + 32
    }
}

//
//  UIViewSettingProtocol.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// UIView의 공통 메서드 정의 프로토콜
protocol UIViewSettingProtocol {
    func makeSubviews()
    func makeConstraints()
}

protocol WeatherAPIDelegate {
    func weatherAPIDidRequested(_ weatherApi: WeatherAPI)
    func weatherAPIDidFinished(_ weatherApi: WeatherAPI)
    func weatherAPIDidError(_ weatherApi: WeatherAPI)
}

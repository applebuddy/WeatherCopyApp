//
//  WeatherCitySearchView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherCitySearchView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubviews()
        makeConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherCitySearchView: UIViewSettingProtocol {
    func makeSubviews() {}

    func makeConstraints() {}
}

//
//  WeatherMainView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherMainView: UIView {
    let weatherMainTableView: WeatherMainTableView = {
        let weatherMainTableView = WeatherMainTableView(frame: CGRect.zero, style: .grouped)
        return weatherMainTableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setSubviews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setWeatherMainTableViewConstraint() {
        weatherMainTableView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherMainTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            weatherMainTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            weatherMainTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            weatherMainTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
}

extension WeatherMainView: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(weatherMainTableView)
    }

    func setConstraints() {
        setWeatherMainTableViewConstraint()
    }
}

//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherInfoView: UIView {
    let weatherTitleView: WeatherTitleView = {
        let weatherTitleView = WeatherTitleView()
        weatherTitleView.backgroundColor = UIColor.gray
        return weatherTitleView
    }()

    let weatherInfoTableView: WeatherInfoTableView = {
        let weatherTableView = WeatherInfoTableView(frame: CGRect.zero, style: .grouped)
        return weatherTableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setSubviews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setWeatherTableViewConstraint() {
        weatherInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherInfoTableView.topAnchor.constraint(equalTo: weatherTitleView.bottomAnchor),
            weatherInfoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            weatherInfoTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            weatherInfoTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }

    func setWeatherTitleViewContraint() {
        weatherTitleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTitleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            weatherTitleView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            weatherTitleView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            weatherTitleView.heightAnchor.constraint(equalToConstant: WeatherViewHeight.titleViewHeight),
        ])
    }
}

extension WeatherInfoView: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(weatherTitleView)
        addSubview(weatherInfoTableView)
    }

    func setConstraints() {
        setWeatherTitleViewContraint()
        setWeatherTableViewConstraint()
    }
}

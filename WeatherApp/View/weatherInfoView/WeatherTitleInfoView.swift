//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherInfoViewController 메인타이틀 정보 뷰
class WeatherTitleInfoView: UIView {
    let weatherTitleView: WeatherTitleView = {
        let weatherTitleView = WeatherTitleView()
        weatherTitleView.backgroundColor = .black
        return weatherTitleView
    }()

    let weatherInfoTableView: WeatherInfoTableView = {
        let weatherTableView = WeatherInfoTableView(frame: CGRect.zero, style: .grouped)
        return weatherTableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setWeatherTableViewConstraint() {
        weatherInfoTableView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherInfoTableView.topAnchor.constraint(equalTo: weatherTitleView.bottomAnchor),
            weatherInfoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            weatherInfoTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            weatherInfoTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }

    func setWeatherTitleViewContraint() {
        weatherTitleView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherTitleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            weatherTitleView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            weatherTitleView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            weatherTitleView.heightAnchor.constraint(equalToConstant: WeatherViewHeight.titleViewHeight),
        ])
    }
}

extension WeatherTitleInfoView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(weatherTitleView)
        addSubview(weatherInfoTableView)
    }

    func makeConstraints() {
        setWeatherTitleViewContraint()
        setWeatherTableViewConstraint()
    }
}

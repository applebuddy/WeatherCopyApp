//
//  WeatherCityListView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherCityListViewController 메인 뷰
/// * **설정 한 장소목록 및 날씨정보를 나타낸다.**
class WeatherCityListView: UIView {
    // MARK: - UI

    let weatherCityListTableView: WeatherCityListTableView = {
        let weatherMainTableView = WeatherCityListTableView(frame: CGRect.zero, style: .grouped)
        return weatherMainTableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = CommonColor.weatherCityListView
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func makeWeatherMainTableViewConstraint() {
        weatherCityListTableView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherCityListTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            weatherCityListTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            weatherCityListTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            weatherCityListTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension WeatherCityListView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(weatherCityListTableView)
    }

    func makeConstraints() {
        makeWeatherMainTableViewConstraint()
    }
}

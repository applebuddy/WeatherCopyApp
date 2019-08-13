//
//  WeatherMainView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherMainViewController 메인 뷰
/// * **설정 한 장소목록 및 날씨정보를 나타낸다.**
class WeatherCityListView: UIView {
    // MARK: - UI

    let weatherMainTableView: WeatherCityListTableView = {
        let weatherMainTableView = WeatherCityListTableView(frame: CGRect.zero, style: .grouped)
        return weatherMainTableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = CommonColor.weatherMainView
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setWeatherMainTableViewConstraint() {
        weatherMainTableView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherMainTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            weatherMainTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            weatherMainTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            weatherMainTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension WeatherCityListView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(weatherMainTableView)
    }

    func makeConstraints() {
        setWeatherMainTableViewConstraint()
    }
}

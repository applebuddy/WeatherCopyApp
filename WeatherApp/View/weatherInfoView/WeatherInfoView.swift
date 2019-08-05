//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherInfoViewController 메인타이틀 정보 뷰
public class WeatherInfoView: UIView {
    let weatherTitleView: WeatherTitleView = {
        let weatherTitleView = WeatherTitleView()
        weatherTitleView.backgroundColor = .black
        return weatherTitleView
    }()

    let weatherInfoTableView: WeatherInfoTableView = {
        let weatherTableView = WeatherInfoTableView(frame: CGRect.zero, style: .grouped)
        return weatherTableView
    }()

    let weatherInfoTableHeaderView: WeatherInfoTableHeaderView = {
        let weatherInfoTableHeaderView = WeatherInfoTableHeaderView()
        weatherInfoTableHeaderView.contentMode = .scaleAspectFill
        return weatherInfoTableHeaderView
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

    // MARK: - Set Method

    func setInfoViewData(title: String, subTitle: String) {
        weatherTitleView.weatherTitleLabel.text = "\(title)"
        weatherTitleView.weatherSubTitleLabel.text = "\(subTitle)"
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

    func setInfoHeaderViewContraint() {
        NSLayoutConstraint.activate([
            weatherInfoTableHeaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherInfoTableHeaderView.topAnchor.constraint(equalTo: weatherTitleView.bottomAnchor),
            weatherInfoTableHeaderView.widthAnchor.constraint(equalTo: widthAnchor),
            weatherInfoTableHeaderView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.infoTableHeaderCell),
        ])
    }
}

extension WeatherInfoView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(weatherTitleView)
        addSubview(weatherInfoTableView)
        addSubview(weatherInfoTableHeaderView)
    }

    func makeConstraints() {
        setWeatherTitleViewContraint()
        setWeatherTableViewConstraint()
        setInfoHeaderViewContraint()
    }
}

//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherInfoViewController 메인타이틀 정보 뷰
class weatherDetailView: UIView {
    let weatherTitleView: weatherDetailTitleView = {
        let weatherTitleView = weatherDetailTitleView()
        weatherTitleView.backgroundColor = .black
        return weatherTitleView
    }()

    let weatherInfoTableView: WeatherDetailTableView = {
        let weatherTableView = WeatherDetailTableView(frame: CGRect.zero, style: .grouped)
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
            weatherInfoTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherInfoTableView.leftAnchor.constraint(equalTo: leftAnchor),
            weatherInfoTableView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }

    func setWeatherTitleViewContraint() {
        weatherTitleView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherTitleView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            weatherTitleView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            weatherTitleView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            weatherTitleView.heightAnchor.constraint(equalToConstant: WeatherViewHeight.titleViewHeight),
        ])
    }

    func setInfoHeaderViewContraint() {
        weatherInfoTableHeaderView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherInfoTableHeaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherInfoTableHeaderView.topAnchor.constraint(equalTo: weatherTitleView.bottomAnchor),
            weatherInfoTableHeaderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            weatherInfoTableHeaderView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.detailTableHeaderCell),
        ])
    }
}

extension weatherDetailView: UIViewSettingProtocol {
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

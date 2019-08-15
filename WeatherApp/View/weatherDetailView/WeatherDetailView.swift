//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherDetailViewController 메인타이틀 정보 뷰
class WeatherDetailView: UIView {
    let weatherTitleView: weatherDetailTitleView = {
        let weatherTitleView = weatherDetailTitleView()
        weatherTitleView.backgroundColor = .black
        return weatherTitleView
    }()

    let weatherDetailTableView: WeatherDetailTableView = {
        let weatherTableView = WeatherDetailTableView(frame: CGRect.zero, style: .grouped)

        return weatherTableView
    }()

    let weatherDetailTableHeaderView: WeatherDetailTableHeaderView = {
        let weatherDetailTableHeaderView = WeatherDetailTableHeaderView()
        weatherDetailTableHeaderView.contentMode = .scaleAspectFill
        return weatherDetailTableHeaderView
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

    func setDetailViewData(title: String, subTitle: String) {
        weatherTitleView.weatherTitleLabel.text = "\(title)"
        weatherTitleView.weatherSubTitleLabel.text = "\(subTitle)"
    }

    func makeDetailTitleViewContraint() {
        weatherTitleView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherTitleView.topAnchor.constraint(equalTo: topAnchor),
            weatherTitleView.leftAnchor.constraint(equalTo: leftAnchor),
            weatherTitleView.rightAnchor.constraint(equalTo: rightAnchor),
            weatherTitleView.heightAnchor.constraint(equalToConstant: WeatherViewHeight.titleViewHeight),
        ])
    }

    func makeDetailTableViewConstraint() {
        weatherDetailTableView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherDetailTableView.topAnchor.constraint(equalTo: weatherTitleView.bottomAnchor),
            weatherDetailTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherDetailTableView.leftAnchor.constraint(equalTo: leftAnchor),
            weatherDetailTableView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }

    func makeDetailHeaderViewContraint() {
        weatherDetailTableHeaderView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherDetailTableHeaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherDetailTableHeaderView.topAnchor.constraint(equalTo: weatherTitleView.bottomAnchor),
            weatherDetailTableHeaderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            weatherDetailTableHeaderView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.detailTableHeaderCell),
        ])
    }
}

extension WeatherDetailView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(weatherTitleView)
        addSubview(weatherDetailTableView)
    }

    func makeConstraints() {
        makeDetailTitleViewContraint()
        makeDetailTableViewConstraint()
    }
}

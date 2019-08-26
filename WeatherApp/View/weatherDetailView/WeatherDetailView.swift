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
    let weatherDetailTitleView: WeatherDetailTitleView = {
        let weatherDetailTitleView = WeatherDetailTitleView()
        weatherDetailTitleView.backgroundColor = .black
        return weatherDetailTitleView
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
        weatherDetailTitleView.weatherTitleLabel.text = "\(title)"
        weatherDetailTitleView.weatherSubTitleLabel.text = "\(subTitle)"
    }

    func makeDetailTitleViewContraint() {
        weatherDetailTitleView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherDetailTitleView.topAnchor.constraint(equalTo: topAnchor),
            weatherDetailTitleView.leftAnchor.constraint(equalTo: leftAnchor),
            weatherDetailTitleView.rightAnchor.constraint(equalTo: rightAnchor),
            weatherDetailTitleView.heightAnchor.constraint(equalToConstant: WeatherViewHeight.titleViewHeight),
        ])
    }

    func makeDetailTableViewConstraint() {
        weatherDetailTableView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherDetailTableView.topAnchor.constraint(equalTo: weatherDetailTitleView.bottomAnchor),
            weatherDetailTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherDetailTableView.leftAnchor.constraint(equalTo: leftAnchor),
            weatherDetailTableView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
}

extension WeatherDetailView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(weatherDetailTitleView)
        addSubview(weatherDetailTableView)
    }

    func makeConstraints() {
        makeDetailTitleViewContraint()
        makeDetailTableViewConstraint()
    }
}

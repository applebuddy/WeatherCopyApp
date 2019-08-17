
//
//  WeatherTitleView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherdetailViewController 메인 타이틀 뷰
class WeatherDetailTitleView: UIView {
    // MARK: - UI

    let weatherTitleLabel: UILabel = {
        let weatherTitleLabel = UILabel()
        weatherTitleLabel.text = "__"
        weatherTitleLabel.font = .systemFont(ofSize: 30)
        weatherTitleLabel.textAlignment = .center
        weatherTitleLabel.textColor = .white
        weatherTitleLabel.adjustsFontSizeToFitWidth = true
        return weatherTitleLabel
    }()

    let weatherSubTitleLabel: UILabel = {
        let weatherSubTitleLabel = UILabel()
        weatherSubTitleLabel.text = "_"
        weatherSubTitleLabel.font = .systemFont(ofSize: 15)
        weatherSubTitleLabel.textAlignment = .center
        weatherSubTitleLabel.textColor = .white
        return weatherSubTitleLabel
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Set Method

    func makeWeatherTitleLabelConstraint() {
        weatherTitleLabel.activateAnchors()
        NSLayoutConstraint.activate([
            weatherTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherTitleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            weatherTitleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            weatherTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherTitleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    func makeWeatherSubTitleLabelConstraint() {
        weatherSubTitleLabel.activateAnchors()
        NSLayoutConstraint.activate([
            weatherSubTitleLabel.topAnchor.constraint(equalTo: weatherTitleLabel.bottomAnchor, constant: 10),
            weatherSubTitleLabel.leftAnchor.constraint(equalTo: weatherTitleLabel.leftAnchor),
            weatherSubTitleLabel.rightAnchor.constraint(equalTo: weatherTitleLabel.rightAnchor),
            weatherSubTitleLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}

extension WeatherDetailTitleView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(weatherTitleLabel)
        addSubview(weatherSubTitleLabel)
    }

    func makeConstraints() {
        makeWeatherTitleLabelConstraint()
        makeWeatherSubTitleLabelConstraint()
    }
}

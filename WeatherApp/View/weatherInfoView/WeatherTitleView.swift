
//
//  WeatherTitleView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherTitleView: UIView {
    let weatherTitleLabel: UILabel = {
        let weatherTitleLabel = UILabel()
        weatherTitleLabel.text = "광명시"
        weatherTitleLabel.font = UIFont.systemFont(ofSize: 30)
        weatherTitleLabel.textAlignment = .center
        weatherTitleLabel.textColor = UIColor.white
        weatherTitleLabel.adjustsFontSizeToFitWidth = true
        return weatherTitleLabel
    }()

    let weatherSubTitleLabel: UILabel = {
        let weatherSubTitleLabel = UILabel()
        weatherSubTitleLabel.text = "흐림"
        weatherSubTitleLabel.font = UIFont.systemFont(ofSize: 15)
        weatherSubTitleLabel.textAlignment = .center
        weatherSubTitleLabel.textColor = UIColor.white
        return weatherSubTitleLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setSubviews() {
        addSubview(weatherTitleLabel)
        addSubview(weatherSubTitleLabel)
    }

    func setConstraints() {
        weatherTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherTitleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30),
            weatherTitleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -30),
            weatherTitleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            weatherTitleLabel.heightAnchor.constraint(equalToConstant: 30),
        ])

        weatherSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherSubTitleLabel.topAnchor.constraint(equalTo: weatherTitleLabel.bottomAnchor, constant: 10),
            weatherSubTitleLabel.leftAnchor.constraint(equalTo: weatherTitleLabel.leftAnchor),
            weatherSubTitleLabel.rightAnchor.constraint(equalTo: weatherTitleLabel.rightAnchor),
            weatherSubTitleLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}

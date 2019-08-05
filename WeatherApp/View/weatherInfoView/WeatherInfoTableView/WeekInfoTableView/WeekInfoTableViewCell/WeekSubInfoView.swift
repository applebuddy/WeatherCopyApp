//
//  WeekInfoView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeekSubInfoTableViewCell 메인 뷰
class WeekSubInfoView: UIView {
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = ""
        dateLabel.textAlignment = .left
        return dateLabel
    }()

    let maxCelsiusLabel: UILabel = {
        let maxCelsiusLabel = UILabel()
        maxCelsiusLabel.text = ""
        maxCelsiusLabel.textAlignment = .right
        return maxCelsiusLabel
    }()

    let minCelsiusLabel: UILabel = {
        let minCelsiusLabel = UILabel()
        minCelsiusLabel.text = ""
        minCelsiusLabel.textAlignment = .right
        minCelsiusLabel.textColor = .gray
        minCelsiusLabel.alpha = 0.7
        return minCelsiusLabel
    }()

    let weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        return weatherImageView
    }()

    let subWeekInfoStackView: UIStackView = {
        let weekInfoStackView = UIStackView()
        weekInfoStackView.axis = .horizontal
        return weekInfoStackView
    }()

    func setSubWeekInfoStackView() {
        subWeekInfoStackView.addArrangedSubview(dateLabel)
        subWeekInfoStackView.addArrangedSubview(weatherImageView)
        subWeekInfoStackView.addArrangedSubview(maxCelsiusLabel)
        subWeekInfoStackView.addArrangedSubview(minCelsiusLabel)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeekSubInfoView: UIViewSettingProtocol {
    func makeSubviews() {
        setSubWeekInfoStackView()
        addSubview(subWeekInfoStackView)
    }

    func makeConstraints() {
        subWeekInfoStackView.activateAnchors()
        NSLayoutConstraint.activate([
            subWeekInfoStackView.widthAnchor.constraint(equalTo: widthAnchor),
            subWeekInfoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            subWeekInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        dateLabel.activateAnchors()
        weatherImageView.activateAnchors()
        maxCelsiusLabel.activateAnchors()
        minCelsiusLabel.activateAnchors()

        NSLayoutConstraint.activate([
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            dateLabel.heightAnchor.constraint(equalTo: heightAnchor),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor),
            weatherImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            weatherImageView.heightAnchor.constraint(equalTo: heightAnchor),
            maxCelsiusLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            maxCelsiusLabel.heightAnchor.constraint(equalTo: heightAnchor),
            minCelsiusLabel.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}

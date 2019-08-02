//
//  WeekInfoView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeekSubInfoView: UIView {
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "금요일"
        dateLabel.textAlignment = .left
        return dateLabel
    }()

    let maxCelsiusLabel: UILabel = {
        let maxCelsiusLabel = UILabel()
        maxCelsiusLabel.text = "96"
        maxCelsiusLabel.textAlignment = .center
        return maxCelsiusLabel
    }()

    let minCelsiusLabel: UILabel = {
        let minCelsiusLabel = UILabel()
        minCelsiusLabel.text = "77"
        minCelsiusLabel.textAlignment = .center
        return minCelsiusLabel
    }()

    let weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.image = #imageLiteral(resourceName: "cloud")
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
        backgroundColor = UIColor.white
        setSubviews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeekSubInfoView: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(subWeekInfoStackView)
        setSubWeekInfoStackView()
    }

    func setConstraints() {
        subWeekInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subWeekInfoStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            subWeekInfoStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            subWeekInfoStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            subWeekInfoStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),

        ])

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        maxCelsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        minCelsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1.0),
            dateLabel.widthAnchor.constraint(equalTo: maxCelsiusLabel.widthAnchor, multiplier: 2.0),
            dateLabel.widthAnchor.constraint(equalTo: minCelsiusLabel.widthAnchor, multiplier: 2.0),
        ])
    }
}

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
        minCelsiusLabel.textColor = .gray
        minCelsiusLabel.alpha = 0.7
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
            subWeekInfoStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CommonInset.topInset / 2),
            subWeekInfoStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: CommonInset.leftInset),
            subWeekInfoStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -CommonInset.rightInset),
            subWeekInfoStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -CommonInset.bottomInset / 2),
            subWeekInfoStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
        ])

        dateLabel.activateAnchors()
        weatherImageView.activateAnchors()
        maxCelsiusLabel.activateAnchors()
        minCelsiusLabel.activateAnchors()

        NSLayoutConstraint.activate([
            dateLabel.widthAnchor.constraint(equalTo: subWeekInfoStackView.widthAnchor, multiplier: 0.3),
            weatherImageView.widthAnchor.constraint(equalTo: subWeekInfoStackView.widthAnchor, multiplier: 0.3),
            maxCelsiusLabel.widthAnchor.constraint(equalTo: subWeekInfoStackView.widthAnchor, multiplier: 0.3),
            minCelsiusLabel.widthAnchor.constraint(equalTo: subWeekInfoStackView.widthAnchor, multiplier: 0.3),
        ])
    }
}

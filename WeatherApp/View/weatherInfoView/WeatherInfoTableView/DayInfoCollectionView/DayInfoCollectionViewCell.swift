//
//  DayInfoCollectionViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 24시간 날씨예보 정보 컬렉션뷰 셀
class DayInfoCollectionViewCell: UICollectionViewCell {
    let cellImageView: UIImageView = {
        let cellImageView = UIImageView()
        cellImageView.contentMode = .scaleAspectFit
        return cellImageView
    }()

    let titleLabel: UILabel = {
        let firstLabel = UILabel()
        firstLabel.text = "지금"
        firstLabel.font = .boldSystemFont(ofSize: 15)
        firstLabel.textAlignment = .center
        return firstLabel
    }()

    let percentageLabel: UILabel = {
        let secondLabel = UILabel()
        secondLabel.text = ""
        secondLabel.font = .systemFont(ofSize: 10)
        secondLabel.textAlignment = .center
        return secondLabel
    }()

    let celsiusLabel: UILabel = {
        let thirdLabel = UILabel()
        thirdLabel.text = "92º"
        thirdLabel.font = .boldSystemFont(ofSize: 15)
        thirdLabel.textAlignment = .center
        return thirdLabel
    }()

    let cellStackView: UIStackView = {
        let cellStackView = UIStackView()
        cellStackView.axis = .vertical
        cellStackView.spacing = 5
        return cellStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    func setDayInfoCollectionCellData(title: String, preciptication: Double, imageType: WeatherType, celsius: Double) {
        titleLabel.text = "\(title)"
        if preciptication.roundedValue(roundSize: 0) != 0.0 {
            percentageLabel.text = "\(Int(preciptication * 100))%"
        }

        if celsius != 0.0 {
            if CommonData.shared.temperatureType == .celsius {
                celsiusLabel.text = "\(celsius.changeTemperatureFToC().roundedValue(roundSize: 0))º"
            } else {
                celsiusLabel.text = "\(celsius.roundedValue(roundSize: 0))º"
            }
        }

        let image = CommonData.shared.getWeatherImage(imageType: imageType)
        cellImageView.image = image
    }

    func setStackView() {
        cellStackView.addArrangedSubview(titleLabel)
        cellStackView.addArrangedSubview(percentageLabel)
        cellStackView.addArrangedSubview(cellImageView)
        cellStackView.addArrangedSubview(celsiusLabel)
    }
}

extension DayInfoCollectionViewCell: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(cellStackView)
        setStackView()
    }

    func makeConstraints() {
        cellStackView.activateAnchors()
        cellStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cellStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellStackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true

        cellImageView.activateAnchors()
        percentageLabel.activateAnchors()
        celsiusLabel.activateAnchors()
        titleLabel.activateAnchors()
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            percentageLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            percentageLabel.widthAnchor.constraint(equalTo: widthAnchor),
            celsiusLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            celsiusLabel.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}

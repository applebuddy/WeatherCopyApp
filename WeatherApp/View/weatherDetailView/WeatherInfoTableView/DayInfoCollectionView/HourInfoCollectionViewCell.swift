//
//  DayInfoCollectionViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 24시간 날씨예보 정보 컬렉션뷰 셀
class HourInfoCollectionViewCell: UICollectionViewCell {
    // MARK: - UI

    let cellImageView: UIImageView = {
        let cellImageView = UIImageView()
        cellImageView.contentMode = .scaleAspectFit
        return cellImageView
    }()

    let titleLabel: UILabel = {
        let firstLabel = UILabel()
        firstLabel.text = ""
        firstLabel.font = .boldSystemFont(ofSize: 15)
        firstLabel.textAlignment = .center
        return firstLabel
    }()

    let percentageLabel: UILabel = {
        let secondLabel = UILabel()
        secondLabel.text = ""
        secondLabel.textColor = .blue
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

    // MARK: - Init

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

    // MARK: - Set Method

    func setDayInfoCollectionCellData(title: String, precipitation: Double, imageType: WeatherType, celsius: Double) {
        let precipitation = Int(precipitation * 100)
        let celsius = CommonData.shared.calculateCelsius(celsius: celsius)
        let image = CommonData.shared.getWeatherImage(imageType: imageType)

        if precipitation >= 10 {
            percentageLabel.text = "\(precipitation)%"
        } else {
            percentageLabel.text = ""
        }
        celsiusLabel.text = "\(celsius)º"
        titleLabel.text = "\(title)"
        cellImageView.image = image
    }

    func setStackView() {
        cellStackView.addArrangedSubview(titleLabel)
        cellStackView.addArrangedSubview(percentageLabel)
        cellStackView.addArrangedSubview(cellImageView)
        cellStackView.addArrangedSubview(celsiusLabel)
    }

    func makeCellStackViewContraint() {
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
            percentageLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            percentageLabel.widthAnchor.constraint(equalTo: widthAnchor),
            cellImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            cellImageView.widthAnchor.constraint(equalTo: widthAnchor),
            celsiusLabel.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}

extension HourInfoCollectionViewCell: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(cellStackView)
        setStackView()
    }

    func makeConstraints() {
        makeCellStackViewContraint()
    }
}

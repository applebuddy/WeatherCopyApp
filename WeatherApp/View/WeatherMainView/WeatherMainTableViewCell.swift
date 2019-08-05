//
//  WeatherMainTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherMainViewController 메인 테이블뷰 셀
class WeatherMainTableViewCell: UITableViewCell {
    // MARK: - Property

    // MARK: - UI

    let nowTimeLabel: UILabel = {
        let nowTimeLabel = UILabel()
        nowTimeLabel.text = "-"
        nowTimeLabel.textColor = .black
        nowTimeLabel.font = .systemFont(ofSize: 15)
        nowTimeLabel.adjustsFontSizeToFitWidth = true
        return nowTimeLabel
    }()

    let cityTitleLabel: UILabel = {
        let cityTitleLabel = UILabel()
        cityTitleLabel.text = "-"
        cityTitleLabel.sizeToFit()
        cityTitleLabel.textColor = .black
        cityTitleLabel.font = .boldSystemFont(ofSize: 35)
        return cityTitleLabel
    }()

    let cityCelsiusLabel: UILabel = {
        let cityCelsiusLabel = UILabel()
        cityCelsiusLabel.text = "-"
        cityCelsiusLabel.sizeToFit()
        cityCelsiusLabel.textColor = .black
        cityCelsiusLabel.font = .boldSystemFont(ofSize: 50)
        return cityCelsiusLabel
    }()

    let mainIndicatorImageView: UIImageView = {
        let mainIndicatorImageView = UIImageView()
        mainIndicatorImageView.image = #imageLiteral(resourceName: "mainIndicator")
        return mainIndicatorImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        makeSubviews()
        makeConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setMainTableCellData(cityName: String, timeStamp: Int, temperature: Double) {
        cityTitleLabel.text = "\(cityName)"
        if timeStamp != 0 {
            let date = Date(timeIntervalSince1970: Double(timeStamp))
            nowTimeLabel.text = "\(CommonData.shared.mainDateFormatter.string(from: date))"
        }

        let celsius = CommonData.shared.calculateCelsius(celsius: temperature)
        cityCelsiusLabel.text = "\(celsius)º"
    }
}

extension WeatherMainTableViewCell: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(nowTimeLabel)
        addSubview(mainIndicatorImageView)
        addSubview(cityTitleLabel)
        addSubview(cityCelsiusLabel)
    }

    func makeConstraints() {
        nowTimeLabel.activateAnchors()
        NSLayoutConstraint.activate([
            nowTimeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CommonInset.topInset * 2),
            nowTimeLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: CommonInset.leftInset / 2),
            nowTimeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 70),
            nowTimeLabel.heightAnchor.constraint(equalToConstant: 30),
        ])

        mainIndicatorImageView.activateAnchors()
        NSLayoutConstraint.activate([
            mainIndicatorImageView.topAnchor.constraint(equalTo: nowTimeLabel.topAnchor, constant: 0),
            mainIndicatorImageView.bottomAnchor.constraint(equalTo: nowTimeLabel.bottomAnchor, constant: -CommonInset.bottomInset),
            mainIndicatorImageView.leftAnchor.constraint(equalTo: nowTimeLabel.rightAnchor, constant: CommonInset.leftInset / 3),
            mainIndicatorImageView.widthAnchor.constraint(equalTo: mainIndicatorImageView.heightAnchor),
        ])

        cityTitleLabel.activateAnchors()
        NSLayoutConstraint.activate([
            cityTitleLabel.topAnchor.constraint(equalTo: mainIndicatorImageView.bottomAnchor, constant: CommonInset.topInset / 2),
            cityTitleLabel.leftAnchor.constraint(equalTo: nowTimeLabel.leftAnchor),
            cityTitleLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
        ])

        cityCelsiusLabel.activateAnchors()
        NSLayoutConstraint.activate([
            cityCelsiusLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -CommonInset.rightInset / 2),
            cityCelsiusLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),

        ])
    }
}

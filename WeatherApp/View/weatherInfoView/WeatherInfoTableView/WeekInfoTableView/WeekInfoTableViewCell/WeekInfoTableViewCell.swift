//
//  WeekInfoTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 9일간의 날씨예보를 간략하게 보여주는 테이블뷰셀
class WeekInfoTableViewCell: UITableViewCell {
    let weekSubInfoView: WeekSubInfoView = {
        let weekInfoView = WeekSubInfoView()
        return weekInfoView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    // MARK: - Set Method

    func setWeekInfoCellData(timeStamp: Int, imageType: String, maxCelsius: Double, minCelsius: Double) {
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let dateString = CommonData.shared.infoHeaderDateFormatter.string(from: date)

        weekSubInfoView.dateLabel.text = "\(dateString)"

        if maxCelsius > 0 {
            var maxCelsius = maxCelsius.roundedValue(roundSize: 0)
            if CommonData.shared.temperatureType == .celsius {
                maxCelsius = maxCelsius.changeTemperatureFToC().roundedValue(roundSize: 0)
            }
            weekSubInfoView.maxCelsiusLabel.text = "\(Int(maxCelsius))"
        }

        if minCelsius > 0 {
            var minCelsius = maxCelsius.roundedValue(roundSize: 0)
            if CommonData.shared.temperatureType == .celsius {
                minCelsius = maxCelsius.changeTemperatureFToC().roundedValue(roundSize: 0)
            }
            weekSubInfoView.minCelsiusLabel.text = "\(Int(minCelsius))"
        }

        guard let imageType = WeatherType(rawValue: imageType) else { return }
        let image = CommonData.shared.getWeatherImage(imageType: imageType)
        weekSubInfoView.weatherImageView.image = image
    }
}

extension WeekInfoTableViewCell: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(weekSubInfoView)
    }

    func makeConstraints() {
        weekSubInfoView.activateAnchors()
        NSLayoutConstraint.activate([
            weekSubInfoView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            weekSubInfoView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            weekSubInfoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            weekSubInfoView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            weekSubInfoView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.subInfoTableViewCell),
        ])
    }
}

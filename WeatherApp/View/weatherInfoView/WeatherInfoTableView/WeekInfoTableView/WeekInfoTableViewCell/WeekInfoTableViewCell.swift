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
        let maxCelsius = CommonData.shared.calculateCelsius(celsius: maxCelsius)
        let minCelsius = CommonData.shared.calculateCelsius(celsius: minCelsius)

        weekSubInfoView.dateLabel.text = "\(dateString)"
        weekSubInfoView.maxCelsiusLabel.text = "\(maxCelsius)"
        weekSubInfoView.minCelsiusLabel.text = "\(minCelsius)"

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

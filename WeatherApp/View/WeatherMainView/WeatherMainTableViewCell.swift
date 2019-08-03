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
    let nowTimeLabel: UILabel = {
        let nowTimeLabel = UILabel()
        nowTimeLabel.text = "오후 4:21"
        nowTimeLabel.textColor = .white
        nowTimeLabel.font = .systemFont(ofSize: 20)
        return nowTimeLabel
    }()

    let cityTitleLabel: UILabel = {
        let cityTitleLabel = UILabel()
        cityTitleLabel.text = "광명시"
        cityTitleLabel.textColor = .white
        cityTitleLabel.font = .boldSystemFont(ofSize: 20)
        return cityTitleLabel
    }()

    let cityCelsiusLabel: UILabel = {
        let cityCelsiusLabel = UILabel()
        cityCelsiusLabel.text = "34º"
        cityCelsiusLabel.textColor = .white
        cityCelsiusLabel.font = .boldSystemFont(ofSize: 30)
        return cityCelsiusLabel
    }()

    let mainIndicatorImageView: UIImageView = {
        let mainIndicatorImageView = UIImageView()
        mainIndicatorImageView.image = #imageLiteral(resourceName: "mainIndicator")
        return mainIndicatorImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension WeatherMainTableViewCell: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(nowTimeLabel)
        addSubview(cityTitleLabel)
        addSubview(cityCelsiusLabel)
        addSubview(mainIndicatorImageView)
    }

    func setConstraints() {
//        self.nowTimeLabel.activateAnchors()
    }
}

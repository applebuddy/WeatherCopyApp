//
//  CitySearchTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 06/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class CitySearchTableViewCell: UITableViewCell {
    let searchedCityLabel: UILabel = {
        let searchedCityLabel = UILabel()
        searchedCityLabel.font = .systemFont(ofSize: 12)
        searchedCityLabel.backgroundColor = .clear
        searchedCityLabel.textColor = .white
        return searchedCityLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    func setCellData(cityText: String) {
        searchedCityLabel.text = cityText
    }
}

extension CitySearchTableViewCell: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(searchedCityLabel)
    }

    func makeConstraints() {
        searchedCityLabel.activateAnchors()
        NSLayoutConstraint.activate([
            searchedCityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchedCityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: CommonInset.leftInset * 2),
            searchedCityLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -CommonInset.rightInset),

        ])
    }
}

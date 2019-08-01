//
//  WeatherMainTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherMainTableViewCell: UITableViewCell {
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
    func setSubviews() {}

    func setConstraints() {
//        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
//            self.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
//            self.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
//            self.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
//            ])
    }
}

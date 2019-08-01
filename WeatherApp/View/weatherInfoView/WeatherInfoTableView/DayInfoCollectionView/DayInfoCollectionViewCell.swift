//
//  DayInfoCollectionViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class DayInfoCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        backgroundColor = UIColor.red
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    func setCellData() {
        backgroundColor = UIColor.red
    }
}

extension DayInfoCollectionViewCell: UIViewSettingProtocol {
    func setSubviews() {}

    func setConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            self.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            self.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}

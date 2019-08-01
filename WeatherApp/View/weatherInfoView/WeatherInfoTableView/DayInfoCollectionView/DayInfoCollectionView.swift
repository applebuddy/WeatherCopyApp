//
//  DayInfoCollectionView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class DayInfoCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.lightGray
        setConstraints()
        register(DayInfoCollectionViewCell.self, forCellWithReuseIdentifier: weatherDayInfoCollectionCellIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension DayInfoCollectionView: UIViewSettingProtocol {
    func setSubviews() {}

    func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            self.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

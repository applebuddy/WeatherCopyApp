//
//  WeekInfoTableView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeekInfoTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setConstraints()
        backgroundColor = UIColor.gray
        separatorStyle = .none
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeekInfoTableView: UIViewSettingProtocol {
    func setSubviews() {}

    func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            self.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            self.heightAnchor.constraint(equalToConstant: WeatherViewHeight.weekInfoTableView),
        ])
    }
}

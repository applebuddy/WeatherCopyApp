//
//  WeatherSeparatorTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherSeparatorTableViewCell: UITableViewCell {
    let separatorView: WeatherSeparatorView = {
        let separatorView = WeatherSeparatorView()
        separatorView.backgroundColor = CommonColor.separator
        return separatorView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherSeparatorTableViewCell: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(separatorView)
    }

    func setConstraints() {
        separatorView.activateAnchors()
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            separatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            separatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

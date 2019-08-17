//
//  WeatherSeparatorTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherSeparatorTableViewCell: UITableViewCell {
    // MARK: - UI

    let separatorView: WeatherSeparatorView = {
        let separatorView = WeatherSeparatorView()
        separatorView.backgroundColor = CommonColor.separator
        return separatorView
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeSubviews()
        makeConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherSeparatorTableViewCell: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(separatorView)
    }

    func makeConstraints() {
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

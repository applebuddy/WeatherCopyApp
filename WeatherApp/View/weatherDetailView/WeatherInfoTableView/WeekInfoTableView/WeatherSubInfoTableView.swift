//
//  WeekInfoTableView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 메인 타이틀 하단 서브 날씨정보 테이블뷰
class WeatherSubInfoTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        makeConstraints()
        setTableView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTableView() {
        backgroundColor = .white
        allowsSelection = false
        allowsMultipleSelection = false
        separatorStyle = .none
    }
}

extension WeatherSubInfoTableView: UIViewSettingProtocol {
    func makeSubviews() {}

    func makeConstraints() {
        activateAnchors()
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            self.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            self.heightAnchor.constraint(equalToConstant: WeatherViewHeight.subInfoTableView),
        ])
    }
}

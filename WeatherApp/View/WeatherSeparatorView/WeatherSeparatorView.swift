//
//  WeatherSeparatorView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

// 테이블 뷰 간 틈에 사용되는 Separator 뷰
class WeatherSeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = CommonColor.separator
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherSeparatorView: UIViewSettingProtocol {
    func setSubviews() {}

    func setConstraints() {}
}

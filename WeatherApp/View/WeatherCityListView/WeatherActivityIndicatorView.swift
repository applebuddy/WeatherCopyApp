//
//  WeatherActivityIndicatorView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 06/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherActivityIndicatorView: UIView {
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.hidesWhenStopped = false
        activityIndicatorView.color = .lightGray
        return activityIndicatorView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension WeatherActivityIndicatorView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(activityIndicatorView)
    }

    func makeConstraints() {}
}

//
//  WeatherCitySearchView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherCitySearchView: UIView {
    // MARK: - UI

    let explainSearchLabel: UILabel = {
        let explainSearchLabel = UILabel()
        explainSearchLabel.text = "도시, 우편번호 또는 공항 위치 입력"
        explainSearchLabel.font = .systemFont(ofSize: 12)
        explainSearchLabel.backgroundColor = .black
        explainSearchLabel.textColor = .white
        explainSearchLabel.textAlignment = .center
        return explainSearchLabel
    }()

    let citySearchBar: UISearchBar = {
        let citySearchBar = UISearchBar()
        citySearchBar.barTintColor = .black
        return citySearchBar
    }()

    let backToMainButton: UIButton = {
        let backToMainButton = UIButton(type: .custom)
        backToMainButton.setTitle("취소", for: .normal)
        backToMainButton.setTitleColor(.white, for: .normal)
        backToMainButton.backgroundColor = .black
        return backToMainButton
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = CommonColor.weatherCitySearchView
        makeSubviews()
        makeConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherCitySearchView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(explainSearchLabel)
        addSubview(citySearchBar)
        addSubview(backToMainButton)
    }

    func makeConstraints() {
        explainSearchLabel.activateAnchors()
        NSLayoutConstraint.activate([
            explainSearchLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            explainSearchLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            explainSearchLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            explainSearchLabel.heightAnchor.constraint(equalToConstant: 35),
        ])

        citySearchBar.activateAnchors()
        NSLayoutConstraint.activate([
            citySearchBar.topAnchor.constraint(equalTo: explainSearchLabel.bottomAnchor),
            citySearchBar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            citySearchBar.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
        ])

        backToMainButton.activateAnchors()
        NSLayoutConstraint.activate([
            backToMainButton.topAnchor.constraint(equalTo: explainSearchLabel.bottomAnchor),
            backToMainButton.leftAnchor.constraint(equalTo: citySearchBar.rightAnchor),
            backToMainButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            backToMainButton.bottomAnchor.constraint(equalTo: citySearchBar.bottomAnchor),
        ])
    }
}

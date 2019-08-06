//
//  WeatherMainBottomView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherMainTableViewCell 하단 뷰
/// * **WeatherMainTableViewCell 하단의 버튼기능을 나타낸다.**
public class WeatherMainTableFooterView: UIView {
    let weatherLinkButton: UIButton = {
        let weatherLinkButton = UIButton(type: .custom)
        weatherLinkButton.setImage(UIImage(named: AssetIdentifier.Image.weatherLink), for: .normal)
        weatherLinkButton.contentMode = .scaleAspectFit
        return weatherLinkButton
    }()

    let celsiusToggleButton: UIButton = {
        let celsiusToggleButton = UIButton(type: .custom)
        celsiusToggleButton.contentMode = .center
        return celsiusToggleButton
    }()

    let addCityButton: UIButton = {
        let addCityButton = UIButton(type: .custom)
        addCityButton.setImage(UIImage(named: AssetIdentifier.Image.addCity), for: .normal)
        addCityButton.contentMode = .scaleAspectFit
        return addCityButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFit
        makeSubviews()
        setCelsiusToggleButton()
        makeConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCelsiusToggleButton() {
        let buttonType = CommonData.shared.temperatureType
        switch buttonType {
        case .celsius:
            celsiusToggleButton.setImage(UIImage(named: AssetIdentifier.Image.toggleButtonC), for: .normal)
        case .fahrenheit:
            celsiusToggleButton.setImage(UIImage(named: AssetIdentifier.Image.toggleButtonF), for: .normal)
        }
    }
}

extension WeatherMainTableFooterView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(celsiusToggleButton)
        addSubview(addCityButton)
        addSubview(weatherLinkButton)
    }

    func makeConstraints() {
        addCityButton.activateAnchors()
        NSLayoutConstraint.activate([
            addCityButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CommonInset.topInset),
            addCityButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -CommonInset.rightInset / 2),
            addCityButton.heightAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.height),
            addCityButton.widthAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.width),
        ])

        weatherLinkButton.activateAnchors()
        NSLayoutConstraint.activate([
            weatherLinkButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -CommonInset.bottomInset),
            weatherLinkButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            weatherLinkButton.heightAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.height),
            weatherLinkButton.widthAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.width),
        ])

        celsiusToggleButton.activateAnchors()
        NSLayoutConstraint.activate([
            celsiusToggleButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CommonInset.topInset),
            celsiusToggleButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: CommonInset.leftInset / 2),
            celsiusToggleButton.heightAnchor.constraint(equalTo: addCityButton.heightAnchor),
            celsiusToggleButton.widthAnchor.constraint(equalTo: celsiusToggleButton.heightAnchor, multiplier: 2.5),
        ])
    }
}

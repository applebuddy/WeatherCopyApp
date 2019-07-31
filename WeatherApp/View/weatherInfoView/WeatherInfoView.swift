//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherInfoView: UIView {
    
    let weatherTitleView: WeatherTitleView = {
        let weatherTitleView = WeatherTitleView()
        weatherTitleView.backgroundColor = UIColor.gray
        return weatherTitleView
    }()
    
    let weatherSubTitleView: WeatherSubTitleView = {
        let weatherSubTitleView = WeatherSubTitleView()
        weatherSubTitleView.backgroundColor = UIColor.lightGray
        return weatherSubTitleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.setSubviews()
        self.setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setSubviews() {
        self.addSubview(weatherTitleView)
        self.addSubview(weatherSubTitleView)
    }
    
    func setWeatherTitleViewContraint() {
        self.weatherTitleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTitleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            weatherTitleView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            weatherTitleView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            weatherTitleView.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        self.weatherSubTitleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherSubTitleView.topAnchor.constraint(equalTo: weatherTitleView.bottomAnchor),
            weatherSubTitleView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            weatherSubTitleView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            weatherSubTitleView.heightAnchor.constraint(equalToConstant: 150)
            ])
    }
    
    func setConstraints() {
        self.setWeatherTitleViewContraint()
    }
}

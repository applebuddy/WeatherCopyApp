//
//  WeatherCitySearchViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherCitySearchViewController: UIViewController {
    let weatherCitySearchView: WeatherCitySearchView = {
        let weatherCitySearchView = WeatherCitySearchView()
        return weatherCitySearchView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setButtonTarget()
    }

    override func loadView() {
        super.loadView()
        view = weatherCitySearchView
    }

    func setButtonTarget() {
        weatherCitySearchView.backToMainButton.addTarget(self, action: #selector(backToMainButtonPressed(_:)), for: .touchUpInside)
    }

    @objc func backToMainButtonPressed(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//
//  WeatherCitySearchViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherCitySearchViewController: UIViewController {
    // MARK: - UI

    let weatherCitySearchView: WeatherCitySearchView = {
        let weatherCitySearchView = WeatherCitySearchView()
        return weatherCitySearchView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setCitySearchViewController()
        setButtonTarget()
    }

    override func loadView() {
        super.loadView()
        view = weatherCitySearchView
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        weatherCitySearchView.citySearchBar.becomeFirstResponder()
    }

    // MARK: - Set Method

    func setCitySearchViewController() {
        view.backgroundColor = .black
    }

    func setButtonTarget() {
        weatherCitySearchView.backToMainButton.addTarget(self, action: #selector(backToMainButtonPressed(_:)), for: .touchUpInside)
    }

    // MARK: - Button Event

    @objc func backToMainButtonPressed(_: UIButton) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

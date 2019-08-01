//
//  WeatherMainViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherMainViewController: UIViewController {
    let weatherMainView: WeatherMainView = {
        let weatherMainView = WeatherMainView()
        return weatherMainView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        weatherMainView.weatherMainTableView.delegate = self
        weatherMainView.weatherMainTableView.dataSource = self
    }

    override func loadView() {
        super.loadView()
        view = weatherMainView
    }
}

extension WeatherMainViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        return UIView()
    }

//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherMainViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherMainCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherMainTableCell, for: indexPath) as? WeatherMainTableViewCell else { return UITableViewCell() }

        return weatherMainCell
    }
}

extension WeatherMainViewController: CellSettingProtocol {
    func registerCell() {
        weatherMainView.weatherMainTableView.register(WeatherMainTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherMainTableCell)
    }
}

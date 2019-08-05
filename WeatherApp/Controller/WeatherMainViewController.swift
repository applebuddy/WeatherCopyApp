//
//  WeatherMainViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import UIKit

class WeatherMainViewController: UIViewController {
    // MARK: - Property

    let locationManager = CLLocationManager()

    // MARK: - UI

    let weatherCitySearchViewController: WeatherCitySearchViewController = {
        let weatherCitySearchViewController = WeatherCitySearchViewController()
        return weatherCitySearchViewController
    }()

    let weatherMainView: WeatherMainView = {
        let weatherMainView = WeatherMainView()
        return weatherMainView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainViewController()
        registerCell()
    }

    override func loadView() {
        super.loadView()
        view = weatherMainView
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        checksLocationAuthority()
    }

    // MARK: - Set Method

    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func setMainViewController() {
        weatherMainView.weatherMainTableView.delegate = self
        weatherMainView.weatherMainTableView.dataSource = self
    }

    func setFooterViewButtonTarget(footerView: WeatherMainTableFooterView) {
        footerView.celsiusToggleButton.addTarget(self, action: #selector(celsiusToggleButtonPressed(_:)), for: .touchUpInside)
        footerView.addCityButton.addTarget(self, action: #selector(addCityButtonPressed(_:)), for: .touchUpInside)
        footerView.weatherLinkButton.addTarget(self, action: #selector(weatherLinkButtonPressed(_:)), for: .touchUpInside)
    }

    func makeWeatherMainTableViewEvent(_ scrollView: UIScrollView, offsetY _: CGFloat) {
        if scrollView.contentOffset.y >= 0 {
            scrollView.contentOffset.y = 0
        }
    }

    // MARK: Check Method

    func checkLocationAuthStatus() -> Bool {
        let locationAuthStatus = CLLocationManager.authorizationStatus()
        switch locationAuthStatus {
        case .authorizedAlways,
             .authorizedWhenInUse:
            CommonData.shared.setLocationAuthData(isAuth: true)
        default:
            CommonData.shared.setLocationAuthData(isAuth: false)
        }
        return CommonData.shared.isLocationAuthority
    }

    func checksLocationAuthority() {
        // 사용자가 직접 환경설정에서 위치접근을 설정한 경우를 체그하기 위해 위치권한 상태를 체크한다.
        if !checkLocationAuthStatus() {
            present(weatherCitySearchViewController, animated: true)
        } else {
            setLocationManager()
        }
    }

    // MARK: - Button Event

    @objc func celsiusToggleButtonPressed(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(named: "toggleButton_C") {
            CommonData.shared.changeTemperatureType()
            sender.setImage(UIImage(named: "toggleButton_F"), for: .normal)
        } else {
            CommonData.shared.changeTemperatureType()
            sender.setImage(UIImage(named: "toggleButton_C"), for: .normal)
        }

        DispatchQueue.main.async {
            self.weatherMainView.weatherMainTableView.reloadData()
        }
    }

    @objc func addCityButtonPressed(_: UIButton) {
        present(weatherCitySearchViewController, animated: true, completion: nil)
    }

    @objc func weatherLinkButtonPressed(_: UIButton) {
        let latitude = CommonData.shared.mainCoordinate.latitude
        let longitude = CommonData.shared.mainCoordinate.longitude
        CommonData.shared.openWeatherURL(latitude: latitude, longitude: longitude)
    }
}

// MARK: - UITableView Protocol

extension WeatherMainViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        makeWeatherMainTableViewEvent(scrollView, offsetY: scrollView.contentOffset.y)
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = WeatherSeparatorView()
        headerView.backgroundColor = .white
        return headerView
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        let footerView = WeatherMainTableFooterView()
        footerView.backgroundColor = CommonColor.weatherMainTableFooterView
        setFooterViewButtonTarget(footerView: footerView)
        return footerView
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return WeatherCellHeight.mainTableViewCell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return WeatherViewHeight.weatherMainBottomView
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        CommonData.shared.setSelectedMainCellIndex(index: indexPath.row)
        dismiss(animated: true, completion: nil)
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt _: IndexPath) {
        if cell.isSelected == true {
            cell.setSelected(false, animated: false)
        }
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
        if indexPath.row == 0 {
            guard let weatherMainCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherMainTableCell, for: indexPath) as? WeatherMainTableViewCell else { return UITableViewCell() }
            let mainWeatherData = CommonData.shared.mainWeatherData
            let cityName = CommonData.shared.mainCityName

            guard let timeStamp = mainWeatherData?.currently.time,
                let temperature = mainWeatherData?.hourly.data[0].temperature else { return weatherMainCell }

            weatherMainCell.setMainTableCellData(cityName: cityName, timeStamp: timeStamp, temperature: temperature)
            return weatherMainCell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - CLLocationManager Protocol

extension WeatherMainViewController: CLLocationManagerDelegate {
    /// * **위치가 업데이트 될 때마다 실행 되는 델리게이트 메서드**
    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        if let nowCoordinate = manager.location?.coordinate {
            print("latitude: \(nowCoordinate.latitude), longitude: \(nowCoordinate.longitude)")
            let didEnterForeground = CommonData.shared.getIsAppForegroundValue()
            let originLatitude = CommonData.shared.mainCoordinate.latitude.roundedValue(roundSize: 2)
            let originLongitude = CommonData.shared.mainCoordinate.longitude.roundedValue(roundSize: 2)
            let nowLatitude = nowCoordinate.latitude.roundedValue(roundSize: 2)
            let nowLongitude = nowCoordinate.longitude.roundedValue(roundSize: 2)
            if nowLatitude == originLatitude,
                originLongitude == nowLongitude, didEnterForeground {
                // 만약 최근 위도 경도와 소수점 한자리까지 결과값이 동일하면 API요청을 하지 않는다.
            } else {
                CommonData.shared.setMainCoordinate(latitude: nowCoordinate.latitude, longitude: nowCoordinate.longitude)
                CommonData.shared.setMainCityName(coordinate: nowCoordinate)
                let mainLatitude = CommonData.shared.mainCoordinate.latitude
                let mainLongitude = CommonData.shared.mainCoordinate.longitude

                WeatherAPI.shared.requestAPI(latitude: mainLatitude, longitude: mainLongitude) { weatherAPIData in
                    CommonData.shared.setMainWeatherData(weatherData: weatherAPIData)
                    DispatchQueue.main.async {
                        self.weatherMainView.weatherMainTableView.reloadData()
                    }
                }
                CommonData.shared.setIsAppForegroundValue(isForeground: true)
            }
        }
    }
}

extension WeatherMainViewController: CellSettingProtocol {
    func registerCell() {
        weatherMainView.weatherMainTableView.register(WeatherMainTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherMainTableCell)
    }
}

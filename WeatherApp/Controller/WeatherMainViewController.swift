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
    var mainWeatherData: WeatherAPIData?

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

    func setCityName(coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { placeMarks, error in

            if error != nil {
                print("\(error?.localizedDescription ?? "could not get cityName")")
                return
            }
            guard let address = placeMarks?.first else { return }
            let cityName = address.dictionaryWithValues(forKeys: ["locality"])["locality"]
            guard let cityNameString = cityName as? String else { return }

            CommonData.shared.setMainCityName(cityName: cityNameString)
        }
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
        guard let url = NSURL(string: "https://weather.com/ko-KR/weather/today/l/37.46,126.88?par=apple_widget&locale=ko_KR") else { return }
        UIApplication.shared.open(url as URL)
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
        return WeatherCellHeight.MainTableViewCell
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return WeatherViewHeight.weatherMainBottomView
    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
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
        guard let weatherMainCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherMainTableCell, for: indexPath) as? WeatherMainTableViewCell,
            let weatherMainIndex = WeatherMainTableViewRow(rawValue: indexPath.row) else { return UITableViewCell() }

        switch weatherMainIndex {
        case .mainRow:
            let cityName = CommonData.shared.mainCityName
            let timeStamp = mainWeatherData?.currently.time ?? 0
            let temperature = (mainWeatherData?.hourly.data[0].temperature ?? 0).changeTemperatureFToC().roundedValue(roundSize: 1)

            weatherMainCell.setCellData(cityName: cityName, timeStamp: timeStamp, temperature: temperature)
        case .subRow:
            return weatherMainCell
        }
        return weatherMainCell
    }
}

// MARK: - CLLocationManager Protocol

extension WeatherMainViewController: CLLocationManagerDelegate {
    /// * **위치가 업데이트 될 때마다 실행 되는 델리게이트 메서드**
    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        if let nowCoordinate = manager.location?.coordinate {
            print("latitude: \(nowCoordinate.latitude), longitude: \(nowCoordinate.longitude)")
            let originLatitude = CommonData.shared.mainCoordinate.latitude.roundedValue(roundSize: 2)
            let originLongitude = CommonData.shared.mainCoordinate.longitude.roundedValue(roundSize: 2)
            let nowLatitude = nowCoordinate.latitude.roundedValue(roundSize: 2)
            let nowLongitude = nowCoordinate.longitude.roundedValue(roundSize: 2)
            if nowLatitude == originLatitude,
                originLongitude == nowLongitude {
                // 만약 최근 위도 경도와 소수점 한자리까지 결과값이 동일하면 API요청을 하지 않는다.
                print("지금 위도 경도 같아 호출하지마")
            } else {
                print("지금 위도 경도 최신화 필요해 호출해")
                CommonData.shared.setMainCoordinate(latitude: nowCoordinate.latitude, longitude: nowCoordinate.longitude)
                let mainLatitude = CommonData.shared.mainCoordinate.latitude
                let mainLongitude = CommonData.shared.mainCoordinate.longitude
                setCityName(coordinate: nowCoordinate)

                WeatherAPI.shared.requestAPI(latitude: mainLatitude, longitude: mainLongitude) { weatherAPIData in
                    self.mainWeatherData = weatherAPIData
                    DispatchQueue.main.async {
                        self.weatherMainView.weatherMainTableView.reloadData()
                    }
                }
            }
        }
    }
}

extension WeatherMainViewController: CellSettingProtocol {
    func registerCell() {
        weatherMainView.weatherMainTableView.register(WeatherMainTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherMainTableCell)
    }
}

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
    let weatherDataRefreshControl: UIRefreshControl = UIRefreshControl()
    var isTimeToCheckWeatherData: Bool = true
    let weatherDataCheckInterval: Double = 30.0

    var weatherDataCheckTimer: Timer = {
        let weatherDataCheckTimer = Timer()
        return weatherDataCheckTimer
    }()

    // MARK: - UI

    let weatherCitySearchViewController: WeatherCitySearchViewController = {
        let weatherCitySearchViewController = WeatherCitySearchViewController()
        return weatherCitySearchViewController
    }()

    let weatherMainView: WeatherMainView = {
        let weatherMainView = WeatherMainView()
        return weatherMainView
    }()

    let activityIndicatorContainerView: WeatherActivityIndicatorView = {
        let activityIndicatorContainerView = WeatherActivityIndicatorView()

        activityIndicatorContainerView.activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        return activityIndicatorContainerView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainViewController()
        setActivityIndicatorContainerView()
        setUserDefaultsData()
        registerCell()
        setWeatherDataRefreshControl()
    }

    override func loadView() {
        super.loadView()
        view = weatherMainView
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        checksLocationAuthority()
    }

    override func viewDidAppear(_: Bool) {
        super.viewDidAppear(true)
        requestSubWeatherData()
    }

    // MARK: - Set Method

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setWeatherDataRefreshControl() {
        weatherDataRefreshControl.addTarget(self, action: #selector(refreshWeatherTableViewData(_:)), for: .valueChanged)
        weatherMainView.weatherMainTableView.refreshControl = weatherDataRefreshControl
    }

    func setUserDefaultsData() {
        CommonData.shared.setSubWeatherLocationList()
        CommonData.shared.setSubWeatherDataList()
    }

    func setWeatherDataCheckTimer() {
        weatherDataCheckTimer = Timer.scheduledTimer(timeInterval: weatherDataCheckInterval, target: self, selector: #selector(refreshWeatherDataTimeDidStarted(_:)), userInfo: nil, repeats: true)
    }

    func requestSubWeatherData() {
        DispatchQueue.global().async {
            let subWeatherLocationList = CommonData.shared.subLocationDataList
            for (index, value) in subWeatherLocationList.enumerated() {
                let subCoordinate = value
                WeatherAPI.shared.requestAPI(latitude: subCoordinate.latitude, longitude: subCoordinate.longitude) { subWeatherAPIData in
                    CommonData.shared.setSubWeatherData(subWeatherAPIData, index: index)
                    DispatchQueue.main.async {
                        self.weatherMainView.weatherMainTableView.reloadData()
                        self.stopIndicatorAnimating()
                    }
                }
            }
        }
    }

    func requestMainWeatherData(latitude: Double, longitude: Double, isRequestTime: Bool) {
        CommonData.shared.setMainCoordinate(latitude: latitude, longitude: longitude)
        CommonData.shared.setMainCityName(latitude: latitude, longitude: longitude)

        if isRequestTime {
            let mainLatitude = CommonData.shared.mainCoordinate.latitude
            let mainLongitude = CommonData.shared.mainCoordinate.longitude

            WeatherAPI.shared.requestAPI(latitude: mainLatitude, longitude: mainLongitude) { weatherAPIData in
                CommonData.shared.setMainWeatherData(weatherData: weatherAPIData)
                self.isTimeToCheckWeatherData = false
            }
        }
    }

    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func setMainViewController() {
        makeSubviews()
        weatherMainView.weatherMainTableView.delegate = self
        weatherMainView.weatherMainTableView.dataSource = self
        WeatherAPI.shared.delegate = self
    }

    func setActivityIndicatorContainerView() {}

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
            self.stopIndicatorAnimating()
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

    // MARK: - Animation Event

    @objc func refreshWeatherTableViewData(_: UIRefreshControl) {
        requestSubWeatherData()
    }

    func startIndicatorAnimating() {
        weatherDataRefreshControl.beginRefreshing()
        activityIndicatorContainerView.isHidden = false
        activityIndicatorContainerView.activityIndicatorView.isHidden = false
        activityIndicatorContainerView.activityIndicatorView.startAnimating()
    }

    func stopIndicatorAnimating() {
        activityIndicatorContainerView.isHidden = true
        activityIndicatorContainerView.activityIndicatorView.isHidden = true
        weatherDataRefreshControl.endRefreshing()
        activityIndicatorContainerView.activityIndicatorView.stopAnimating()
    }

    // MARK: - Timer Event

    @objc func refreshWeatherDataTimeDidStarted(_: Timer) {
        isTimeToCheckWeatherData = true
    }
}

// MARK: - UITableView Protocol

// MARK: UITableView Delegate

extension WeatherMainViewController: UITableViewDelegate {
    func scrollViewDidScroll(_: UIScrollView) {}

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        CommonData.shared.setSelectedMainCellIndex(index: indexPath.row)
        dismiss(animated: true, completion: nil)
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt _: IndexPath) {
        if cell.isSelected == true {
            cell.setSelected(false, animated: false)
        }
    }
}

// MARK: UITableView DataSource

extension WeatherMainViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1 + CommonData.shared.subWeatherDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherMainCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherMainTableCell, for: indexPath) as? WeatherMainTableViewCell else { return UITableViewCell() }

        if indexPath.row == 0 {
            weatherMainCell.mainIndicatorImageView.image = UIImage(named: AssetIdentifier.Image.mainIndicator)

            let mainWeatherData = CommonData.shared.mainWeatherData
            let cityName = CommonData.shared.mainCityName
            guard let timeStamp = mainWeatherData?.currently.time,
                let temperature = mainWeatherData?.hourly.data[0].temperature,
                let timeZone = mainWeatherData?.timezone else {
                return weatherMainCell
            }

            weatherMainCell.setMainTableCellData(cityName: cityName, timeStamp: timeStamp, timeZone: timeZone, temperature: temperature)
            return weatherMainCell
        } else {
            let subWeatherData = CommonData.shared.subWeatherDataList[indexPath.row - 1]
            guard let temperature = CommonData.shared.subWeatherDataList[indexPath.row - 1].subData?.currently.temperature,
                let cityName = subWeatherData.subCityName,
                let timeStamp = subWeatherData.subData?.currently.time,
                let timeZone = subWeatherData.subData?.timezone else {
                return weatherMainCell
            }

            weatherMainCell.setMainTableCellData(cityName: cityName, timeStamp: timeStamp, timeZone: timeZone, temperature: temperature)
            weatherMainCell.mainIndicatorImageView.image = nil

            return weatherMainCell
        }
    }

    func tableView(_: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .none
        } else {
            return .delete
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { return }

        if editingStyle == .delete {
            CommonData.shared.subWeatherDataList.remove(at: indexPath.row - 1)
            CommonData.shared.subLocationDataList.remove(at: indexPath.row - 1)
            CommonData.shared.saveSubWeatherDataList()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - CLLocationManager Protocol

extension WeatherMainViewController: CLLocationManagerDelegate {
    /// * **위치가 업데이트 될 때마다 실행 되는 델리게이트 메서드**

    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        guard let latitude = manager.location?.coordinate.latitude,
            let longitude = manager.location?.coordinate.longitude else { return }

        CommonData.shared.setMainCityName(latitude: latitude, longitude: longitude)
        CommonData.shared.setMainCoordinate(latitude: latitude, longitude: longitude)
        requestMainWeatherData(latitude: latitude, longitude: longitude, isRequestTime: isTimeToCheckWeatherData)
    }

    func locationManagerDidResumeLocationUpdates(_: CLLocationManager) {}
}

extension WeatherMainViewController: WeatherAPIDelegate {
    func weatherAPIDidError(_: WeatherAPI) {}

    func weatherAPIDidFinished(_: WeatherAPI) {
        DispatchQueue.main.async {
            self.stopIndicatorAnimating()
            self.weatherMainView.weatherMainTableView.reloadData()
        }
    }

    func weatherAPIDidRequested(_: WeatherAPI) {
        DispatchQueue.main.async {
            self.startIndicatorAnimating()
        }
    }
}

extension WeatherMainViewController: UIViewSettingProtocol {
    func makeSubviews() {
        view.addSubview(activityIndicatorContainerView)
    }

    func makeConstraints() {}
}

extension WeatherMainViewController: CellSettingProtocol {
    func registerCell() {
        weatherMainView.weatherMainTableView.register(WeatherMainTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherMainTableCell)
    }
}

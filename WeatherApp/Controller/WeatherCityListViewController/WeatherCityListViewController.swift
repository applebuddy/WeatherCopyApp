//
//  WeatherMainViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import UIKit

class WeatherCityListViewController: UIViewController {
    // MARK: - Property

    let locationManager = CLLocationManager()
    let weatherDataRefreshControl: UIRefreshControl = UIRefreshControl()
    var isTimeToCheckWeatherData: Bool = true
    let weatherDataCheckInterval: Double = 10

    // Review: [사용성] 해제는 어디서...?? ㅠㅠ
    var weatherDataCheckTimer: Timer = {
        let weatherDataCheckTimer = Timer()
        return weatherDataCheckTimer
    }()

    // MARK: - UI

    let weatherCitySearchViewController: WeatherCitySearchViewController = {
        let weatherCitySearchViewController = WeatherCitySearchViewController()
        return weatherCitySearchViewController
    }()

    let weatherCityListView: WeatherCityListView = {
        let weatherCityListView = WeatherCityListView()
        return weatherCityListView
    }()

    let activityIndicatorContainerView: WeatherActivityIndicatorView = {
        let activityIndicatorContainerView = WeatherActivityIndicatorView()

        // Review: [사용성] UIScreen.main.bounds.size.width 보단 self.view.frame.size.width 를 참조하는 것이 어떨까요?
        activityIndicatorContainerView.activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        return activityIndicatorContainerView
    }()

    lazy var cityListIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        return indicatorView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        cityListIndicatorView = activityIndicatorContainerView.activityIndicatorView
        setCityListViewController()
        setActivityIndicatorContainerView()
        setWeatherDataRefreshControl()
        registerCell()
    }

    override func loadView() {
        view = weatherCityListView
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        checksLocationAuthority()
        // ViewDidAppear 네트워크 작업이나 io, ui 작업 에서 하는 건 어떨가요?
        // https://stackoverflow.com/questions/5630649/what-is-the-difference-between-viewwillappear-and-viewdidappear
        requestMainWeatherData()
        reloadWeatherCityListTableView()
    }

    // MARK: - Set Method

    // Review: [사용성] childForStatusBarStyle 를 사용하는 건 어떨까요?
    // 처음 lightContent를 설정하면 다른 ViewController에서 .default로 하여도 설정되지 않습니다.
    // https://developer.apple.com/documentation/uikit/uiviewcontroller/1621433-childforstatusbarstyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func reloadWeatherCityListTableView() {
        DispatchQueue.main.async {
            self.weatherCityListView.weatherCityListTableView.reloadData()
        }
    }

    func setWeatherDataRefreshControl() {
        weatherDataRefreshControl.isHidden = true
        weatherDataRefreshControl.addTarget(self, action: #selector(refreshWeatherTableViewData(_:)), for: .valueChanged)
        weatherCityListView.weatherCityListTableView.refreshControl = weatherDataRefreshControl
    }

    func setWeatherDataCheckTimer() {
        weatherDataCheckTimer = Timer.scheduledTimer(timeInterval: weatherDataCheckInterval, target: self, selector: #selector(refreshWeatherDataTimeDidStarted(_:)), userInfo: nil, repeats: true)
    }

    func requestSubWeatherData() {
        DispatchQueue.global().async {
            let subWeatherLocationList = CommonData.shared.weatherLocationDataList
            for (index, value) in subWeatherLocationList.enumerated() {
                guard let latitude = value.latitude,
                    let longitude = value.longitude else { return }
                WeatherAPI.shared.requestAPI(latitude: latitude, longitude: longitude) { subWeatherAPIData in
                    CommonData.shared.setWeatherData(subWeatherAPIData, index: index)
                    DispatchQueue.main.async {
                        self.reloadWeatherCityListTableView()
                        // Review: [Refactroing] 정중앙에 acitivityIndicator를 띄우는 것이라면
                        // UITableView의 backgroundView 에서도 설정이 가능합니다.
                        self.cityListIndicatorView.stopCustomIndicatorAnimating(containerView: self.activityIndicatorContainerView)
                    }
                    // Review: [Refactoring] RaceCondition이 발생할 수 있습니다.
                    self.isTimeToCheckWeatherData = false
                }
            }
        }
    }

    func requestMainWeatherData() {
        let mainLatitude = CommonData.shared.mainCoordinate.latitude
        let mainLongitude = CommonData.shared.mainCoordinate.longitude

        WeatherAPI.shared.requestAPI(latitude: mainLatitude, longitude: mainLongitude) { weatherAPIData in
            CommonData.shared.setWeatherData(weatherAPIData, index: 0)
            DispatchQueue.main.async {
                self.reloadWeatherCityListTableView()
            }
            self.requestSubWeatherData()
        }
    }

    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func setCityListViewController() {
        makeSubviews()
        weatherCityListView.weatherCityListTableView.delegate = self
        weatherCityListView.weatherCityListTableView.dataSource = self
        WeatherAPI.shared.delegate = self
    }

    func setActivityIndicatorContainerView() {
        activityIndicatorContainerView.isHidden = true
    }

    func setFooterViewButtonTarget(footerView: WeatherCityListTableFooterView) {
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
        // Review: [사용성] 위치 권한을 사용할 수 없으면 사용자에게 알려줘야 합니다
//        case .denied
//        case .restricted
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
        if sender.image(for: .normal) == UIImage(named: AssetIdentifier.Image.toggleButtonC) {
            CommonData.shared.changeTemperatureType()
            sender.setImage(UIImage(named: AssetIdentifier.Image.toggleButtonF), for: .normal)
        } else {
            CommonData.shared.changeTemperatureType()
            sender.setImage(UIImage(named: AssetIdentifier.Image.toggleButtonC), for: .normal)
        }

        // Review: [Refactoring] 이미 Main 입니다. 불필요한 코드 같아 보여요~
        DispatchQueue.main.async {
            self.cityListIndicatorView.stopCustomIndicatorAnimating(containerView: self.activityIndicatorContainerView)
            self.reloadWeatherCityListTableView()
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
        weatherDataRefreshControl.isHidden = false
        weatherDataRefreshControl.beginRefreshing()
        requestMainWeatherData()
    }

    // MARK: - Timer Event

    @objc func refreshWeatherDataTimeDidStarted(_: Timer) {
        isTimeToCheckWeatherData = true
    }
}

// MARK: - UITableView Protocol

// MARK: UITableView Delegate

extension WeatherCityListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_: UIScrollView) {}

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = WeatherSeparatorView()
        headerView.backgroundColor = .white
        return headerView
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        let footerView = WeatherCityListTableFooterView()
        footerView.backgroundColor = CommonColor.weatherCityListTableFooterView
        setFooterViewButtonTarget(footerView: footerView)
        return footerView
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return WeatherCellHeight.cityListTableViewCell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return WeatherViewHeight.weatherCityListBottomView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        CommonData.shared.setSelectedMainCellIndex(index: indexPath.row)
        dismiss(animated: true, completion: nil)
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt _: IndexPath) {
        // Review: [Refactoring] cell 은 재사용되기 때문에 isSelected 와 같이 상태를 나타내는 것은 데이터모델에서 하는 것이 좋지 않을까요~?
        if cell.isSelected == true {
            cell.setSelected(false, animated: false)
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
            CommonData.shared.weatherDataList.remove(at: indexPath.row)
            CommonData.shared.weatherLocationDataList.remove(at: indexPath.row)
            CommonData.shared.saveWeatherDataList()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: UITableView DataSource

extension WeatherCityListViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return CommonData.shared.weatherDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherMainCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherCityListTableCell, for: indexPath) as? WeatherCityListTableViewCell else { return UITableViewCell() }

        if indexPath.row == 0 {
            weatherMainCell.mainIndicatorImageView.image = UIImage(named: AssetIdentifier.Image.mainIndicator)

            // Review: [Refactoring] 공유하는 데이터는 다른 쪽에서 [0] 을 삭제했을 경우 접근 에러가 발생할 수 있습니다.
            // 데이터는 immutable 상태로 유지하는 것이 좋습니다.
            let mainWeatherData = CommonData.shared.weatherDataList[0].subData

            guard let timeStamp = mainWeatherData?.currently.time,
                let cityName = CommonData.shared.weatherDataList[0].subCityName,
                let temperature = mainWeatherData?.hourly.data[0].temperature,
                let timeZone = mainWeatherData?.timezone else {
                return weatherMainCell
            }

            weatherMainCell.setMainTableCellData(cityName: cityName, timeStamp: timeStamp, timeZone: timeZone, temperature: temperature)
            return weatherMainCell
        } else {
            let subWeatherData = CommonData.shared.weatherDataList[indexPath.row]
            guard let temperature = CommonData.shared.weatherDataList[indexPath.row].subData?.currently.temperature,
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
}

// MARK: - CLLocationManager Protocol

extension WeatherCityListViewController: CLLocationManagerDelegate {
    /// * **위치가 업데이트 될 때마다 실행 되는 델리게이트 메서드**

    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        guard let latitude = manager.location?.coordinate.latitude,
            let longitude = manager.location?.coordinate.longitude else { return }
        if isTimeToCheckWeatherData {
            CommonData.shared.setMainCityName(latitude: latitude, longitude: longitude)
            CommonData.shared.setMainCoordinate(latitude: latitude, longitude: longitude)
            requestMainWeatherData()
        }
    }

    func locationManagerDidResumeLocationUpdates(_: CLLocationManager) {}
}

extension WeatherCityListViewController: WeatherAPIDelegate {
    func weatherAPIDidError(_: WeatherAPI) {
        DispatchQueue.global().async {
            self.isTimeToCheckWeatherData = false
            DispatchQueue.main.async {
                self.weatherDataRefreshControl.endRefreshing()
                self.cityListIndicatorView.stopCustomIndicatorAnimating(containerView: self.activityIndicatorContainerView)
            }
        }
    }

    func weatherAPIDidFinished(_: WeatherAPI) {
        DispatchQueue.main.async {
            self.weatherDataRefreshControl.endRefreshing()
            self.weatherDataRefreshControl.isHidden = true
            self.cityListIndicatorView.stopCustomIndicatorAnimating(containerView: self.activityIndicatorContainerView)
        }
    }

    func weatherAPIDidRequested(_: WeatherAPI) {
        DispatchQueue.main.async {
            self.cityListIndicatorView.startCustomIndicatorAnimating(containerView: self.activityIndicatorContainerView)
        }
    }
}

extension WeatherCityListViewController: UIViewSettingProtocol {
    func makeSubviews() {
        view.addSubview(activityIndicatorContainerView)
    }

    func makeConstraints() {}
}

extension WeatherCityListViewController: CellSettingProtocol {
    func registerCell() {
        weatherCityListView.weatherCityListTableView.register(WeatherCityListTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherCityListTableCell)
    }
}

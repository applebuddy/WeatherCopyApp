//
//  ContentViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 07/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class WeatherDetailContentViewController: UIViewController {
    // MARK: - Property

    let locationManager = CLLocationManager()
    var headerHeightConstraint: NSLayoutConstraint?
    var nowWeatherData: WeatherAPIData?
    var isAppearViewController = false
    var pageViewControllerIndex = 0

    // MARK: - UI

    lazy var weatherMainViewController: WeatherCityListViewController = {
        let weatherMainViewController = WeatherCityListViewController()
        return weatherMainViewController
    }()

    let listBarButton: UIButton = {
        let listBarButton = UIButton(type: .custom)
        listBarButton.setImage(UIImage(named: AssetIdentifier.Image.weatherList), for: .normal)
        return listBarButton
    }()

    let presentViewButton: UIButton = {
        let presentViewButton = UIButton(type: .custom)
        presentViewButton.setTitleColor(.lightGray, for: .normal)
        presentViewButton.backgroundColor = .white
        return presentViewButton
    }()

    let contentView: weatherDetailView = {
        let contentView = weatherDetailView()
        return contentView
    }()

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setInfoViewController()
        setInfoView()
        registerCell()
        setTableHeaderView()
        makeConstraints()
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        isAppearViewController = false

        DispatchQueue.main.async {
            self.setWeatherData()
            self.contentView.weatherTitleView.layoutIfNeeded()
            self.contentView.layoutIfNeeded()
        }
    }

    // MARK: - Set Method

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func setWeatherData() {
        guard let nowWeatherData = CommonData.shared.weatherDataList[CommonData.shared.selectedMainCellIndex].subData,
            let infoViewTitle = CommonData.shared.weatherDataList[CommonData.shared.selectedMainCellIndex].subCityName else { return }
        let infoViewSubTitle = nowWeatherData.currently.summary
        contentView.setInfoViewData(title: infoViewTitle, subTitle: infoViewSubTitle)
    }

    func setInfoViewController() {
        view.backgroundColor = CommonColor.weatherInfoView
    }

    func setInfoView() {
        contentView.weatherInfoTableView.dataSource = self
        contentView.weatherInfoTableView.delegate = self
    }

    func setTableHeaderView() {
        headerHeightConstraint = contentView.weatherInfoTableHeaderView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.detailTableHeaderCell)
        headerHeightConstraint?.isActive = true
    }

    func makeWeatherInfoTableHeaderViewScrollEvent(_ scrollView: UIScrollView, offsetY _: CGFloat) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = CGFloat.zero
        }
        let height = CGFloat(max(0, WeatherCellHeight.detailTableHeaderCell - max(0, scrollView.contentOffset.y)))
        let alphaValue = pow(height / WeatherCellHeight.detailTableHeaderCell, 10)
        contentView.weatherInfoTableHeaderView.setTableHeaderViewAlpha(alpha: CGFloat(alphaValue))
    }

    // MARK: Check Event

    // MARK: - Button Event

//
//    @objc func linkButtonPressed(_: UIButton) {
//        // ✭ URL 링크주소는 파싱구현 이후 다시 수정한다.
//        let latitude = CommonData.shared.mainCoordinate.latitude
//        let longitude = CommonData.shared.mainCoordinate.longitude
//        CommonData.shared.openWeatherURL(latitude: latitude, longitude: longitude)
//    }
//
//    @objc func listButtonPressed(_: UIButton) {
//        present(weatherMainViewController, animated: true, completion: nil)
//    }
//
//    @objc func presentViewButtonPressed(_: UIButton) {}
}

// MARK: - UITableView Protocol

extension WeatherDetailContentViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        makeWeatherInfoTableHeaderViewScrollEvent(scrollView, offsetY: scrollView.contentOffset.y)
    }

    // * WeatherData 갱신 시 DayInfoCollectionViewCell을 리로드 해준다.
    func tableView(_ tableView: UITableView, didEndDisplaying _: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let rowIndex = WeatherDetailTableViewRow(rawValue: indexPath.row) else { return }

        switch rowIndex {
        case .hourInfoRow: break
//            guard let dayInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherHourInfoTableCell, for: indexPath) as? WeatherHourInfoTableViewCell else { return }
        default: break
        }
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIndex = WeatherDetailTableViewSection(rawValue: section) else { return UIView() }
        switch sectionIndex {
        case .mainSection:

            let weatherInfoTableHeaderView = contentView.weatherInfoTableHeaderView
            let weatherData = CommonData.shared.weatherDataList[pageViewControllerIndex].subData
            guard let mainCelsius = weatherData?.currently.temperature,
                let minCelsius = weatherData?.daily.data[pageViewControllerIndex].temperatureLow,
                let maxCelsius = weatherData?.daily.data[pageViewControllerIndex].temperatureHigh,
                let timeStamp = weatherData?.currently.time else { return weatherInfoTableHeaderView }

            weatherInfoTableHeaderView.setHeaderViewData(mainCelsius: mainCelsius, minCelsius: minCelsius, maxCelsius: maxCelsius, timeStamp: timeStamp)

            return weatherInfoTableHeaderView
        }
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        return WeatherSeparatorView()
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return CGFloat.leastNonzeroMagnitude
        }
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension WeatherDetailContentViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherHourInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherHourInfoTableCell, for: indexPath) as? WeatherHourInfoTableViewCell,
            let weatherWeekInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherWeekInfoTableCell, for: indexPath) as? WeatherSubInfoTableViewCell,
            let rowIndex = WeatherDetailTableViewRow(rawValue: indexPath.row) else { return UITableViewCell() }

        switch rowIndex {
        case .hourInfoRow:
            weatherHourInfoCell.setCellData()

            return weatherHourInfoCell
        case .separatorRow: return WeatherSeparatorTableViewCell()
        case .weekInfoRow:
            return weatherWeekInfoCell
        }
    }
}

extension WeatherDetailContentViewController: CLLocationManagerDelegate {
    /// * **위치가 업데이트 될 때마다 실행 되는 델리게이트 메서드**

    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        if let nowCoordinate = manager.location?.coordinate {
            CommonData.shared.setMainCityName(latitude: nowCoordinate.latitude, longitude: nowCoordinate.longitude)
            let nowLatitude = nowCoordinate.latitude.roundedValue(roundSize: 2)
            let nowLongitude = nowCoordinate.longitude.roundedValue(roundSize: 2)

            CommonData.shared.setMainCityName(latitude: nowLatitude, longitude: nowLongitude)
            if !isAppearViewController {
                CommonData.shared.setMainCoordinate(latitude: nowLatitude, longitude: nowLongitude)
                let mainLatitude = CommonData.shared.mainCoordinate.latitude
                let mainLongitude = CommonData.shared.mainCoordinate.longitude

                WeatherAPI.shared.requestAPI(latitude: mainLatitude, longitude: mainLongitude) { weatherAPIData in
                    CommonData.shared.setMainWeatherData(weatherData: weatherAPIData)

                    DispatchQueue.global().async {
                        self.setWeatherData()
                        self.isAppearViewController = true
                    }
                }
            }
        }
    }
}

// MARK: - Custom View Protocol

extension WeatherDetailContentViewController: UIViewSettingProtocol {
    func makeSubviews() {}

    func makeConstraints() {}
}

extension WeatherDetailContentViewController: CellSettingProtocol {
    func registerCell() {
        contentView.weatherInfoTableView.register(WeatherHourInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherHourInfoTableCell)
        contentView.weatherInfoTableView.register(WeatherSubInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherWeekInfoTableCell)
    }
}

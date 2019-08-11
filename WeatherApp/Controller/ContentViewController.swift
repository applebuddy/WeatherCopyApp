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

class ContentViewController: UIViewController {
    // MARK: - Property

    let locationManager = CLLocationManager()
    var headerHeightConstraint: NSLayoutConstraint?
    var nowWeatherData: WeatherAPIData?
    var pageViewControllerIndex = 0
    var isAppearViewController = false

    // MARK: - UI

    lazy var weatherMainViewController: WeatherMainViewController = {
        let weatherMainViewController = WeatherMainViewController()
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

    let contentView: WeatherInfoView = {
        let contentView = WeatherInfoView()
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
        setWeatherData()
        isAppearViewController = false

        DispatchQueue.main.async {
            self.setWeatherData()
            self.view.layoutIfNeeded()
            self.contentView.weatherTitleView.layoutIfNeeded()
            self.contentView.layoutIfNeeded()
            self.contentView.weatherInfoTableView.reloadData()
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
        let weatherViewIndex = CommonData.shared.selectedMainCellIndex
        if weatherViewIndex == 0 {
            nowWeatherData = CommonData.shared.weatherDataList[0].subData
            let infoViewTitle = CommonData.shared.mainCityName
            guard let infoViewSubTitle = nowWeatherData?.currently.summary else { return }
            contentView.setInfoViewData(title: infoViewTitle,
                                        subTitle: infoViewSubTitle)
        } else {
            guard let nowWeatherData = CommonData.shared.weatherDataList[weatherViewIndex].subData,
                let infoViewTitle = CommonData.shared.weatherDataList[weatherViewIndex].subCityName else { return }
            let infoViewSubTitle = nowWeatherData.currently.summary
            contentView.setInfoViewData(title: infoViewTitle, subTitle: infoViewSubTitle)
        }
    }

    func setInfoViewController() {
        view.backgroundColor = CommonColor.weatherInfoView
    }

    func setInfoView() {
        contentView.weatherInfoTableView.dataSource = self
        contentView.weatherInfoTableView.delegate = self
    }

    func setTableHeaderView() {
        headerHeightConstraint = contentView.weatherInfoTableHeaderView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.infoTableHeaderCell)
        headerHeightConstraint?.isActive = true
    }

    func makeWeatherInfoTableHeaderViewScrollEvent(_ scrollView: UIScrollView, offsetY _: CGFloat) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = CGFloat.zero
        }
        let height = CGFloat(max(0, WeatherCellHeight.infoTableHeaderCell - max(0, scrollView.contentOffset.y)))
        let alphaValue = pow(height / WeatherCellHeight.infoTableHeaderCell, 10)
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

extension ContentViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        makeWeatherInfoTableHeaderViewScrollEvent(scrollView, offsetY: scrollView.contentOffset.y)
    }

    // * WeatherData 갱신 시 DayInfoCollectionViewCell을 리로드 해준다.
    func tableView(_ tableView: UITableView, didEndDisplaying _: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let rowIndex = WeatherInfoTableViewRow(rawValue: indexPath.row) else { return }

        switch rowIndex {
        case .hourInfoRow:
            guard let dayInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherHourInfoTableCell, for: indexPath) as? WeatherHourInfoTableViewCell else { return }
        default: break
        }
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIndex = WeatherInfoTableViewSection(rawValue: section) else { return UIView() }
        switch sectionIndex {
        case .mainSection:

            let weatherInfoTableHeaderView = contentView.weatherInfoTableHeaderView
            let weatherData = CommonData.shared.weatherDataList[0].subData
            guard let mainCelsius = weatherData?.currently.temperature,
                let minCelsius = weatherData?.daily.data[0].temperatureLow,
                let maxCelsius = weatherData?.daily.data[0].temperatureHigh,
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

extension ContentViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherHourInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherHourInfoTableCell, for: indexPath) as? WeatherHourInfoTableViewCell,
            let weatherWeekInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherWeekInfoTableCell, for: indexPath) as? WeatherSubInfoTableViewCell,
            let rowIndex = WeatherInfoTableViewRow(rawValue: indexPath.row) else { return UITableViewCell() }

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

extension ContentViewController: CLLocationManagerDelegate {
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

                    DispatchQueue.main.async {
                        self.setWeatherData()
                        self.view.layoutIfNeeded()
                        self.contentView.weatherTitleView.layoutIfNeeded()
                        self.contentView.layoutIfNeeded()
                        self.contentView.weatherInfoTableView.reloadData()
                    }
                }
                isAppearViewController = true
            }
        }
    }
}

// MARK: - Custom View Protocol

extension ContentViewController: UIViewSettingProtocol {
    func makeSubviews() {}

    func makeConstraints() {
//        linkBarButton.activateAnchors()
//        NSLayoutConstraint.activate([
//            linkBarButton.heightAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.height),
//            linkBarButton.widthAnchor.constraint(equalTo: linkBarButton.heightAnchor, multiplier: 1.0),
//        ])
//
//        listBarButton.activateAnchors()
//        NSLayoutConstraint.activate([
//            listBarButton.heightAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.height),
//            listBarButton.widthAnchor.constraint(equalTo: listBarButton.heightAnchor, multiplier: 1.0),
//        ])
    }
}

extension ContentViewController: CellSettingProtocol {
    func registerCell() {
        contentView.weatherInfoTableView.register(WeatherHourInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherHourInfoTableCell)
        contentView.weatherInfoTableView.register(WeatherSubInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherWeekInfoTableCell)
    }
}

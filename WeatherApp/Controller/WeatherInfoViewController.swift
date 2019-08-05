//
//  ViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class WeatherInfoViewController: UIViewController {
    // MARK: - Property

    let locationManager = CLLocationManager()
    var headerHeightConstraint: NSLayoutConstraint?
    var nowWeatherData: WeatherAPIData?
    var isAppearViewController = false

    // MARK: - UI

    lazy var weatherMainViewController: WeatherMainViewController = {
        let weatherMainViewController = WeatherMainViewController()
        return weatherMainViewController
    }()

    let linkBarButton: UIButton = {
        let linkBarButton = UIButton(type: .custom)
        linkBarButton.setImage(#imageLiteral(resourceName: "weatherLink"), for: .normal)
        return linkBarButton
    }()

    let listBarButton: UIButton = {
        let listBarButton = UIButton(type: .custom)
        listBarButton.setImage(#imageLiteral(resourceName: "weatherList"), for: .normal)
        return listBarButton
    }()

    let presentViewButton: UIButton = {
        let presentViewButton = UIButton(type: .custom)
        presentViewButton.setTitleColor(.lightGray, for: .normal)
        presentViewButton.backgroundColor = .white
        return presentViewButton
    }()

    let weatherInfoView: WeatherInfoView = {
        let weatherInfoView = WeatherInfoView()
        return weatherInfoView
    }()

    let weatherInfoTableHeaderView: WeatherInfoTableHeaderView = {
        let weatherInfoTableHeaderView = WeatherInfoTableHeaderView()
        weatherInfoTableHeaderView.contentMode = .scaleAspectFill
        return weatherInfoTableHeaderView
    }()

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        view = weatherInfoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(CommonData.shared.isLocationAuthority)
        setInfoViewController()
        registerCell()
        setLocationManager()
        setInfoView()
        setButtonTarget()
        setToolBarButtonItem()
        setTableHeaderView()
        makeConstraints()
        presentToMainView()
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        setWeatherTitleViewData()
        isAppearViewController = false
    }

    // MARK: - Set Method

    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func setWeatherTitleViewData() {
        let weatherViewIndex = CommonData.shared.selectedMainCellIndex
        if weatherViewIndex == 0 {
            print("메인날씨 뷰컨트롤러 진입")
            nowWeatherData = CommonData.shared.mainWeatherData
            let infoViewTitle = CommonData.shared.mainCityName
            guard let infoViewSubTitle = nowWeatherData?.currently.summary else { return }
            weatherInfoView.setInfoViewData(title: infoViewTitle,
                                            subTitle: infoViewSubTitle)
        }
    }

    func setInfoViewController() {
        view.backgroundColor = CommonColor.weatherInfoView
    }

    func setInfoView() {
        weatherInfoView.weatherInfoTableView.dataSource = self
        weatherInfoView.weatherInfoTableView.delegate = self
    }

    func setButtonTarget() {
        linkBarButton.addTarget(self, action: #selector(linkButtonPressed(_:)), for: .touchUpInside)
        presentViewButton.addTarget(self, action: #selector(presentViewButtonPressed(_:)), for: .touchUpInside)
        listBarButton.addTarget(self, action: #selector(listButtonPressed(_:)), for: .touchUpInside)
    }

    func setTableHeaderView() {
        headerHeightConstraint = weatherInfoTableHeaderView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.infoTableHeaderCell)
        headerHeightConstraint?.isActive = true
    }

    func setToolBarButtonItem() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let barButtonItem = UIBarButtonItem(customView: linkBarButton)
        let barButtonItem2 = UIBarButtonItem(customView: presentViewButton)
        let barButtonItem3 = UIBarButtonItem(customView: listBarButton)
        let toolBarItems = [barButtonItem, flexibleSpace, barButtonItem2, flexibleSpace, barButtonItem3]
        toolbarItems = toolBarItems
        navigationController?.setToolbarHidden(false, animated: false)
        hidesBottomBarWhenPushed = false
    }

    func makeWeatherInfoTableHeaderViewScrollEvent(_ scrollView: UIScrollView, offsetY _: CGFloat) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = CGFloat.zero
        }
        let height = CGFloat(max(0, WeatherCellHeight.infoTableHeaderCell - max(0, scrollView.contentOffset.y)))
        let alphaValue = pow(height / WeatherCellHeight.infoTableHeaderCell, 10)
        weatherInfoTableHeaderView.setTableHeaderViewAlpha(alpha: CGFloat(alphaValue))
    }

    // MARK: Check Event

    func presentToMainView() {
        present(weatherMainViewController, animated: false)
    }

    // MARK: - Button Event

    @objc func linkButtonPressed(_: UIButton) {
        // ✭ URL 링크주소는 파싱구현 이후 다시 수정한다.
        let latitude = CommonData.shared.mainCoordinate.latitude
        let longitude = CommonData.shared.mainCoordinate.longitude
        CommonData.shared.openWeatherURL(latitude: latitude, longitude: longitude)
    }

    @objc func listButtonPressed(_: UIButton) {
        present(weatherMainViewController, animated: true, completion: nil)
    }

    @objc func presentViewButtonPressed(_: UIButton) {}
}

// MARK: - UITableView Protocol

extension WeatherInfoViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        makeWeatherInfoTableHeaderViewScrollEvent(scrollView, offsetY: scrollView.contentOffset.y)
    }

    // * WeatherData 갱신 시 DayInfoCollectionViewCell을 리로드 해준다.
    func tableView(_ tableView: UITableView, didEndDisplaying _: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let rowIndex = WeatherInfoTableViewRow(rawValue: indexPath.row) else { return }

        switch rowIndex {
        case .dayInfoRow:
            guard let dayInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherDayInfoTableCell, for: indexPath) as? WeatherDayInfoTableViewCell else { return }
            DispatchQueue.main.async {
                // 24시간 날씨정보 컬렉션뷰 셀을 리로드 한다.
                dayInfoCell.dayInfoCollectionView.reloadData()
            }
        default: break
        }
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIndex = WeatherInfoTableViewSection(rawValue: section) else { return UIView() }
        switch sectionIndex {
        case .mainSection:
            let weatherData = CommonData.shared.mainWeatherData
            var mainCelsius = weatherData?.currently.temperature ?? 0.0
            var minCelsius = weatherData?.daily.data[0].temperatureLow ?? 0.0
            var maxCelsius = weatherData?.daily.data[0].temperatureHigh ?? 0.0
            var nowDate: String
            if let timeStamp = weatherData?.currently.time {
                let date = Date(timeIntervalSince1970: Double(timeStamp))
                nowDate = CommonData.shared.infoHeaderDateFormatter.string(from: date)
            } else {
                nowDate = "-"
            }

            if CommonData.shared.temperatureType == .celsius,
                mainCelsius != 0, minCelsius != 0, maxCelsius != 0 {
                mainCelsius = mainCelsius.changeTemperatureFToC().roundedValue(roundSize: 1)
                minCelsius = minCelsius.changeTemperatureFToC().roundedValue(roundSize: 1)
                maxCelsius = maxCelsius.changeTemperatureFToC().roundedValue(roundSize: 1)
            }

            weatherInfoTableHeaderView.setHeaderViewData(mainCelsius: mainCelsius, minCelusius: minCelsius, maxCelsius: maxCelsius, date: nowDate)

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

extension WeatherInfoViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherDayInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherDayInfoTableCell, for: indexPath) as? WeatherDayInfoTableViewCell,
            let weatherWeekInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherWeekInfoTableCell, for: indexPath) as? WeatherSubInfoTableViewCell,
            let rowIndex = WeatherInfoTableViewRow(rawValue: indexPath.row) else { return UITableViewCell() }

        switch rowIndex {
        case .dayInfoRow:
            weatherDayInfoCell.setCellData()

            return weatherDayInfoCell
        case .separatorRow: return WeatherSeparatorTableViewCell()
        case .weekInfoRow:
            return weatherWeekInfoCell
        }
    }
}

// MARK: - CLLocationManager Protocol

extension WeatherInfoViewController: CLLocationManagerDelegate {
    /// * **위치가 업데이트 될 때마다 실행 되는 델리게이트 메서드**

    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        if let nowCoordinate = manager.location?.coordinate {
            CommonData.shared.setMainCityName(coordinate: nowCoordinate)
            let nowLatitude = nowCoordinate.latitude.roundedValue(roundSize: 2)
            let nowLongitude = nowCoordinate.longitude.roundedValue(roundSize: 2)

            setWeatherTitleViewData()
            view.layoutIfNeeded()
            if !isAppearViewController {
                print("지금 위도 경도 최신화 필요해 호출해")
                CommonData.shared.setMainCoordinate(latitude: nowLatitude, longitude: nowLongitude)
                let mainLatitude = CommonData.shared.mainCoordinate.latitude
                let mainLongitude = CommonData.shared.mainCoordinate.longitude

                WeatherAPI.shared.requestAPI(latitude: mainLatitude, longitude: mainLongitude) { weatherAPIData in
                    CommonData.shared.setMainWeatherData(weatherData: weatherAPIData)
                    print("asds: \(CommonData.shared.mainCityName)")
                    DispatchQueue.main.async {
                        self.view.layoutIfNeeded()
                        self.weatherInfoTableHeaderView.layoutIfNeeded()
                        self.weatherInfoView.weatherInfoTableView.reloadData()
                    }
                }
                isAppearViewController = true
            }
        }
    }
}

// MARK: - Custom View Protocol

extension WeatherInfoViewController: UIViewSettingProtocol {
    func makeSubviews() {}

    func makeConstraints() {
        linkBarButton.activateAnchors()
        NSLayoutConstraint.activate([
            linkBarButton.heightAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.height),
            linkBarButton.widthAnchor.constraint(equalTo: linkBarButton.heightAnchor, multiplier: 1.0),
        ])
        listBarButton.activateAnchors()
        NSLayoutConstraint.activate([
            listBarButton.heightAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.height),
            listBarButton.widthAnchor.constraint(equalTo: listBarButton.heightAnchor, multiplier: 1.0),
        ])
    }
}

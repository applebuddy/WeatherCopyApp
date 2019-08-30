//
//  WeatherCitySearchViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class WeatherCitySearchViewController: UIViewController {
    // MARK: - Property

    // ✓ REVIEW: [Refactoring] Singleton으로 제공하는 건 어떨까요?
    // 대부분의 ViewController에서 locationManager가 사용된다. 싱글턴으로 만들어 사용하면 보다 유연하게 객체를 사용할 수 있다.
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    private let completer = MKLocalSearchCompleter()
    private var displayedResultList = [String]()
    private var citySearchBar: UISearchBar?

    // MARK: - UI

    private let weatherCitySearchView: WeatherCitySearchView = {
        let weatherCitySearchView = WeatherCitySearchView()
        return weatherCitySearchView
    }()

    private let activityIndicatorContainerView: WeatherActivityIndicatorView = {
        let activityIndicatorContainerView = WeatherActivityIndicatorView()
        activityIndicatorContainerView.isHidden = true
        activityIndicatorContainerView.activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        return activityIndicatorContainerView
    }()

    /*
     Review: 굳이?
     
     private lazy var citySearchIndicatorView: UIActivityIndicatorView = {
     return UIActivityIndicatorView()
     }(
     
     */
    private lazy var citySearchIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        return indicatorView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchIndicatorView = activityIndicatorContainerView.activityIndicatorView
        setCitySearchViewController()
        registerCell()
        weatherCitySearchView.citySearchTableView.delegate = self
        weatherCitySearchView.citySearchTableView.dataSource = self
    }

    override func loadView() {
        view = weatherCitySearchView
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        // REVIEW: [사용성] 즉시 키보드를 보여주는 것보다 Delay 이후에 보여주는 것이 좀 더 부드럽지 않을까요?
        // 유저 입장에서 보다 자연스러운 앱 실행 및 진행이 될 수 있도록 신경쓰자
        // Concurrent Async로 0.1초 지연 후 실행시킨다.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.weatherCitySearchView.citySearchBar.becomeFirstResponder()
        }
        requestLocationAuthority()
    }

    // MARK: - Set Method

    private func setButtonTarget() {
        weatherCitySearchView.backToMainButton.addTarget(self, action: #selector(backToMainButtonPressed(_:)), for: .touchUpInside)
    }

    // MARK: Set Location Method

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func calculateDefaultCityName(placeMarks: [CLPlacemark]) -> String {
        var defaultCityName = "-"
        if let cityName = placeMarks.first?.dictionaryWithValues(forKeys: ["locality"])["locality"] {
            if let cityName = cityName as? String {
                defaultCityName = cityName
            }
        } else {
            if let cityName = placeMarks.first?.administrativeArea {
                defaultCityName = cityName
            }
        }

        return defaultCityName
    }

    private func requestLocationAuthority() {
        // 현재 위치권한이 있는지 유무를 확인한다.
        let locationAuthStatus = CLLocationManager.authorizationStatus()
        switch locationAuthStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways,
             .authorizedWhenInUse:
            CommonData.shared.setLocationAuthData(isAuth: true)
        default:
            presentLocationAuthAlertController()
        }
    }

    private func setLocationManager() {
        locationManager.delegate = self
        completer.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    private func setCitySearchViewController() {
        makeSubviews()
        view.backgroundColor = .black
        setButtonTarget()
        setLocationManager()
        citySearchBar = weatherCitySearchView.citySearchBar
        citySearchBar?.delegate = self
    }

    private func resetDisplayedCityList() {
        displayedResultList = []
    }

    // MARK: - Alert Event

    private func presentLocationDataErrorAlertController() {
        let errorAlertController = UIAlertController(title: "위치정보 흭득실패", message: "해당 위치정보를 얻는데 실패했습니다. 정확한 지역, 다른 지역을 선택해주세요.", preferredStyle: .alert)
        let errorAlertAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        errorAlertController.addAction(errorAlertAction)
        present(errorAlertController, animated: true, completion: nil)
    }

    private func presentLocationAuthAlertController() {
        guard let appSettingURL = URL(string: UIApplication.openSettingsURLString) else { return }

        let authAlertController = UIAlertController(title: "위치 권한 요청", message: "날씨정보를 받기 위해 위치권한이 필요합니다. 위치권한을 설정하시겠습니까?", preferredStyle: .alert)
        let goToAuthSettingAlertAction = UIAlertAction(title: "네 알겠습니다.", style: .default) { _ in
            UIApplication.shared.open(appSettingURL, options: [:], completionHandler: nil)
        }
        let cancelAlertAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        authAlertController.addAction(goToAuthSettingAlertAction)
        authAlertController.addAction(cancelAlertAction)
        present(authAlertController, animated: true, completion: nil)
    }

    // MARK: - Button Event

    @objc private func backToMainButtonPressed(_: UIButton) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - SearchBar Protocol

extension WeatherCitySearchViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        resetDisplayedCityList()
        completer.queryFragment = "\(searchText)"
        completerDidUpdateResults(completer)
    }
}

extension WeatherCitySearchViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return WeatherCellHeight.citySearchTableView
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return WeatherViewHeight.citySearchTableFooterView
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        let separatorView = WeatherSeparatorView()
        return separatorView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        citySearchIndicatorView.startCustomIndicatorAnimating(containerView: activityIndicatorContainerView)
        geoCoder.geocodeAddressString(displayedResultList[indexPath.row]) { placemarks, error in

            if error != nil {
                self.citySearchIndicatorView.stopCustomIndicatorAnimating(containerView: self.activityIndicatorContainerView)
                self.presentLocationDataErrorAlertController()
            }

            guard let placeMarks = placemarks,
                let location = placeMarks.first?.location else {
                self.citySearchIndicatorView.stopCustomIndicatorAnimating(containerView: self.activityIndicatorContainerView)
                self.presentLocationDataErrorAlertController()
                return
            }

            let defaultCityName = self.calculateDefaultCityName(placeMarks: placeMarks)

            CommonData.shared.addSubWeatherData(coordinate: location.coordinate, defaultCityName: defaultCityName) { isSucceed in
                self.citySearchIndicatorView.stopCustomIndicatorAnimating(containerView: self.activityIndicatorContainerView)
                if isSucceed {
                    CommonData.shared.saveWeatherDataList()
                    self.dismiss(animated: true)
                } else {
                    self.presentLocationDataErrorAlertController()
                }
            }
        }
    }
}

extension WeatherCitySearchViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return displayedResultList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let citySearchTableCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.citySearchTableCell, for: indexPath) as? CitySearchTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            if displayedResultList.isEmpty {
                citySearchTableCell.searchedCityLabel.text = "검색 된 결과가 현재 없습니다."
            }
        }

        if displayedResultList.isEmpty {
            return citySearchTableCell
        }

        citySearchTableCell.setCellData(cityText: displayedResultList[indexPath.row])

        return citySearchTableCell
    }
}

// MARK: MapKit Protocol

extension WeatherCitySearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        _ = completer.results.map { result in
            let searchedCity = "\(result.title + ", " + result.subtitle)"
            displayedResultList.append(searchedCity)
        }
        DispatchQueue.main.async {
            self.weatherCitySearchView.citySearchTableView.reloadData()
        }
    }
}

// MARK: - CLLocationManager Protocol

extension WeatherCitySearchViewController: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didChangeAuthorization _: CLAuthorizationStatus) {
        let locationAuthStatus = CLLocationManager.authorizationStatus()
        switch locationAuthStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            CommonData.shared.setLocationAuthData(isAuth: true)
        default:
            break
        }
    }
}

extension WeatherCitySearchViewController: CellSettingProtocol {
    func registerCell() {
        weatherCitySearchView.citySearchTableView.register(CitySearchTableViewCell.self, forCellReuseIdentifier: CellIdentifier.citySearchTableCell)
    }
}

extension WeatherCitySearchViewController: UIViewSettingProtocol {
    func makeSubviews() {
        view.addSubview(activityIndicatorContainerView)
    }

    func makeConstraints() {}
}

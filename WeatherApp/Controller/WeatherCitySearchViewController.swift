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

    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    let completer = MKLocalSearchCompleter()
    var searchCiryList = [String: CLLocationCoordinate2D]()
    var displayedResultList = [String]()

    // MARK: - UI

    let weatherCitySearchView: WeatherCitySearchView = {
        let weatherCitySearchView = WeatherCitySearchView()
        return weatherCitySearchView
    }()

    var citySearchBar: UISearchBar?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setCitySearchViewController()
        registerCell()
        weatherCitySearchView.citySearchTableView.delegate = self
        weatherCitySearchView.citySearchTableView.dataSource = self
    }

    override func loadView() {
        super.loadView()
        view = weatherCitySearchView
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        weatherCitySearchView.citySearchBar.becomeFirstResponder()
        requestLocationAuthority()
    }

    // MARK: - Set Method

    func setButtonTarget() {
        weatherCitySearchView.backToMainButton.addTarget(self, action: #selector(backToMainButtonPressed(_:)), for: .touchUpInside)
    }

    // MARK: Set Location Method

    func requestLocationAuthority() {
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

    func setLocationManager() {
        locationManager.delegate = self
        completer.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func setCitySearchViewController() {
        view.backgroundColor = .black
        setButtonTarget()
        setLocationManager()
        citySearchBar = weatherCitySearchView.citySearchBar
        citySearchBar?.delegate = self
    }

    func presentLocationAuthAlertController() {
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

    @objc func backToMainButtonPressed(_: UIButton) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - SearchBar Protocol

extension WeatherCitySearchViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        print("DidChange...b")
        print("Text is...: \(searchText)")
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

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        geoCoder.geocodeAddressString(displayedResultList[indexPath.row]) { placemarks, _ in
            guard let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                print("Couldn't found Coordinate.")
                return
            }

            // Use your location
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
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
            if displayedResultList.count == 0 {
                citySearchTableCell.searchedCityLabel.text = "도시를 검색 중입니다..."
            }
        }

        if displayedResultList.count == 0 {
            return citySearchTableCell
        }

        citySearchTableCell.setCellData(cityText: displayedResultList[indexPath.row])

        return citySearchTableCell
    }
}

// MARK: MapKit Protocol

extension WeatherCitySearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        displayedResultList = []
        _ = completer.results.map { result in
            let searchedCity = "\(result.title + ", " + result.subtitle)"
            displayedResultList.append(searchedCity)
            print("\(searchedCity)")
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

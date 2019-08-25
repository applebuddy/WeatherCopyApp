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

    // ✓ REVIEW: [Refactoring] 불필요 코드
    // ✓ REVIEW: [Refactoring] UIViewController 에서 Page index 관련 변수는 연관이 없습니다.
    var pageViewControllerIndex = 0

    // MARK: - UI

    private let listBarButton: UIButton = {
        let listBarButton = UIButton(type: .custom)
        listBarButton.setImage(UIImage(named: AssetIdentifier.Image.weatherList), for: .normal)
        return listBarButton
    }()

    private let presentViewButton: UIButton = {
        let presentViewButton = UIButton(type: .custom)
        presentViewButton.setTitleColor(.lightGray, for: .normal)
        presentViewButton.backgroundColor = .white
        return presentViewButton
    }()

    private let weatherDetailContentView: WeatherDetailView = {
        let weatherDetailContentView = WeatherDetailView()
        return weatherDetailContentView
    }()

    // MARK: - Life Cycle

    override func loadView() {
        view = weatherDetailContentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailViewController()
        setDetailView()
        registerCell()
        makeConstraints()
    }

    // MARK: - Set Method

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setWeatherData() {
        guard let nowWeatherData = CommonData.shared.weatherDataList[CommonData.shared.selectedMainCellIndex].subData,
            let detailViewTitle = CommonData.shared.weatherDataList[CommonData.shared.selectedMainCellIndex].subCityName else { return }
        let detailViewSubTitle = nowWeatherData.currently.summary
        weatherDetailContentView.setDetailViewData(title: detailViewTitle, subTitle: detailViewSubTitle)
    }

    private func setDetailViewController() {
        view.backgroundColor = CommonColor.weatherDetailView
    }

    private func setDetailView() {
        weatherDetailContentView.weatherDetailTableView.dataSource = self
        weatherDetailContentView.weatherDetailTableView.delegate = self
    }

    private func makeWeatherInfoTableHeaderViewScrollEvent(_ scrollView: UIScrollView, offsetY _: CGFloat) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = CGFloat.zero
        }

        let height = CGFloat(max(0, WeatherCellHeight.detailTableHeaderCell - max(0, scrollView.contentOffset.y)))

        let alphaValue = pow(height / WeatherCellHeight.detailTableHeaderCell, 10)
        weatherDetailContentView.weatherDetailTableHeaderView.setTableHeaderViewAlpha(alpha: CGFloat(alphaValue))
    }

    // MARK: Check Event

    // MARK: - Button Event
}

// MARK: - UITableView Protocol

extension WeatherDetailContentViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        makeWeatherInfoTableHeaderViewScrollEvent(scrollView, offsetY: scrollView.contentOffset.y)
        weatherDetailContentView.weatherDetailTableHeaderView.layoutIfNeeded()
    }

    // * WeatherData 갱신 시 DayInfoCollectionViewCell을 리로드 해준다.
    func tableView(_ tableView: UITableView, didEndDisplaying _: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let rowIndex = WeatherDetailTableViewRow(rawValue: indexPath.row) else { return }

        switch rowIndex {
        case .hourInfoRow: break
        default: break
        }
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIndex = WeatherDetailTableViewSection(rawValue: section) else { return UIView() }
        switch sectionIndex {
        case .mainSection:

            let weatherInfoTableHeaderView = weatherDetailContentView.weatherDetailTableHeaderView
            let weatherData = CommonData.shared.weatherDataList[CommonData.shared.selectedMainCellIndex].subData
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

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return WeatherCellHeight.detailTableHeaderCell
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

// MARK: - Custom View Protocol

extension WeatherDetailContentViewController: UIViewSettingProtocol {
    func makeSubviews() {}

    func makeConstraints() {}
}

extension WeatherDetailContentViewController: CellSettingProtocol {
    func registerCell() {
        weatherDetailContentView.weatherDetailTableView.register(WeatherHourInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherHourInfoTableCell)
        weatherDetailContentView.weatherDetailTableView.register(WeatherSubInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherWeekInfoTableCell)
    }
}

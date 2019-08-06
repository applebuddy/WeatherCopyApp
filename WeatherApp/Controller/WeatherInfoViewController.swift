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
    var currentPageViewIndex = 0

    // MARK: - UI

    /// WeatherPageViewController
    /// * 설정한 지역 별 날씨정보를 보여준다.
    var weatherPageViewController: UIPageViewController?

    lazy var weatherMainViewController: WeatherMainViewController = {
        let weatherMainViewController = WeatherMainViewController()
        return weatherMainViewController
    }()

    let weatherPageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .blue
        return pageControl
    }()

    let linkBarButton: UIButton = {
        let linkBarButton = UIButton(type: .custom)
        linkBarButton.setImage(UIImage(named: AssetIdentifier.Image.weatherLink), for: .normal)
        return linkBarButton
    }()

    let listBarButton: UIButton = {
        let listBarButton = UIButton(type: .custom)
        listBarButton.setImage(UIImage(named: AssetIdentifier.Image.weatherList), for: .normal)
        return listBarButton
    }()

    let weatherInfoView: WeatherInfoView = {
        let weatherInfoView = WeatherInfoView()
        return weatherInfoView
    }()

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        view = weatherInfoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setInfoViewController()
        setLocationManager()
        setInfoView()
        registerCell()
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
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
            self.weatherInfoView.layoutIfNeeded()
            self.weatherInfoView.weatherInfoTableView.reloadData()
        }
    }

    // MARK: - Set Method

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }

    func setWeatherPageViewController() {
        let mainPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        mainPageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        weatherPageViewController = mainPageViewController

        //        let viewControllerSize = CommonData.shared.subLocationDataList.count
        if let rootViewController = makeContentViewController(index: 0),
            let unWrappingPageViewController = self.weatherPageViewController {
            let viewControllers = [rootViewController]
            unWrappingPageViewController.setViewControllers(viewControllers, direction: .reverse, animated: true, completion: nil)
        }

        view.addSubview(mainPageViewController.view)
        addChild(mainPageViewController)
        mainPageViewController.didMove(toParent: self)
        mainPageViewController.delegate = self
        mainPageViewController.dataSource = self

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let barButtonItem = UIBarButtonItem(customView: linkBarButton)
        let barButtonItem3 = UIBarButtonItem(customView: listBarButton)
        let toolBarItems = [barButtonItem, flexibleSpace, flexibleSpace, flexibleSpace, barButtonItem3]
        toolbarItems = toolBarItems
        navigationController?.setToolbarHidden(false, animated: false)
        hidesBottomBarWhenPushed = false

//        self.weatherPageViewController.toggle
    }

    func setPageControl() {}

    func makeContentViewController(index: Int) -> ContentViewController? {
        let contentViewController = ContentViewController()
        contentViewController.pageViewControllerIndex = index

        return contentViewController
    }

    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func setWeatherTitleViewData() {
        let weatherViewIndex = CommonData.shared.selectedMainCellIndex
        if weatherViewIndex == 0 {
            nowWeatherData = CommonData.shared.mainWeatherData
            let infoViewTitle = CommonData.shared.mainCityName
            guard let infoViewSubTitle = nowWeatherData?.currently.summary else { return }
            weatherInfoView.setInfoViewData(title: infoViewTitle,
                                            subTitle: infoViewSubTitle)
        }
    }

    func setInfoViewController() {
        view.backgroundColor = CommonColor.weatherInfoView

        setWeatherPageViewController()
    }

    func setInfoView() {
        weatherInfoView.weatherInfoTableView.dataSource = self
        weatherInfoView.weatherInfoTableView.delegate = self
    }

    func setButtonTarget() {
        linkBarButton.addTarget(self, action: #selector(linkButtonPressed(_:)), for: .touchUpInside)
        listBarButton.addTarget(self, action: #selector(listButtonPressed(_:)), for: .touchUpInside)
    }

    func setTableHeaderView() {
        headerHeightConstraint = weatherInfoView.weatherInfoTableHeaderView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.infoTableHeaderCell)
        headerHeightConstraint?.isActive = true
    }

    func setToolBarButtonItem() {
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let barButtonItem = UIBarButtonItem(customView: linkBarButton)
//        let barButtonItem2 = UIBarButtonItem(customView: presentViewButton)
//        let barButtonItem3 = UIBarButtonItem(customView: listBarButton)
//        let toolBarItems = [barButtonItem, flexibleSpace, barButtonItem2, flexibleSpace, barButtonItem3]
//        toolbarItems = toolBarItems
//        navigationController?.setToolbarHidden(true, animated: false)
//        hidesBottomBarWhenPushed = false
    }

    func makeWeatherInfoTableHeaderViewScrollEvent(_ scrollView: UIScrollView, offsetY _: CGFloat) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = CGFloat.zero
        }
        let height = CGFloat(max(0, WeatherCellHeight.infoTableHeaderCell - max(0, scrollView.contentOffset.y)))
        let alphaValue = pow(height / WeatherCellHeight.infoTableHeaderCell, 10)
        weatherInfoView.weatherInfoTableHeaderView.setTableHeaderViewAlpha(alpha: CGFloat(alphaValue))
    }

    // MARK: Check Event

    func presentToMainView() {
        present(weatherMainViewController, animated: true)
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
        case .hourInfoRow:
            guard let dayInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherHourInfoTableCell, for: indexPath) as? WeatherHourInfoTableViewCell else { return }
        default: break
        }
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIndex = WeatherInfoTableViewSection(rawValue: section) else { return UIView() }
        switch sectionIndex {
        case .mainSection:
            let weatherInfoTableHeaderView = weatherInfoView.weatherInfoTableHeaderView
            let weatherData = CommonData.shared.mainWeatherData
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

extension WeatherInfoViewController: UITableViewDataSource {
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

// MARK: - PageView Protocol

extension WeatherInfoViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?[0] as? ContentViewController {
                currentPageViewIndex = currentViewController.pageViewControllerIndex
            }
        }
    }
}

extension WeatherInfoViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let targetViewController = viewController as? ContentViewController else { return nil }

        var previousIndex = targetViewController.pageViewControllerIndex

        if previousIndex == 0 {
            previousIndex = CommonData.shared.subWeatherDataList.count - 1
        } else {
            previousIndex -= 1
        }

        return makeContentViewController(index: previousIndex)
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let targetViewController = viewController as? ContentViewController else { return nil }

        var nextIndex = targetViewController.pageViewControllerIndex

        if nextIndex == CommonData.shared.subWeatherDataList.count - 1 {
            nextIndex = 0
        } else {
            nextIndex += 1
        }

        return makeContentViewController(index: nextIndex)
    }

    func presentationCount(for _: UIPageViewController) -> Int {
        return CommonData.shared.subWeatherDataList.count
    }

    // 인디케이터의 초기 값
    func presentationIndex(for _: UIPageViewController) -> Int {
        return 0
    }
}

// MARK: - CLLocationManager Protocol

extension WeatherInfoViewController: CLLocationManagerDelegate {
    /// * **위치가 업데이트 될 때마다 실행 되는 델리게이트 메서드**

    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        if let nowCoordinate = manager.location?.coordinate {
            CommonData.shared.setMainCityName(latitude: nowCoordinate.latitude, longitude: nowCoordinate.longitude)
            let nowLatitude = nowCoordinate.latitude.roundedValue(roundSize: 2)
            let nowLongitude = nowCoordinate.longitude.roundedValue(roundSize: 2)

            setWeatherTitleViewData()
            view.layoutIfNeeded()
            if !isAppearViewController {
                CommonData.shared.setMainCoordinate(latitude: nowLatitude, longitude: nowLongitude)
                let mainLatitude = CommonData.shared.mainCoordinate.latitude
                let mainLongitude = CommonData.shared.mainCoordinate.longitude

                WeatherAPI.shared.requestAPI(latitude: mainLatitude, longitude: mainLongitude) { weatherAPIData in
                    CommonData.shared.setMainWeatherData(weatherData: weatherAPIData)

                    DispatchQueue.main.async {
                        self.weatherInfoView.layoutIfNeeded()
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
    func makeSubviews() {
        view.addSubview(weatherPageControl)
    }

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

extension WeatherInfoViewController: CellSettingProtocol {
    func registerCell() {
        weatherInfoView.weatherInfoTableView.register(WeatherHourInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherHourInfoTableCell)
        weatherInfoView.weatherInfoTableView.register(WeatherSubInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherWeekInfoTableCell)
    }
}

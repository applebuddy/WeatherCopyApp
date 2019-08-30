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

class WeatherDetailViewController: UIViewController {
    // MARK: - Property

    private let locationManager = CLLocationManager()
    private var isAppearViewController = false

    // MARK: - UI

    /// WeatherPageViewController
    /// * 설정한 지역 별 날씨정보를 보여준다.
    // ✓ REVIEW: [Refactoring] optional일 필요가 없다.
    // Optioanl로 선언되야할지 그 이유를 명확히 생각해보고 지정하자.
    private let weatherPageViewController: UIPageViewController = {
        let weatherPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return weatherPageViewController
    }()

    private lazy var weatherCityListViewController: WeatherCityListViewController = {
        let weatherCityListViewController = WeatherCityListViewController()
        return weatherCityListViewController
    }()

    private let weatherPageControl: UIPageControl = {
        let weatherPageControl = UIPageControl()
        weatherPageControl.numberOfPages = CommonData.shared.weatherDataList.count
        weatherPageControl.hidesForSinglePage = false
        weatherPageControl.currentPage = CommonData.shared.selectedMainCellIndex
        weatherPageControl.tintColor = .black
        weatherPageControl.pageIndicatorTintColor = .black
        weatherPageControl.currentPageIndicatorTintColor = .white
        return weatherPageControl
    }()

    private let linkBarButton: UIButton = {
        let linkBarButton = UIButton(type: .custom)
        linkBarButton.setImage(UIImage(named: AssetIdentifier.Image.weatherLink), for: .normal)
        return linkBarButton
    }()

    private let listBarButton: UIButton = {
        let listBarButton = UIButton(type: .custom)
        listBarButton.setImage(UIImage(named: AssetIdentifier.Image.weatherList), for: .normal)
        return listBarButton
    }()

    /*
     Review: 왜 이렇게 하셨을까?
     private let weatherDetailView: WeatherDetailView = {
     return WeatherDetailView()
     }()
     
     */
    private let weatherDetailView: WeatherDetailView = {
        let weatherDetailView = WeatherDetailView()
        return weatherDetailView
    }()

    // MARK: - Life Cycle

    override func loadView() {
        view = weatherDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeSubviews()
        setDetailViewController()
        setWeatherPageViewController()
        setButtonTarget()
        setToolBarButtonItem()
        makeConstraints()
    }

    // MARK: - Set Method

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setWeatherPageViewController() {
        weatherPageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)

        view.addSubview(weatherPageViewController.view)
        addChild(weatherPageViewController)
        weatherPageViewController.didMove(toParent: self)
        weatherPageViewController.delegate = self
        weatherPageViewController.dataSource = self
        weatherPageViewController.view.backgroundColor = .black

        weatherPageViewController.view.addSubview(linkBarButton)
        // Review: [Refactoring] ViewController Event를 좀더 구체적으로 하는건 어떨까요?
        /*
         to.willMove(toParent: self)
         addChild(to)
         from.willMove(toParent: nil)
         to.didMove(toParent: self)
         from.removeFromParent()
         from.didMove(toParent: nil)
         */
        // 뷰 컨트롤러 하나만 먼저 준비, 데이터소스에서 나머지 컨텐츠 뷰 컨트롤러를 설정한다.
        let contentViewController = makeContentViewController(index: CommonData.shared.selectedMainCellIndex)
        weatherPageViewController.setViewControllers([contentViewController], direction: .reverse, animated: true, completion: nil)
    }

    private func setMainPageControl(index: Int) {
        weatherPageControl.currentPage = index
    }

    private func makeContentViewController(index: Int) -> WeatherDetailContentViewController {
        let contentViewController = WeatherDetailContentViewController()
        if index >= CommonData.shared.weatherDataList.count {
            contentViewController.pageViewControllerIndex = CommonData.shared.selectedMainCellIndex
            setMainPageControl(index: CommonData.shared.selectedMainCellIndex)
        } else {
            contentViewController.pageViewControllerIndex = index
        }

        contentViewController.setWeatherData()
        // REVIEW: [성능] layoutIfNeeded 는 신중히 사용하셔야 합니다.
        // layoutIfNeeded는 아래 그림 과정을 전체 수행합니다
        // ✭ https://miro.medium.com/max/1218/1*qRxIjIzHomLae-tmI0QXgQ.png

        return contentViewController
    }

    private func setDetailViewController() {
        view.backgroundColor = CommonColor.weatherDetailView
    }

    private func setButtonTarget() {
        linkBarButton.addTarget(self, action: #selector(linkButtonPressed(_:)), for: .touchUpInside)
        listBarButton.addTarget(self, action: #selector(listButtonPressed(_:)), for: .touchUpInside)
    }

    private func setToolBarButtonItem() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let barButtonItem = UIBarButtonItem(customView: linkBarButton)
        let barButtonItem2 = UIBarButtonItem(customView: weatherPageControl)
        let barButtonItem3 = UIBarButtonItem(customView: listBarButton)
        let toolBarItems = [barButtonItem, flexibleSpace, barButtonItem2, flexibleSpace, barButtonItem3]
        toolbarItems = toolBarItems
        navigationController?.setToolbarHidden(false, animated: false)
        hidesBottomBarWhenPushed = false
    }

    private func makeWeatherInfoTableHeaderViewScrollEvent(_ scrollView: UIScrollView, offsetY _: CGFloat) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = CGFloat.zero
        }

        let height = CGFloat(max(0, WeatherCellHeight.detailTableHeaderCell - max(0, scrollView.contentOffset.y)))
        let alphaValue = pow(height / WeatherCellHeight.detailTableHeaderCell, 10)
        weatherDetailView.weatherDetailTableHeaderView.setTableHeaderViewAlpha(alpha: CGFloat(alphaValue))
    }

    private func makeLinkBarButtonConstraint() {
        linkBarButton.activateAnchors()
        NSLayoutConstraint.activate([
            linkBarButton.heightAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.height),
            linkBarButton.widthAnchor.constraint(equalTo: linkBarButton.heightAnchor, multiplier: 1.0),
        ])
    }

    private func makeListBarButtonConstraint() {
        listBarButton.activateAnchors()
        NSLayoutConstraint.activate([
            listBarButton.heightAnchor.constraint(equalToConstant: CommonSize.defaultButtonSize.height),
            listBarButton.widthAnchor.constraint(equalTo: listBarButton.heightAnchor, multiplier: 1.0),
        ])
    }

    // MARK: Check Event

    private func dismissToCityListView() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Button Event

    @objc private func linkButtonPressed(_: UIButton) {
        // ✭ URL 링크주소는 파싱구현 이후 다시 수정한다.
        guard let latitude = CommonData.shared.weatherLocationDataList[0].latitude,
            let longitude = CommonData.shared.weatherLocationDataList[0].longitude else { return }
        CommonData.shared.openWeatherURL(latitude: latitude, longitude: longitude)
    }

    @objc private func listButtonPressed(_: UIButton) {
        dismissToCityListView()
    }
}

// MARK: - PageView Protocol

extension WeatherDetailViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted completed: Bool) {
        if completed {}
    }
}

extension WeatherDetailViewController: UIPageViewControllerDataSource {
    // 이전으로 넘길때 컨텐츠 뷰 컨트롤러 데이터 전달
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let targetViewController = viewController as? WeatherDetailContentViewController else { return nil }
        let previousIndex = targetViewController.pageViewControllerIndex
        setMainPageControl(index: previousIndex)
        if previousIndex == 0 {
            setMainPageControl(index: 0)
            return nil
        } else {
            CommonData.shared.setSelectedMainCellIndex(index: previousIndex - 1)
            return makeContentViewController(index: previousIndex - 1)
        }
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let targetViewController = viewController as? WeatherDetailContentViewController else { return nil }

        let contentViewControllerMaxIndex = CommonData.shared.weatherDataList.count - 1
        let nextIndex = targetViewController.pageViewControllerIndex
        setMainPageControl(index: nextIndex)
        if nextIndex == contentViewControllerMaxIndex {
            return nil
        } else {
            CommonData.shared.setSelectedMainCellIndex(index: nextIndex + 1)
            return makeContentViewController(index: nextIndex + 1)
        }
    }

//    func presentationCount(for _: UIPageViewController) -> Int {
//        return CommonData.shared.weatherDataList.count
//    }
//
//    // 인디케이터의 초기 값
//    func presentationIndex(for _: UIPageViewController) -> Int {
//        return CommonData.shared.selectedMainCellIndex
//    }
}

// MARK: - Custom View Protocol

extension WeatherDetailViewController: UIViewSettingProtocol {
    func makeSubviews() {
        view.addSubview(weatherPageControl)
    }

    func makeConstraints() {
        makeLinkBarButtonConstraint()
        makeListBarButtonConstraint()
    }
}

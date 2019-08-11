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
        let weatherPageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: UIScreen.main.bounds.width, height: 50))
        weatherPageControl.numberOfPages = 1 + CommonData.shared.weatherDataList.count
        weatherPageControl.hidesForSinglePage = false
        weatherPageControl.currentPage = 0
        weatherPageControl.tintColor = .black
        weatherPageControl.pageIndicatorTintColor = .black
        weatherPageControl.currentPageIndicatorTintColor = .blue
        return weatherPageControl
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

        // ** 날씨데이터 저장 방식 **
        CommonData.shared.initWeatherDataListSize() // 맨 처음 메인데이터가 들어갈 크기를 공간 설정하고,
        CommonData.shared.setUserDefaultsData() // 저장 된 서브 날씨데이터를 추가한다.

        print("initial weatherDataListSize : \(CommonData.shared.weatherDataList.count)")
        print("initial weatherLocationDataListSize : \(CommonData.shared.weatherLocationDataList.count)")
        makeSubviews()
        setInfoViewController()
        setButtonTarget()
        setToolBarButtonItem()
        setTableHeaderView()
        makeConstraints()
        presentToMainView()
    }

    // MARK: - Set Method

    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        return .lightContent
    //    }

    func setWeatherPageViewController() {
        let mainPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        mainPageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        weatherPageViewController = mainPageViewController

        let viewControllerCount = CommonData.shared.weatherDataList.count

        // 뷰 컨트롤러 하나만 먼저 준비, 데이터소스에서 나머지 컨텐츠 뷰 컨트롤러를 설정한다.
        var contentViewController = ContentViewController()

        let unWrappingPageViewController = weatherPageViewController

        unWrappingPageViewController?.setViewControllers([contentViewController], direction: .reverse, animated: true, completion: nil)

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let barButtonItem = UIBarButtonItem(customView: linkBarButton)
        let barButtonItem3 = UIBarButtonItem(customView: listBarButton)
        let toolBarItems = [barButtonItem, flexibleSpace, flexibleSpace, flexibleSpace, flexibleSpace, flexibleSpace, barButtonItem3]

        mainPageViewController.toolbarItems = toolBarItems
        mainPageViewController.view.addSubview(linkBarButton)
        view.addSubview(mainPageViewController.view)
        addChild(mainPageViewController)
        mainPageViewController.didMove(toParent: self)
        mainPageViewController.delegate = self
        mainPageViewController.dataSource = self
        mainPageViewController.view.backgroundColor = .black

        toolbarItems = toolBarItems
        navigationController?.setToolbarHidden(true, animated: false)
        hidesBottomBarWhenPushed = false
    }

    func setPageControl() {}

    func makeContentViewController(index: Int) -> ContentViewController? {
        let contentViewController = ContentViewController()
        contentViewController.pageViewControllerIndex = index

        return contentViewController
    }

    func setInfoViewController() {
        view.backgroundColor = CommonColor.weatherInfoView
        setWeatherPageViewController()
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
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let barButtonItem = UIBarButtonItem(customView: linkBarButton)
        let barButtonItem3 = UIBarButtonItem(customView: listBarButton)
        let toolBarItems = [barButtonItem, flexibleSpace, flexibleSpace, flexibleSpace, barButtonItem3]
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
    // 이전으로 넘길때 컨텐츠 뷰 컨트롤러 데이터 전달
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let targetViewController = viewController as? ContentViewController else { return nil }
        let contentViewControllerMaxIndex = CommonData.shared.weatherDataList.count - 1
        let previousIndex = targetViewController.pageViewControllerIndex

        if previousIndex < 1 {
            return nil
        } else {
            CommonData.shared.setSelectedMainCellIndex(index: previousIndex - 1)
            return makeContentViewController(index: previousIndex - 1)
        }
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let targetViewController = viewController as? ContentViewController else { return nil }

        let contentViewControllerMaxIndex = CommonData.shared.weatherDataList.count - 1
        var nextIndex = targetViewController.pageViewControllerIndex

        if nextIndex == contentViewControllerMaxIndex {
            return nil
        } else {
            CommonData.shared.setSelectedMainCellIndex(index: nextIndex + 1)
            return makeContentViewController(index: nextIndex + 1)
        }
    }

    func presentationCount(for _: UIPageViewController) -> Int {
        return CommonData.shared.weatherDataList.count
    }

    // 인디케이터의 초기 값
    func presentationIndex(for _: UIPageViewController) -> Int {
        return CommonData.shared.selectedMainCellIndex
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

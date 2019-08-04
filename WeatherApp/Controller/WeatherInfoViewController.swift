//
//  ViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import MapKit
import UIKit

class WeatherInfoViewController: UIViewController {
    // MARK: - Property

    var headerHeightConstraint: NSLayoutConstraint?

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

    override func viewDidLoad() {
        super.viewDidLoad()
        print(WeatherCommonData.shared.isLocationAuthority)
        setInfoViewController()
        registerCell()
        setInfoView()
        setButtonTarget()
        setToolBarButtonItem()
        setTableHeaderView()
        makeConstraints()
        presentToMainView()
    }

    override func loadView() {
        super.loadView()
        view = weatherInfoView
    }

    // MARK: - Set Method

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
        guard let url = NSURL(string: "https://weather.com/ko-KR/weather/today/l/37.46,126.88?par=apple_widget&locale=ko_KR") else { return }
        UIApplication.shared.open(url as URL)
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

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIndex = WeatherInfoTableViewSection(rawValue: section) else { return UIView() }
        switch sectionIndex {
        case .mainSection: return weatherInfoTableHeaderView
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

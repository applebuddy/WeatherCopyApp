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
    var headerHeightConstraint: NSLayoutConstraint?
    var headerViewFrame: CGRect?

    lazy var weatherMainViewController: WeatherMainViewController = {
        let weatherMainViewController = WeatherMainViewController()
        return weatherMainViewController
    }()

    let linkBarButton: UIButton = {
        let linkBarButton = UIButton(type: .custom)
        linkBarButton.setImage(#imageLiteral(resourceName: "weatherLinkImage"), for: .normal)
        return linkBarButton
    }()

    let listBarButton: UIButton = {
        let listBarButton = UIButton(type: .custom)
        listBarButton.setImage(#imageLiteral(resourceName: "weatherListImage"), for: .normal)
        return listBarButton
    }()

    let presentViewButton: UIButton = {
        let presentViewButton = UIButton(type: .custom)
        presentViewButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        presentViewButton.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
        setInfoViewController()
        setButtonTarget()
        setToolBarButtonItem()
        setTableHeaderView()
        setConstraints()
    }

    override func loadView() {
        super.loadView()
        view = weatherInfoView
    }

    func setInfoViewController() {
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

    @objc func linkButtonPressed(_: UIButton) {
        // ✭ URL 링크주소는 파싱구현 이후 다시 수정한다.
        guard let url = NSURL(string: "https://weather.com/ko-KR/weather/today/l/37.46,126.88?par=apple_widget&locale=ko_KR") else { return }
        UIApplication.shared.open(url as URL)
    }

    @objc func listButtonPressed(_: UIButton) {
        print("listBarButton Pressed")
        present(weatherMainViewController, animated: true, completion: nil)
    }

    @objc func presentViewButtonPressed(_: UIButton) {
        print("presentViewButton Pressed")
    }
}

// MARK: - UITableView Protocol

extension WeatherInfoViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 { return }
        let height = CGFloat(max(0, WeatherCellHeight.infoTableHeaderCell - max(0, scrollView.contentOffset.y)))
        let alphaValue = pow(height / WeatherCellHeight.infoTableHeaderCell, 5)
        weatherInfoTableHeaderView.setTableHeaderViewAlpha(alpha: alphaValue)
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
            let weatherWeekInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherWeekInfoTableCell, for: indexPath) as? WeatherWeekInfoTableViewCell,
            let rowIndex = WeatherInfoTableViewRow(rawValue: indexPath.row) else { return UITableViewCell() }

        switch rowIndex {
        case .dayInfoCell:
            weatherDayInfoCell.setCellData()
            weatherDayInfoCell.dayInfoCollectionView.register(DayInfoCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier.dayInfoCollectionCell)
            weatherDayInfoCell.dayInfoCollectionView.delegate = self
            weatherDayInfoCell.dayInfoCollectionView.dataSource = self
            return weatherDayInfoCell
        case .separatorCell: return WeatherSeparatorTableViewCell()
        case .weekInfoCell:
            return weatherWeekInfoCell
        }
    }
}

// MARK: - UICollectionView Protocol

extension WeatherInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.dayInfoCollectionCell, for: indexPath) as? DayInfoCollectionViewCell else { return UICollectionViewCell() }
        cell.setCellData()
        return cell
    }
}

extension WeatherInfoViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 24
    }
}

// MARK: - Controller Protocol

extension WeatherInfoViewController: CellSettingProtocol {
    func registerCell() {
        weatherInfoView.weatherInfoTableView.register(WeatherDayInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherDayInfoTableCell)
        weatherInfoView.weatherInfoTableView.register(WeatherWeekInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherWeekInfoTableCell)
    }
}

extension WeatherInfoViewController: UIViewSettingProtocol {
    func setSubviews() {}

    func setConstraints() {
        linkBarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkBarButton.heightAnchor.constraint(equalToConstant: 30),
            linkBarButton.widthAnchor.constraint(equalTo: linkBarButton.heightAnchor, multiplier: 1.0),
        ])
        listBarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listBarButton.heightAnchor.constraint(equalToConstant: 30),
            listBarButton.widthAnchor.constraint(equalTo: listBarButton.heightAnchor, multiplier: 1.0),
        ])
    }
}

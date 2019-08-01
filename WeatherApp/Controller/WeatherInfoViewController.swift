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

    let linkBarButton: UIButton = {
        let linkBarButton = UIButton(type: .custom)
        linkBarButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        linkBarButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        linkBarButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        linkBarButton.clipsToBounds = true
        linkBarButton.isHidden = false
        return linkBarButton
    }()

    let listBarButton: UIButton = {
        let listBarButton = UIButton(type: .custom)
        listBarButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        listBarButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        listBarButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        listBarButton.clipsToBounds = true
        return listBarButton
    }()

    let presentViewButton: UIButton = {
        let presentViewButton = UIButton(type: .custom)
        presentViewButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        presentViewButton.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        presentViewButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        presentViewButton.clipsToBounds = true
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
    }

    override func loadView() {
        super.loadView()
        view = weatherInfoView
    }

    func setInfoViewController() {
        weatherInfoView.weatherTableView.dataSource = self
        weatherInfoView.weatherTableView.delegate = self
        //        dayInfoCollectionView.delegate = self
        //        dayInfoCollectionView.dataSource = self
    }

    func setButtonTarget() {
        linkBarButton.addTarget(self, action: #selector(linkButtonPressed(_:)), for: .touchUpInside)
        listBarButton.addTarget(self, action: #selector(presentViewButtonPressed(_:)), for: .touchUpInside)
        presentViewButton.addTarget(self, action: #selector(listButtonPressed(_:)), for: .touchUpInside)
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
        let toolBarItems = [barButtonItem, flexibleSpace, barButtonItem3, flexibleSpace, barButtonItem2]
        toolbarItems = toolBarItems
        navigationController?.setToolbarHidden(false, animated: false)
        hidesBottomBarWhenPushed = false
    }

    @objc func linkButtonPressed(_: UIButton) {
        print("linkBarButton Pressed")
    }

    @objc func listButtonPressed(_: UIButton) {
        print("listBarButton Pressed")
    }

    @objc func presentViewButtonPressed(_: UIButton) {
        print("presentViewButton Pressed")
    }
}

// MARK: - UITableView Protocol

extension WeatherInfoViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print()
        if scrollView.contentOffset.y == 0 { return }
        let height = CGFloat(max(0, WeatherCellHeight.infoTableHeaderCell - max(0, scrollView.contentOffset.y)))
        let alphaValue = pow(height / WeatherCellHeight.infoTableHeaderCell, 5)
        weatherInfoTableHeaderView.setTableHeaderViewAlpha(alpha: alphaValue)
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return weatherInfoTableHeaderView
        } else {
            return UIView()
        }
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension WeatherInfoViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 2
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherDayInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherDayInfoTableCell, for: indexPath) as? WeatherDayInfoTableViewCell,
            let weatherWeekInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherWeekInfoTableCell, for: indexPath) as? WeatherWeekInfoTableViewCell else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            weatherDayInfoCell.setCellData()
            weatherDayInfoCell.dayInfoCollectionView.register(DayInfoCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier.dayInfoCollectionCell)
            weatherDayInfoCell.dayInfoCollectionView.delegate = self
            weatherDayInfoCell.dayInfoCollectionView.dataSource = self
            return weatherDayInfoCell
        case 1:
            // 테이블 뷰 추가 후 확인 필요(아직 컨텐츠뷰 크기설정이 안되어서 안보임
            weatherWeekInfoCell.setCellData()
            return weatherWeekInfoCell
        default: return UITableViewCell()
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
        return 16
    }
}

//
//
// extension WeatherInfoViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 300)
//    }
// }

// MARK: - Controller Protocol

extension WeatherInfoViewController: CellSettingProtocol {
    func registerCell() {
        weatherInfoView.weatherTableView.register(WeatherDayInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherDayInfoTableCell)
        weatherInfoView.weatherTableView.register(WeatherWeekInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherWeekInfoTableCell)
    }
}

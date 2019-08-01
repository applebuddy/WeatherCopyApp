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

    let weatherDayInfoCellIdentifier: String = "weatherDayInfoTableViewCell"
    let weatherWeekInfoCellIdentifier: String = "weatherWeekInfoTableViewCell"

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
        weatherInfoView.weatherTableView.delegate = self
        weatherInfoView.weatherTableView.dataSource = self
        registerCell()
        setButtonTarget()
        setToolBarButtonItem()
        setTableHeaderView()
        headerViewFrame = weatherInfoTableHeaderView.frame
    }

    override func loadView() {
        super.loadView()
        view = weatherInfoView
    }

    func setButtonTarget() {
        linkBarButton.addTarget(self, action: #selector(linkButtonPressed(_:)), for: .touchUpInside)
        listBarButton.addTarget(self, action: #selector(presentViewButtonPressed(_:)), for: .touchUpInside)
        presentViewButton.addTarget(self, action: #selector(listButtonPressed(_:)), for: .touchUpInside)
    }

    func registerCell() {
        weatherInfoView.weatherTableView.register(WeatherDayInfoTableViewCell.self, forCellReuseIdentifier: weatherDayInfoCellIdentifier)
        weatherInfoView.weatherTableView.register(WeatherWeekInfoTableViewCell.self, forCellReuseIdentifier: weatherWeekInfoCellIdentifier)
    }

    func setTableHeaderView() {
        headerHeightConstraint = weatherInfoTableHeaderView.heightAnchor.constraint(equalToConstant: weatherSubTitleOriginHeight)
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

extension WeatherInfoViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = CGFloat(max(0, weatherSubTitleOriginHeight - max(0, scrollView.contentOffset.y)))
        let alphaValue = pow(height / weatherSubTitleOriginHeight, 5)
        weatherInfoTableHeaderView.setTableHeaderViewAlpha(alpha: alphaValue)
        weatherInfoTableHeaderView.frame.size.height = height
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        return weatherInfoTableHeaderView
    }
}

extension WeatherInfoViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherDayInfoCell = tableView.dequeueReusableCell(withIdentifier: self.weatherDayInfoCellIdentifier, for: indexPath) as? WeatherDayInfoTableViewCell,
            let weatherWeekInfoCell = tableView.dequeueReusableCell(withIdentifier: self.weatherWeekInfoCellIdentifier, for: indexPath) as? WeatherWeekInfoTableViewCell else { return UITableViewCell() }
        switch indexPath.row {
        case 0: return weatherDayInfoCell
        case 1: return weatherWeekInfoCell
        default: return UITableViewCell()
        }
    }
}

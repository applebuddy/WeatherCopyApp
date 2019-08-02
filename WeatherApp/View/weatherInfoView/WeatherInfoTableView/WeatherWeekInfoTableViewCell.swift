//
//  WeatherWeekInfoTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 주간 날씨정보 테이블뷰 셀
class WeatherWeekInfoTableViewCell: UITableViewCell {
    let weatherSubInfoTableView: WeatherSubInfoTableView = {
        let weekInfoTableView = WeatherSubInfoTableView(frame: CGRect.zero, style: .grouped)
        return weekInfoTableView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraints()
        registerCell()
        weatherSubInfoTableView.delegate = self
        weatherSubInfoTableView.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setCellData() {
        backgroundColor = UIColor.green
    }
}

extension WeatherWeekInfoTableViewCell: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(weatherSubInfoTableView)
    }

    func setConstraints() {
        weatherSubInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherSubInfoTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            weatherSubInfoTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            weatherSubInfoTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            weatherSubInfoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}

extension WeatherWeekInfoTableViewCell: CellSettingProtocol {
    func registerCell() {
        weatherSubInfoTableView.register(WeekInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weekInfoTableCell)
        weatherSubInfoTableView.register(TodayInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.todayInfoTableCell)
    }
}

extension WeatherWeekInfoTableViewCell: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return WeatherCellHeight.weekInfoTableViewCell
    }

    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: section) else { return CGFloat.leastNormalMagnitude }
        switch sectionIndex {
        case .weekInfoSection:
            return 1
        case .todayInfoSection:
            return WeatherCellHeight.todayInfoTableHeaderView
        }
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return 1
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        return WeatherSeparatorView()
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: section) else { return UIView() }
        switch sectionIndex {
        case .weekInfoSection:
            return UIView()
        case .todayInfoSection:
            return TodayInfoTableHeaderView()
        }
    }
}

extension WeatherWeekInfoTableViewCell: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: section) else { return 0 }
        switch sectionIndex {
        case .weekInfoSection: return 9
        case .todayInfoSection: return 1
        }
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weekInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weekInfoTableCell, for: indexPath) as? WeekInfoTableViewCell,
            let sectionIndex = WeatherSubInfoTableViewSection(rawValue: indexPath.section) else { return UITableViewCell() }

        switch sectionIndex {
        case .weekInfoSection:
            return weekInfoCell
        case .todayInfoSection:
            return UITableViewCell()
        }
    }
}

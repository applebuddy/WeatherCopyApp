//
//  WeatherWeekInfoTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 9일 간 주간 날씨정보 테이블뷰 셀
class WeatherSubInfoTableViewCell: UITableViewCell {
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
        backgroundColor = .black
    }
}

extension WeatherSubInfoTableViewCell: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(weatherSubInfoTableView)
    }

    func setConstraints() {
        weatherSubInfoTableView.activateAnchors()
        NSLayoutConstraint.activate([
            weatherSubInfoTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            weatherSubInfoTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            weatherSubInfoTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            weatherSubInfoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}

extension WeatherSubInfoTableViewCell: CellSettingProtocol {
    func registerCell() {
        weatherSubInfoTableView.register(WeekInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weekInfoTableCell)
        weatherSubInfoTableView.register(TodayInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.todayInfoTableCell)
    }
}

// MARK: - TableViewDelegate

extension WeatherSubInfoTableViewCell: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = CGFloat.zero
        }
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: indexPath.section) else { return CGFloat.leastNormalMagnitude }
        switch sectionIndex {
        case .weekInfoSection:
            return WeatherCellHeight.subInfoTableViewCell
        case .todayInfoSection:
            return WeatherCellHeight.todayInfoTableViewCell
        }
    }

    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: section) else { return CGFloat.leastNormalMagnitude }
        switch sectionIndex {
        case .weekInfoSection:
            return CGFloat.leastNormalMagnitude
        case .todayInfoSection:
            return WeatherViewHeight.todayInfoTableHeaderView
        }
    }

    func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: section) else { return CGFloat.leastNormalMagnitude }
        switch sectionIndex {
        case .weekInfoSection: return 1
        case .todayInfoSection: return CGFloat.leastNormalMagnitude
        }
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        return WeatherSeparatorView()
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: section) else { return UIView() }
        switch sectionIndex {
        case .weekInfoSection:
            return WeatherSeparatorView()
        case .todayInfoSection:
            return TodayInfoTableHeaderView()
        }
    }
}

extension WeatherSubInfoTableViewCell: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: section) else { return 0 }
        switch sectionIndex {
        case .weekInfoSection: return 9
        case .todayInfoSection: return 5
        }
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionIndex = WeatherSubInfoTableViewSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch sectionIndex {
        case .weekInfoSection:
            guard let weekInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weekInfoTableCell, for: indexPath) as? WeekInfoTableViewCell else { return UITableViewCell() }
            return weekInfoCell
        case .todayInfoSection:
            guard let todayInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.todayInfoTableCell, for: indexPath) as? TodayInfoTableViewCell,
                let todayInfoRowIndex = TodayInfoTableViewRow(rawValue: indexPath.row) else { return UITableViewCell() }

            todayInfoCell.setLabelTitle(
                leftTitle: TodayInfoCellData.cellLeftLabelText[indexPath.row],
                rightTitle: TodayInfoCellData.cellRightLabelText[indexPath.row]
            )
            todayInfoCell.cellBottomBorderView.backgroundColor = CommonColor.separator
            switch todayInfoRowIndex {
            case .firstRow:
                break
            case .secondRow:
                break
            case .thirdRow:
                break
            case .fourthRow:
                break
            case .fifthRow:
                todayInfoCell.cellBottomBorderView.backgroundColor = .clear
            }
            return todayInfoCell
        }
    }
}

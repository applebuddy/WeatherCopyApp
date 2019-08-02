//
//  Constant.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

struct CellIdentifier {
    static let weatherDayInfoTableCell: String = "weatherDayInfoTableViewCell"
    static let weatherWeekInfoTableCell: String = "weatherWeekInfoTableViewCell"
    static let dayInfoCollectionCell: String = "dayInfoCollectionViewCell"
    static let weekInfoTableCell: String = "weekInfoTableViewCell"
    static let weatherMainTableCell: String = "weatherMainTableViewCell"
    static let todayInfoTableCell: String = "todayInfoTableViewCell"
    static let weatherSeparatorTableCell: String = "weatherSeparatorTableViewCell"
}

enum WeatherInfoTableViewSection: Int {
    case mainSection = 0
}

enum WeatherInfoTableViewRow: Int {
    case dayInfoCell = 0
    case separatorCell = 1
    case weekInfoCell = 2
}

enum WeatherSubInfoTableViewSection: Int {
    case weekInfoSection = 0
    case todayInfoSection = 1
}

struct WeatherCellHeight {
    static let dayInfoTableCell: CGFloat = 120
    static let infoTableHeaderCell: CGFloat = 150
    static let dayInfoCollectionCell: CGFloat = 100
    static let weekInfoTableViewCell: CGFloat = 35
    static let todayInfoTableHeaderView: CGFloat = 50
}

struct CommonInset {
    static let leftInset: CGFloat = 20
    static let rightInset: CGFloat = 20
    static let topInset: CGFloat = 5
    static let bottomInset: CGFloat = 5
}

enum WeatherSection: Int {
    case mainSection = 0
}

struct WeatherViewHeight {
    static let titleViewHeight: CGFloat = 100
    static let weekInfoTableView: CGFloat = 300
}

let weekInfoStackViewCount = 9

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
    case dayInfoRow = 0
    case separatorRow = 1
    case weekInfoRow = 2
}

enum TodayInfoTableViewRow: Int {
    case firstRow = 0
    case secondRow = 1
    case thirdRow = 2
    case fourthRow = 3
    case fifthRow = 4
}

enum WeatherSubInfoTableViewSection: Int {
    case weekInfoSection = 0
    case todayInfoSection = 1
}

struct TodayInfoCellData {
    static let cellLeftLabelText = ["일출", "비 올 확률", "바람", "강수량", "가시거리"]
    static let cellRightLabelText = ["일몰", "습도", "체감", "기압", "자외선 지수"]
}

struct WeatherCellHeight {
    static let dayInfoTableCell: CGFloat = 120
    static let infoTableHeaderCell: CGFloat = 150
    static let dayInfoCollectionCell: CGFloat = 120
    static let weekInfoTableViewCell: CGFloat = 35
    static let todayInfoTableViewCell: CGFloat = 60
    static let todayInfoTableHeaderView: CGFloat = 60
}

struct CommonInset {
    static let leftInset: CGFloat = 20
    static let rightInset: CGFloat = 20
    static let topInset: CGFloat = 5
    static let bottomInset: CGFloat = 5
}

struct CommonColor {
    static let separator = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
}

enum WeatherSection: Int {
    case mainSection = 0
}

struct WeatherViewHeight {
    static let titleViewHeight: CGFloat = 100
    static let weekInfoTableView: CGFloat = 300
}

let weekInfoStackViewCount = 9

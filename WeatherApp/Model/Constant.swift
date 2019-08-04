//
//  Constant.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

struct DataIdentifier {
    static let isLocationAuthority = "isLocationAuthority"
}

// MARK: - Cell Constants

/// * WeatherApp 셀 식별자
struct CellIdentifier {
    static let weatherDayInfoTableCell: String = "weatherDayInfoTableViewCell"
    static let weatherWeekInfoTableCell: String = "weatherWeekInfoTableViewCell"
    static let dayInfoCollectionCell: String = "dayInfoCollectionViewCell"
    static let weekInfoTableCell: String = "weekInfoTableViewCell"
    static let weatherMainTableCell: String = "weatherMainTableViewCell"
    static let todayInfoTableCell: String = "todayInfoTableViewCell"
    static let weatherSeparatorTableCell: String = "weatherSeparatorTableViewCell"
}

// MARK: TableView Section Index

/// * WeatherMainTableView Section Index
enum WeatherSection: Int {
    case mainSection = 0
}

/// * WeatherInfoTableView Section Index
enum WeatherInfoTableViewSection: Int {
    case mainSection = 0
}

/// * WeatherSubInfoTableView Row Index
enum WeatherSubInfoTableViewSection: Int {
    case weekInfoSection = 0
    case todayInfoSection = 1
}

// MARK: TableView Row Index

/// * WeatherInfoTableView Row Index
enum WeatherInfoTableViewRow: Int {
    case dayInfoRow = 0
    case separatorRow = 1
    case weekInfoRow = 2
}

/// * TodayInfoTableView Row Index
enum TodayInfoTableViewRow: Int {
    case firstRow = 0
    case secondRow = 1
    case thirdRow = 2
    case fourthRow = 3
    case fifthRow = 4
}

/// * View Heights
struct WeatherViewHeight {
    static let weatherMainBottomView: CGFloat = 100
    static let titleViewHeight: CGFloat = 100
    static let subInfoTableView: CGFloat = UIScreen.main.bounds.size.height - (WeatherViewHeight.titleViewHeight + WeatherViewHeight.todayInfoTableHeaderView + WeatherCellHeight.dayInfoCollectionCell)
    static let todayInfoTableHeaderView: CGFloat = 60
    static let weatherCitySearchView: CGFloat = 100
}

/// * TableView Cell Heights
struct WeatherCellHeight {
    static let dayInfoTableCell: CGFloat = 120
    static let infoTableHeaderCell: CGFloat = 150
    static let dayInfoCollectionCell: CGFloat = 120
    static let subInfoTableViewCell: CGFloat = 35
    static let todayInfoTableViewCell: CGFloat = 60
    static let MainTableViewCell: CGFloat = 100
}

/// * TableInfoCell Title Text
struct TodayInfoCellData {
    static let cellLeftLabelText = ["일출", "비 올 확률", "바람", "강수량", "가시거리"]
    static let cellRightLabelText = ["일몰", "습도", "체감", "기압", "자외선 지수"]
}

// MARK: - Common Data

struct CommonSize {
    static let defaultButtonSize = CGSize(width: 30, height: 30)
}

struct CommonInset {
    static let leftInset: CGFloat = 20
    static let rightInset: CGFloat = 20
    static let topInset: CGFloat = 5
    static let bottomInset: CGFloat = 5
}

struct CommonColor {
    static let separator = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherMainView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherMainTableFooterView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherInfoView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherCitySearchView = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

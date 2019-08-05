//
//  Constant.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

public struct DataIdentifier {
    static let isLocationAuthority = "isLocationAuthority"
    static let weatherCoordinate = "weatherCoordinate"
}

// MARK: - Cell Constants

/// * WeatherApp 셀 식별자
public struct CellIdentifier {
    static let weatherHourInfoTableCell: String = "weatherHourInfoTableViewCell"
    static let weatherWeekInfoTableCell: String = "weatherWeekInfoTableViewCell"
    static let HourInfoCollectionCell: String = "hourInfoCollectionViewCell"
    static let weekInfoTableCell: String = "weekInfoTableViewCell"
    static let weatherMainTableCell: String = "weatherMainTableViewCell"
    static let todayInfoTableCell: String = "todayInfoTableViewCell"
    static let weatherSeparatorTableCell: String = "weatherSeparatorTableViewCell"
    static let citySearchTableCell: String = "citySearchTableViewCell"
}

// MARK: TableView Section Index

/// * WeatherMainTableView Section Index
public enum WeatherMainTableViewSection: Int {
    case mainSection = 0
}

/// * WeatherInfoTableView Section Index
public enum WeatherInfoTableViewSection: Int {
    case mainSection = 0
}

/// * WeatherSubInfoTableView Row Index
public enum WeatherSubInfoTableViewSection: Int {
    case weekInfoSection = 0
    case todayInfoSection = 1
}

// MARK: TableView Row Index

/// * WeatherInfoTableView Row Index
public enum WeatherInfoTableViewRow: Int {
    case hourInfoRow = 0
    case separatorRow = 1
    case weekInfoRow = 2
}

/// * TodayInfoTableView Row Index
public enum TodayInfoTableViewRow: Int {
    case firstRow = 0
    case secondRow = 1
    case thirdRow = 2
    case fourthRow = 3
    case fifthRow = 4
}

public struct WeatherInfoCellCount {
    static let weekInfoCell = 8
    static let dayInfoCell = 24
    static let todayInfoCell = 5
}

/// * View Heights
public struct WeatherViewHeight {
    static let weatherMainBottomView: CGFloat = 100
    static let titleViewHeight: CGFloat = 100
    static let subInfoTableView: CGFloat = UIScreen.main.bounds.size.height - (WeatherViewHeight.titleViewHeight + WeatherViewHeight.todayInfoTableHeaderView + WeatherCellHeight.hourInfoCollectionCell)
    static let todayInfoTableHeaderView: CGFloat = 60
    static let weatherCitySearchView: CGFloat = 100
    static let citySearchTableFooterView: CGFloat = 200
}

/// * TableView Cell Heights
public struct WeatherCellHeight {
    static let hourInfoTableCell: CGFloat = 120
    static let infoTableHeaderCell: CGFloat = 150
    static let hourInfoCollectionCell: CGFloat = 120
    static let subInfoTableViewCell: CGFloat = 35
    static let todayInfoTableViewCell: CGFloat = 60
    static let mainTableViewCell: CGFloat = 100
    static let citySearchTableView: CGFloat = 50
}

/// * TableInfoCell Title Text
public struct TodayInfoCellData {
    static let cellLeftLabelText = ["일출", "비 올 확률", "바람", "강수량", "가시거리"]
    static let cellRightLabelText = ["일몰", "습도", "체감", "기압", "자외선 지수"]
}

// MARK: - Common Data

public struct CommonSize {
    static let defaultButtonSize = CGSize(width: 30, height: 30)
}

public struct CommonInset {
    static let leftInset: CGFloat = 20
    static let rightInset: CGFloat = 20
    static let topInset: CGFloat = 5
    static let bottomInset: CGFloat = 5
}

public struct CommonColor {
    static let separator = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherMainView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherMainTableFooterView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherInfoView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherCitySearchView = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

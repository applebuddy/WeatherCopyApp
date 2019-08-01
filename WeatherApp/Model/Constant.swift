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
}

struct WeatherCellHeight {
    static let dayInfoTableCell: CGFloat = 120
    static let infoTableHeaderCell: CGFloat = 150
    static let dayInfoCollectionCell: CGFloat = 100
    static let weekInfoTableViewCell: CGFloat = 100
}

enum WeatherSection: Int {
    case mainSection = 0
}

struct WeatherViewHeight {
    static let titleViewHeight: CGFloat = 100
    static let weekInfoTableView: CGFloat = 300
}

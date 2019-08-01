//
//  Constant.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

let weatherDayInfoCollectionCellIdentifier: String = "weatherDayInfoCollectionViewCell"
let weatherDayInfoTableCellIdentifier: String = "weatherDayInfoTableViewCell"
let weatherWeekInfoTableCellIdentifier: String = "weatherWeekInfoTableViewCell"

struct WeatherCellHeights {
    static let dayInfoTableCell: CGFloat = 120
    static let infoTableHeaderCell: CGFloat = 150
    static let dayInfoCollectionCell: CGFloat = 100
}

enum WeatherSections: Int {
    case mainSection = 0
}

struct WeatherViewHeights {
    static let titleViewHeight: CGFloat = 100
}

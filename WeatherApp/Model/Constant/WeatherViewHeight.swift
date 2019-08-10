//
//  File.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 06/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// * View Heights
struct WeatherViewHeight {
    static let weatherMainBottomView: CGFloat = 100
    static let titleViewHeight: CGFloat = 100
    static let subInfoTableView: CGFloat = UIScreen.main.bounds.size.height - (WeatherViewHeight.titleViewHeight + WeatherViewHeight.todayInfoTableHeaderView + WeatherCellHeight.hourInfoCollectionCell)
    static let todayInfoTableHeaderView: CGFloat = 60
    static let weatherCitySearchView: CGFloat = 100
    static let citySearchTableFooterView: CGFloat = 200
}

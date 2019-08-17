//
//  Constant.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

// MARK: TableView Section Index

/// * WeatherMainTableView Section Index
enum WeatherCityListTableViewSection: Int {
    case mainSection = 0
}

/// * WeatherInfoTableView Section Index
enum WeatherDetailTableViewSection: Int {
    case mainSection = 0
}

/// * WeatherSubInfoTableView Row Index
enum WeatherSubInfoTableViewSection: Int {
    case weekInfoSection = 0
    case todayInfoSection = 1
}

// MARK: TableView Row Index

/// * WeatherInfoTableView Row Index
enum WeatherDetailTableViewRow: Int {
    case hourInfoRow = 0
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

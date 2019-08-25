//
//  CommonColor.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 06/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

struct CommonColor {
    // Review: [Refactoring] Resource(color, strings) 관련 것들은 SwiftGen 을 사용하는 건 어떨까요?
    // https://github.com/SwiftGen/SwiftGen
    
    // 예제: https://github.com/kimtaesu/MediaSearch/blob/master/swiftgen.yml
    static let separator = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherCityListView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherCityListTableFooterView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherDetailView = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let weatherCitySearchView = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

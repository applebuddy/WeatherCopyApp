//
//  WeatherInfoTableView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 메인 타이틀 뷰 하단 WeatherInfoViewController 메인 테이블뷰
/// * **타이틀 날씨 정보 하단의 세부정보를 나타낸다.**
class WeatherDetailTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setTableView() {
        backgroundColor = .white
        allowsSelection = false
        allowsMultipleSelection = false
        separatorStyle = .none
        bounces = true
    }
}

//
//  CitySearchTableView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 06/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class CitySearchTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = .black
        separatorColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

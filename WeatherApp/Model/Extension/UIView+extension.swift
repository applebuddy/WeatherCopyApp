//
//  CommonExtension.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherApp 범용 extension
// ✓ Review: [Refactoring] CommonExtension 보다 좀 더 세부적인 이름이 좋지 않을까요?
// => 세부적인 extension 명을 사용하도록 하자. ex) UIView+.swift, Double+.swift...
extension UIView {
    func activateAnchors() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

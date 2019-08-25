//
//  CommonExtension.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherApp 범용 extension
// Review: [Refactoring] CommonExtension 보다 좀 더 세부적인 이름이 좋지 않을까요?
// UIView+.swift
extension UIView {
    func activateAnchors() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// Double+.swift
extension Double {
    func roundedValue(roundSize: Int) -> Double {
        let roundSize = pow(10.0, Double(roundSize))
        return (self * roundSize).rounded() / roundSize
    }

    func changeTemperatureFToC() -> Double {
        return (self - 32) / 1.8
    }

    func changeTemperatureCToF() -> Double {
        return (self * 1.8) + 32
    }
}

extension UIActivityIndicatorView {
    func startCustomIndicatorAnimating(containerView: UIView) {
        DispatchQueue.main.async {
            containerView.isHidden = false
            self.isHidden = false
            self.startAnimating()
        }
    }

    func stopCustomIndicatorAnimating(containerView: UIView) {
        DispatchQueue.main.async {
            containerView.isHidden = true
            self.isHidden = true
            self.stopAnimating()
        }
    }
}

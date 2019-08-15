//
//  CommonExtension.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 03/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// WeatherApp 범용 extension
extension UIView {
    func activateAnchors() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

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

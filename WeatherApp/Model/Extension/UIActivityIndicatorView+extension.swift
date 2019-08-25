//
//  ActivityIndicatorView+extension.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 25/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

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

//
//  MainNavigationController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setNavigationBar()
        setToolBar()
    }

    func setToolBar() {
        toolbar.barStyle = .blackTranslucent
        toolbar.backgroundColor = .black
    }

    func setNavigationBar() {
        isNavigationBarHidden = true
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

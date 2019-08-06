//
//  MainNavigationController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

public class MainNavigationController: UINavigationController {
    // MARK: - UI

    let statusBackgroundView: UIView = {
        let statusBackgroundView = UIView()
        statusBackgroundView.backgroundColor = .white
        return statusBackgroundView
    }()

    // MARK: - Lift Cycle

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setNavigationBar()
        setToolBar()
        makeSubviews()
        makeConstraints()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set Method

    func setToolBar() {
        toolbar.barStyle = .blackTranslucent
        toolbar.backgroundColor = .black
    }

    func setNavigationBar() {
        isNavigationBarHidden = true
        navigationBar.barStyle = .default
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        navigationBar.backgroundColor = .white
    }
}

extension MainNavigationController: UIViewSettingProtocol {
    func makeSubviews() {
        view.addSubview(statusBackgroundView)
    }

    func makeConstraints() {
        statusBackgroundView.activateAnchors()
        NSLayoutConstraint.activate([
            statusBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            statusBackgroundView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height),
            statusBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
}

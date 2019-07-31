//
//  ViewController.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit
import MapKit

class WeatherInfoViewController: UIViewController {

    let linkBarButton: UIButton = {
        let linkBarButton = UIButton(type: .custom)
        linkBarButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        linkBarButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        linkBarButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        linkBarButton.clipsToBounds = true
        linkBarButton.isHidden = false
        return linkBarButton
    }()
    
    let listBarButton: UIButton = {
        let listBarButton = UIButton(type: .custom)
        listBarButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        listBarButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        listBarButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        listBarButton.clipsToBounds = true
        return listBarButton
    }()
    
    let presentViewButton: UIButton = {
        let presentViewButton = UIButton(type: .custom)
        presentViewButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        presentViewButton.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        presentViewButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        presentViewButton.clipsToBounds = true
        return presentViewButton
    }()
    
    let weatherInfoView: WeatherInfoView = {
        let weatherInfoView = WeatherInfoView()
        return weatherInfoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setButtonTarget()
        setToolBarButtonItem()
    }

    override func loadView() {
        super.loadView()
            self.view = weatherInfoView
    }
    
    func setButtonTarget() {
        linkBarButton.addTarget(self, action: #selector(linkButtonPressed(_:)), for: .touchUpInside)
        listBarButton.addTarget(self, action: #selector(presentViewButtonPressed(_:)), for: .touchUpInside)
        presentViewButton.addTarget(self, action: #selector(listButtonPressed(_:)), for: .touchUpInside)
    }

    func setToolBarButtonItem() {
    
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let barButtonItem = UIBarButtonItem(customView: linkBarButton)
        let barButtonItem2 = UIBarButtonItem(customView: presentViewButton)
        let barButtonItem3 = UIBarButtonItem(customView: listBarButton)
        let toolBarItems = [barButtonItem, flexibleSpace, barButtonItem3, flexibleSpace, barButtonItem2]
        self.toolbarItems = toolBarItems
        navigationController?.setToolbarHidden(false, animated: false)
        self.hidesBottomBarWhenPushed = false
        
    }
    
    @objc func linkButtonPressed(_ sender: UIButton) {
        print("linkBarButton Pressed")
    }
    
    @objc func listButtonPressed(_ sender: UIButton) {
        print("listBarButton Pressed")
    }
    
    @objc func presentViewButtonPressed(_ sender: UIButton) {
        print("presentViewButton Pressed")
    }
    
}


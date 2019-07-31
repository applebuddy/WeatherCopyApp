//
//  WeatherSubTitleView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherSubTitleView: UIView {

    let mainCelsiusLabel: UILabel = {
        let celsiusLabel = UILabel()
        celsiusLabel.text = "27º"
        celsiusLabel.font = UIFont.systemFont(ofSize: 80)
        celsiusLabel.textAlignment = .center
        celsiusLabel.textColor = UIColor.white
        celsiusLabel.adjustsFontSizeToFitWidth = true
        return celsiusLabel
    }()
    
    let minCelsiusLabel: UILabel = {
        let minCelsiusLabel = UILabel()
        minCelsiusLabel.text = "18"
        minCelsiusLabel.font = UIFont.systemFont(ofSize: 20)
        minCelsiusLabel.textAlignment = .center
        minCelsiusLabel.textColor = UIColor.white
        minCelsiusLabel.adjustsFontSizeToFitWidth = true
        return minCelsiusLabel
    }()
    
    let maxCelsiusLabel: UILabel = {
        let maxCelsiusLabel = UILabel()
        maxCelsiusLabel.text = "36"
        maxCelsiusLabel.font = UIFont.systemFont(ofSize: 20)
        maxCelsiusLabel.textAlignment = .center
        maxCelsiusLabel.textColor = UIColor.white
        maxCelsiusLabel.adjustsFontSizeToFitWidth = true
        return maxCelsiusLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "수요일"
        dateLabel.font = UIFont.systemFont(ofSize: 30)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.white
        dateLabel.adjustsFontSizeToFitWidth = true
        return dateLabel
    }()
    
    let subDateLabel: UILabel = {
        let subDateLabel = UILabel()
        subDateLabel.text = "오늘"
        subDateLabel.font = UIFont.systemFont(ofSize: 15)
        subDateLabel.textAlignment = .left
        subDateLabel.textColor = UIColor.white
        return subDateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviews()
        self.setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setSubviews() {
        self.addSubview(mainCelsiusLabel)
        self.addSubview(minCelsiusLabel)
        self.addSubview(maxCelsiusLabel)
        self.addSubview(dateLabel)
        self.addSubview(subDateLabel)
    }
    
    func setConstraints() {
        self.mainCelsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainCelsiusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainCelsiusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainCelsiusLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainCelsiusLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
            ])
        
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.widthAnchor.constraint(equalToConstant: 50)
            ])
        
        self.subDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subDateLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 10),
            subDateLabel.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            subDateLabel.heightAnchor.constraint(equalToConstant: 20)
                        ])
        
        self.minCelsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minCelsiusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            minCelsiusLabel.bottomAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 0),
            minCelsiusLabel.heightAnchor.constraint(equalToConstant: 20),
            minCelsiusLabel.widthAnchor.constraint(equalToConstant: 30)
            ])
        
        self.maxCelsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxCelsiusLabel.rightAnchor.constraint(equalTo: minCelsiusLabel.leftAnchor, constant: -10),
            maxCelsiusLabel.widthAnchor.constraint(equalTo: minCelsiusLabel.widthAnchor),
            maxCelsiusLabel.heightAnchor.constraint(equalTo: minCelsiusLabel.heightAnchor),
            maxCelsiusLabel.centerYAnchor.constraint(equalTo: minCelsiusLabel.centerYAnchor)
            ])
    }

}

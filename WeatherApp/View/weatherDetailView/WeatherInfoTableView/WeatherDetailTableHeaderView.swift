//
//  WeatherSubTitleView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 31/07/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 메인타이틀 하단의 테이블 헤더 뷰
public class WeatherDetailTableHeaderView: UIView {
    let mainCelsiusLabel: UILabel = {
        let celsiusLabel = UILabel()
        celsiusLabel.text = ""
        celsiusLabel.font = .systemFont(ofSize: 80)
        celsiusLabel.textAlignment = .center
        celsiusLabel.textColor = .white
        celsiusLabel.adjustsFontSizeToFitWidth = true
        return celsiusLabel
    }()

    let minCelsiusLabel: UILabel = {
        let minCelsiusLabel = UILabel()
        minCelsiusLabel.text = ""
        minCelsiusLabel.font = .systemFont(ofSize: 20)
        minCelsiusLabel.textAlignment = .center
        minCelsiusLabel.textColor = .gray
        minCelsiusLabel.adjustsFontSizeToFitWidth = true
        minCelsiusLabel.alpha = 0.7
        return minCelsiusLabel
    }()

    let maxCelsiusLabel: UILabel = {
        let maxCelsiusLabel = UILabel()
        maxCelsiusLabel.text = ""
        maxCelsiusLabel.font = .systemFont(ofSize: 20)
        maxCelsiusLabel.textAlignment = .center
        maxCelsiusLabel.textColor = .white
        maxCelsiusLabel.adjustsFontSizeToFitWidth = true
        return maxCelsiusLabel
    }()

    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = ""
        dateLabel.font = .systemFont(ofSize: 30)
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        dateLabel.adjustsFontSizeToFitWidth = true
        return dateLabel
    }()

    let subDateLabel: UILabel = {
        let subDateLabel = UILabel()
        subDateLabel.text = "오늘"
        subDateLabel.font = .systemFont(ofSize: 15)
        subDateLabel.textAlignment = .left
        subDateLabel.textColor = .white
        return subDateLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setTableHeaderViewAlpha(alpha: CGFloat) {
        for subview in subviews {
            subview.alpha = alpha
        }
        layoutIfNeeded()
    }

    func setTableHeaderViewFrame(rect: CGRect) {
        frame = rect
        layoutIfNeeded()
    }

    func setHeaderViewData(mainCelsius: Double, minCelsius: Double, maxCelsius: Double, timeStamp: Int) {
        let mainCelsius = CommonData.shared.calculateCelsius(celsius: mainCelsius)
        let minCelsius = CommonData.shared.calculateCelsius(celsius: minCelsius)
        let maxCelsius = CommonData.shared.calculateCelsius(celsius: maxCelsius)
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let nowDate = CommonData.shared.infoHeaderDateFormatter.string(from: date)

        mainCelsiusLabel.text = "\(mainCelsius)º"
        minCelsiusLabel.text = "\(minCelsius)"
        maxCelsiusLabel.text = "\(maxCelsius)"
        dateLabel.text = "\(nowDate)"
    }
}

extension WeatherDetailTableHeaderView: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(mainCelsiusLabel)
        addSubview(minCelsiusLabel)
        addSubview(maxCelsiusLabel)
        addSubview(dateLabel)
        addSubview(subDateLabel)
    }

    func makeConstraints() {
        mainCelsiusLabel.activateAnchors()
        NSLayoutConstraint.activate([
            mainCelsiusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainCelsiusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainCelsiusLabel.leftAnchor.constraint(equalTo: leftAnchor),
            mainCelsiusLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])

        dateLabel.activateAnchors()
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: CommonInset.leftInset),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.widthAnchor.constraint(equalToConstant: 50),
        ])

        subDateLabel.activateAnchors()
        NSLayoutConstraint.activate([
            subDateLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 10),
            subDateLabel.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            subDateLabel.heightAnchor.constraint(equalToConstant: 20),
        ])

        minCelsiusLabel.activateAnchors()
        NSLayoutConstraint.activate([
            minCelsiusLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -CommonInset.rightInset),
            minCelsiusLabel.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 0),
            minCelsiusLabel.heightAnchor.constraint(equalToConstant: 20),
            minCelsiusLabel.widthAnchor.constraint(equalToConstant: 30),
        ])

        maxCelsiusLabel.activateAnchors()
        NSLayoutConstraint.activate([
            maxCelsiusLabel.rightAnchor.constraint(equalTo: minCelsiusLabel.leftAnchor, constant: -CommonInset.rightInset / 2),
            maxCelsiusLabel.widthAnchor.constraint(equalTo: minCelsiusLabel.widthAnchor),
            maxCelsiusLabel.heightAnchor.constraint(equalTo: minCelsiusLabel.heightAnchor),
            maxCelsiusLabel.centerYAnchor.constraint(equalTo: minCelsiusLabel.centerYAnchor),
        ])
    }
}

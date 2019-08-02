//
//  TodayInfoTableHeaderView.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 오늘 날씨 서브정보를 알려주는 테이블뷰 셀 헤더뷰
class TodayInfoTableHeaderView: UIView {
    let todayInfoTextView: UITextView = {
        let todayInfoTextView = UITextView()
        todayInfoTextView.text = "오늘: 날씨 대체로 맑음, 체감 온도는 102º입니다."
        todayInfoTextView.backgroundColor = .clear
        todayInfoTextView.textContainerInset = UIEdgeInsets(
            top: todayInfoTextView.textContainer.lineFragmentPadding,
            left: -todayInfoTextView.textContainer.lineFragmentPadding,
            bottom: todayInfoTextView.textContainer.lineFragmentPadding,
            right: -todayInfoTextView.textContainer.lineFragmentPadding
        )
        todayInfoTextView.font = UIFont.systemFont(ofSize: 15)
        return todayInfoTextView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setSubviews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodayInfoTableHeaderView: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(todayInfoTextView)
    }

    func setConstraints() {
        todayInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayInfoTextView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: CommonInset.leftInset),
            todayInfoTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CommonInset.topInset),
            todayInfoTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -CommonInset.bottomInset),
            todayInfoTextView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -CommonInset.rightInset),
        ])
    }
}

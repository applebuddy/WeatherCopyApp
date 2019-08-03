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
        todayInfoTextView.isEditable = false
        todayInfoTextView.isSelectable = false
        todayInfoTextView.font = UIFont.systemFont(ofSize: 15)
        todayInfoTextView.contentMode = .scaleToFill
        return todayInfoTextView
    }()

    let headerBottomBorderView: UIView = {
        let headerBottomBorderView = UIView()
        headerBottomBorderView.backgroundColor = CommonColor.separator
        return headerBottomBorderView
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
        addSubview(headerBottomBorderView)
        addSubview(todayInfoTextView)
    }

    func setConstraints() {
        headerBottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerBottomBorderView.heightAnchor.constraint(equalToConstant: 1),
            headerBottomBorderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            headerBottomBorderView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            headerBottomBorderView.centerXAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.centerXAnchor, multiplier: 1),
        ])

        todayInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayInfoTextView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: CommonInset.leftInset),
            todayInfoTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CommonInset.topInset),
            todayInfoTextView.bottomAnchor.constraint(equalTo: headerBottomBorderView.topAnchor, constant: -CommonInset.bottomInset),
            todayInfoTextView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -CommonInset.rightInset),
        ])
    }
}

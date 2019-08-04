//
//  TodayInfoTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 02/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 오늘의 서브날씨정도 테이블뷰 셀
class TodayInfoTableViewCell: UITableViewCell {
    let todayInfoStackView: UIStackView = {
        let todayInfoStackView = UIStackView()
        todayInfoStackView.axis = .horizontal
        todayInfoStackView.distribution = .fillEqually
        return todayInfoStackView
    }()

    let leftStackView: UIStackView = {
        let leftStackView = UIStackView()
        leftStackView.axis = .vertical
        return leftStackView
    }()

    let cellBottomBorderView: UIView = {
        let cellBottomBorderView = UIView()
        cellBottomBorderView.backgroundColor = CommonColor.separator
        return cellBottomBorderView
    }()

    let rightStackView: UIStackView = {
        let rightStackView = UIStackView()
        rightStackView.axis = .vertical
        return rightStackView
    }()

    let leftInfoTitleLabel: UILabel = {
        let leftInfoTitleLabel = UILabel()
        leftInfoTitleLabel.text = "일몰"
        leftInfoTitleLabel.alpha = 0.7
        leftInfoTitleLabel.textColor = .gray
        leftInfoTitleLabel.font = .systemFont(ofSize: 12)
        return leftInfoTitleLabel
    }()

    let leftInfoTitleSubLabel: UILabel = {
        let leftInfoTitleSubLabel = UILabel()
        leftInfoTitleSubLabel.text = "새벽 3:57"
        leftInfoTitleSubLabel.font = .boldSystemFont(ofSize: 25)
        return leftInfoTitleSubLabel
    }()

    let rightInfoTitleLabel: UILabel = {
        let todayInfoTitleLabel = UILabel()
        todayInfoTitleLabel.text = "일출"
        todayInfoTitleLabel.alpha = 0.7
        todayInfoTitleLabel.textColor = .gray
        todayInfoTitleLabel.font = .systemFont(ofSize: 12)
        return todayInfoTitleLabel
    }()

    let rightInfoTitleSubLabel: UILabel = {
        let todayInfoTitleSubLabel = UILabel()
        todayInfoTitleSubLabel.text = "오전 5:36"
        todayInfoTitleSubLabel.font = .boldSystemFont(ofSize: 25)
        return todayInfoTitleSubLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        makeSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setLabelTitle(leftTitle: String, rightTitle: String) {
        leftInfoTitleLabel.text = leftTitle
        rightInfoTitleLabel.text = rightTitle
    }

    func setTodayInfoStackView() {
        leftStackView.addArrangedSubview(leftInfoTitleLabel)
        leftStackView.addArrangedSubview(leftInfoTitleSubLabel)
        rightStackView.addArrangedSubview(rightInfoTitleLabel)
        rightStackView.addArrangedSubview(rightInfoTitleSubLabel)
        todayInfoStackView.addArrangedSubview(leftStackView)
        todayInfoStackView.addArrangedSubview(rightStackView)
        addSubview(todayInfoStackView)
    }
}

extension TodayInfoTableViewCell: UIViewSettingProtocol {
    func makeSubviews() {
        setTodayInfoStackView()
        addSubview(cellBottomBorderView)
    }

    func makeConstraints() {
        cellBottomBorderView.activateAnchors()
        NSLayoutConstraint.activate([
            cellBottomBorderView.heightAnchor.constraint(equalToConstant: 1),
            cellBottomBorderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.9),
            cellBottomBorderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellBottomBorderView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

        todayInfoStackView.activateAnchors()
        NSLayoutConstraint.activate([
            todayInfoStackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -CommonInset.leftInset * 2),
            todayInfoStackView.topAnchor.constraint(equalTo: topAnchor, constant: CommonInset.topInset),
            todayInfoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            todayInfoStackView.bottomAnchor.constraint(equalTo: cellBottomBorderView.topAnchor, constant: -CommonInset.bottomInset / 2),
        ])

        leftStackView.activateAnchors()
        NSLayoutConstraint.activate([
            leftStackView.leftAnchor.constraint(equalTo: todayInfoStackView.leftAnchor),
            leftStackView.topAnchor.constraint(equalTo: todayInfoStackView.topAnchor),
            leftStackView.widthAnchor.constraint(equalTo: todayInfoStackView.widthAnchor, multiplier: 0.5),
            leftStackView.bottomAnchor.constraint(equalTo: todayInfoStackView.bottomAnchor),
        ])

        rightStackView.activateAnchors()
        NSLayoutConstraint.activate([
            rightStackView.rightAnchor.constraint(equalTo: todayInfoStackView.rightAnchor),
            rightStackView.topAnchor.constraint(equalTo: todayInfoStackView.topAnchor),
            rightStackView.widthAnchor.constraint(equalTo: todayInfoStackView.widthAnchor, multiplier: 0.5),
            rightStackView.bottomAnchor.constraint(equalTo: todayInfoStackView.bottomAnchor),
        ])

        leftInfoTitleLabel.activateAnchors()
        leftInfoTitleSubLabel.activateAnchors()
        rightInfoTitleLabel.activateAnchors()
        rightInfoTitleSubLabel.activateAnchors()
        NSLayoutConstraint.activate([
            leftInfoTitleLabel.heightAnchor.constraint(equalTo: leftStackView.heightAnchor, multiplier: 0.3),
            leftInfoTitleLabel.leftAnchor.constraint(equalTo: leftStackView.leftAnchor),
            leftInfoTitleLabel.rightAnchor.constraint(equalTo: leftStackView.rightAnchor),
        ])

        NSLayoutConstraint.activate([
            leftInfoTitleSubLabel.heightAnchor.constraint(equalTo: leftStackView.heightAnchor, multiplier: 0.7),
            leftInfoTitleSubLabel.leftAnchor.constraint(equalTo: leftStackView.leftAnchor),
            leftInfoTitleSubLabel.rightAnchor.constraint(equalTo: rightStackView.leftAnchor),
        ])

        NSLayoutConstraint.activate([
            rightInfoTitleLabel.heightAnchor.constraint(equalTo: rightStackView.heightAnchor, multiplier: 0.3),
            rightInfoTitleLabel.rightAnchor.constraint(equalTo: rightStackView.rightAnchor),
            rightInfoTitleLabel.leftAnchor.constraint(equalTo: rightStackView.leftAnchor),
        ])

        NSLayoutConstraint.activate([
            rightInfoTitleSubLabel.heightAnchor.constraint(equalTo: rightStackView.heightAnchor, multiplier: 0.7),
            rightInfoTitleSubLabel.rightAnchor.constraint(equalTo: rightStackView.rightAnchor),
            rightInfoTitleSubLabel.leftAnchor.constraint(equalTo: rightStackView.leftAnchor),
        ])
    }
}

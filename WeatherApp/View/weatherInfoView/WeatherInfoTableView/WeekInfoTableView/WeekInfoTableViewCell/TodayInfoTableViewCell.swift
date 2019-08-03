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
        leftInfoTitleLabel.textColor = UIColor.gray
        leftInfoTitleLabel.font = UIFont.systemFont(ofSize: 12)
        return leftInfoTitleLabel
    }()

    let leftInfoTitleSubLabel: UILabel = {
        let leftInfoTitleSubLabel = UILabel()
        leftInfoTitleSubLabel.text = "새벽 3:57"
        leftInfoTitleSubLabel.font = UIFont.boldSystemFont(ofSize: 25)
        return leftInfoTitleSubLabel
    }()

    let rightInfoTitleLabel: UILabel = {
        let todayInfoTitleLabel = UILabel()
        todayInfoTitleLabel.text = "일출"
        todayInfoTitleLabel.alpha = 0.7
        todayInfoTitleLabel.textColor = UIColor.gray
        todayInfoTitleLabel.font = UIFont.systemFont(ofSize: 12)
        return todayInfoTitleLabel
    }()

    let rightInfoTitleSubLabel: UILabel = {
        let todayInfoTitleSubLabel = UILabel()
        todayInfoTitleSubLabel.text = "오전 5:36"
        todayInfoTitleSubLabel.font = UIFont.boldSystemFont(ofSize: 25)
        return todayInfoTitleSubLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        setSubviews()
        setConstraints()
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
    func setSubviews() {
        setTodayInfoStackView()
        addSubview(cellBottomBorderView)
    }

    func setConstraints() {
        cellBottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellBottomBorderView.heightAnchor.constraint(equalToConstant: 1),
            cellBottomBorderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.9),
            cellBottomBorderView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            cellBottomBorderView.centerXAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.centerXAnchor, multiplier: 1),
        ])

        todayInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayInfoStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            todayInfoStackView.bottomAnchor.constraint(equalTo: cellBottomBorderView.topAnchor, constant: -CommonInset.bottomInset),
            todayInfoStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: CommonInset.leftInset),
            todayInfoStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -CommonInset.rightInset),
        ])

        leftInfoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftInfoTitleSubLabel.translatesAutoresizingMaskIntoConstraints = false
        rightInfoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightInfoTitleSubLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftInfoTitleLabel.heightAnchor.constraint(equalTo: todayInfoStackView.heightAnchor, multiplier: 0.5),
            leftInfoTitleSubLabel.heightAnchor.constraint(equalTo: leftInfoTitleLabel.heightAnchor),
            rightInfoTitleLabel.heightAnchor.constraint(equalTo: leftInfoTitleLabel.heightAnchor),
            rightInfoTitleSubLabel.heightAnchor.constraint(equalTo: leftInfoTitleLabel.heightAnchor),
        ])
    }
}

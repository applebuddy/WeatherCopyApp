//
//  DayInfoCollectionViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 현재시간 기준 24시간 동안의 날씨예보 컬렉션뷰 셀
class DayInfoCollectionViewCell: UICollectionViewCell {
    let cellImageView: UIImageView = {
        let cellImageView = UIImageView()
        cellImageView.image = #imageLiteral(resourceName: "cloud")
        cellImageView.contentMode = .scaleAspectFit
        return cellImageView
    }()

    let titleLabel: UILabel = {
        let firstLabel = UILabel()
        firstLabel.text = "지금"
        firstLabel.font = .boldSystemFont(ofSize: 15)
        firstLabel.textAlignment = .center
        return firstLabel
    }()

    let percentageLabel: UILabel = {
        let secondLabel = UILabel()
        secondLabel.text = "70%"
        secondLabel.font = .systemFont(ofSize: 10)
        secondLabel.textAlignment = .center
        return secondLabel
    }()

    let celsiusLabel: UILabel = {
        let thirdLabel = UILabel()
        thirdLabel.text = "92º"
        thirdLabel.font = .boldSystemFont(ofSize: 15)
        thirdLabel.textAlignment = .center
        return thirdLabel
    }()

    let cellStackView: UIStackView = {
        let cellStackView = UIStackView()
        cellStackView.axis = .vertical
        cellStackView.spacing = 5
        return cellStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()

        setConstraints()
        backgroundColor = .red
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    func setCellData() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    func setStackView() {
        cellStackView.addArrangedSubview(titleLabel)
        cellStackView.addArrangedSubview(percentageLabel)
        cellStackView.addArrangedSubview(cellImageView)
        cellStackView.addArrangedSubview(celsiusLabel)
    }
}

extension DayInfoCollectionViewCell: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(cellStackView)
        setStackView()
    }

    func setConstraints() {
        cellStackView.activateAnchors()

        cellStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        NSLayoutConstraint(item: cellStackView,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        cellStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        cellStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: CommonInset.topInset * 2).isActive = true
        cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CommonInset.bottomInset * 2).isActive = true

        cellImageView.activateAnchors()
        percentageLabel.activateAnchors()
        celsiusLabel.activateAnchors()
        titleLabel.activateAnchors()
        NSLayoutConstraint.activate([
            cellImageView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 0.3),
            percentageLabel.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 0.1),
            celsiusLabel.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 0.2),
            titleLabel.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 0.2),
        ])
    }
}

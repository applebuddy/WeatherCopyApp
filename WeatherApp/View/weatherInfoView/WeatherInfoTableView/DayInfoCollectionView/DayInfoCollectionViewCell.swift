//
//  DayInfoCollectionViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 현재시간 기준 24시간 동안의 날씨예보를 보여주는 컬렉션뷰 셀
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
        firstLabel.font = UIFont.systemFont(ofSize: 15)
        firstLabel.textAlignment = .center
        return firstLabel
    }()

    let percentageLabel: UILabel = {
        let secondLabel = UILabel()
        secondLabel.text = "70%"
        secondLabel.font = UIFont.systemFont(ofSize: 10)
        secondLabel.textAlignment = .center
        return secondLabel
    }()

    let celsiusLabel: UILabel = {
        let thirdLabel = UILabel()
        thirdLabel.text = "92º"
        thirdLabel.font = UIFont.systemFont(ofSize: 15)
        thirdLabel.textAlignment = .center
        return thirdLabel
    }()

    let cellStackView: UIStackView = {
        let cellStackView = UIStackView()
        cellStackView.axis = .vertical
        cellStackView.spacing = 3
        return cellStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()

        setConstraints()
        backgroundColor = UIColor.red
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
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            cellStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            cellStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            cellStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])

        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        celsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.heightAnchor.constraint(equalTo: percentageLabel.heightAnchor, multiplier: 1.5),
            cellImageView.heightAnchor.constraint(equalTo: celsiusLabel.heightAnchor, multiplier: 0.8),
        ])
    }
}

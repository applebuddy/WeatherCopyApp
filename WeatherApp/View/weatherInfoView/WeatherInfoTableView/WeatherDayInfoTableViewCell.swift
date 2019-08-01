//
//  weatherDayInfoTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherDayInfoTableViewCell: UITableViewCell {
    let dayInfoCollectionView: DayInfoCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: WeatherCellHeights.dayInfoCollectionCell)
        layout.minimumInteritemSpacing = 5

        // ✓ 컬렉션뷰의 frame을 CGRect.zero 설정하면, cellForItemAt delegate 메서드가 호출되지 않을 수 있다.
        let dayInfoCollectionView = DayInfoCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0), collectionViewLayout: layout)
        dayInfoCollectionView.isScrollEnabled = true
        dayInfoCollectionView.backgroundColor = UIColor.lightGray
        return dayInfoCollectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.blue
        setSubviews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCellData() {
        backgroundColor = UIColor.lightGray
    }
}

extension WeatherDayInfoTableViewCell: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(dayInfoCollectionView)
    }

    func setConstraints() {
        dayInfoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayInfoCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            dayInfoCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            dayInfoCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            dayInfoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            dayInfoCollectionView.heightAnchor.constraint(equalToConstant: WeatherCellHeights.dayInfoCollectionCell),
        ])
    }
}

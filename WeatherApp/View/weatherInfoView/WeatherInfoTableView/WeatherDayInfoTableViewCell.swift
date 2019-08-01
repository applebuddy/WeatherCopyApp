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
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 0

        // ✓ 컬렉션뷰의 frame을 CGRect.zero 설정하면, cellForItemAt delegate 메서드가 호출되지 않을 수 있다.
        let dayInfoCollectionView = DayInfoCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
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

    func setDayInfoCollectionView() {
        backgroundColor = UIColor.blue
        dayInfoCollectionView.backgroundColor = UIColor.lightGray
    }
}

extension WeatherDayInfoTableViewCell: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(dayInfoCollectionView)
    }

    func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            self.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            self.heightAnchor.constraint(equalToConstant: WeatherCellHeights.dayInfoTableCell),
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
        ])
//
//        self.dayInfoCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            dayInfoCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
//            dayInfoCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
//            dayInfoCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
//            dayInfoCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
//            ])
    }
}

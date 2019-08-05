//
//  weatherDayInfoTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

/// 시간 별 날씨정보 컬렉션뷰를 서브뷰로 갖는 테이블뷰 셀
class WeatherDayInfoTableViewCell: UITableViewCell {
    let dayInfoCollectionView: DayInfoCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cellSize = CGSize(width: 80, height: WeatherCellHeight.dayInfoCollectionCell)
        layout.itemSize = cellSize
        layout.minimumInteritemSpacing = 5

        // ✭ 컬렉션뷰의 frame을 CGRect.zero 설정하면, cellForItemAt delegate 메서드가 호출되지 않을 수 있다.
        let dayInfoCollectionView = DayInfoCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0), collectionViewLayout: layout)
        dayInfoCollectionView.isScrollEnabled = true
        dayInfoCollectionView.backgroundColor = .lightGray
        return dayInfoCollectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blue
        makeSubviews()
        makeConstraints()

        dayInfoCollectionView.register(DayInfoCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier.dayInfoCollectionCell)
        dayInfoCollectionView.delegate = self
        dayInfoCollectionView.dataSource = self
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
        backgroundColor = .lightGray
    }
}

// MARK: - UICollectionView Protocol

extension WeatherDayInfoTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.dayInfoCollectionCell, for: indexPath) as? DayInfoCollectionViewCell else { return UICollectionViewCell() }
        let weatherIndex = CommonData.shared.selectedMainCellIndex

        if weatherIndex == 0 {
            let weatherData = CommonData.shared.mainWeatherData
            let timeStamp = weatherData?.hourly.data[indexPath.item].time ?? 0
            let date = Date(timeIntervalSince1970: Double(timeStamp))
            var hour = CommonData.shared.dayInfoDateFormatter.string(from: date)
            if indexPath.item == 0 {
                hour = "지금"
            }
            let precipitation = weatherData?.hourly.data[indexPath.item].precipProbability ?? 0.0
            let imageType = weatherData?.hourly.data[indexPath.item].icon ?? WeatherType.clearDay
            let celsius = weatherData?.hourly.data[indexPath.item].temperature ?? 0.0
            cell.setDayInfoCollectionCellData(title: hour, preciptication: precipitation, imageType: imageType, celsius: celsius)
            cell.layoutIfNeeded()
        }

        return cell
    }
}

extension WeatherDayInfoTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return WeatherInfoCellCount.dayInfoCell
    }
}

// MARK: - Controller Protocol

extension WeatherInfoViewController: CellSettingProtocol {
    func registerCell() {
        weatherInfoView.weatherInfoTableView.register(WeatherDayInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherDayInfoTableCell)
        weatherInfoView.weatherInfoTableView.register(WeatherSubInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weatherWeekInfoTableCell)
    }
}

extension WeatherDayInfoTableViewCell: UIViewSettingProtocol {
    func makeSubviews() {
        addSubview(dayInfoCollectionView)
    }

    func makeConstraints() {
        dayInfoCollectionView.activateAnchors()
        NSLayoutConstraint.activate([
            dayInfoCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            dayInfoCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            dayInfoCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            dayInfoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            dayInfoCollectionView.heightAnchor.constraint(equalToConstant: WeatherCellHeight.dayInfoCollectionCell),
        ])
    }
}

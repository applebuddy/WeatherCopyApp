//
//  WeatherWeekInfoTableViewCell.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 01/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherWeekInfoTableViewCell: UITableViewCell {
    let weekInfoTableView: WeekInfoTableView = {
        let weekInfoTableView = WeekInfoTableView(frame: CGRect.zero, style: .grouped)
        return weekInfoTableView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraints()
        registerCell()
        weekInfoTableView.delegate = self
        weekInfoTableView.dataSource = self
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
        backgroundColor = UIColor.green
    }
}

extension WeatherWeekInfoTableViewCell: UIViewSettingProtocol {
    func setSubviews() {
        addSubview(weekInfoTableView)
    }

    func setConstraints() {
        weekInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekInfoTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            weekInfoTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            weekInfoTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            weekInfoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}

extension WeatherWeekInfoTableViewCell: CellSettingProtocol {
    func registerCell() {
        weekInfoTableView.register(WeekInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier.weekInfoTableCell)
    }
}

extension WeatherWeekInfoTableViewCell: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 100
    }
}

extension WeatherWeekInfoTableViewCell: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weekInfoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weekInfoTableCell, for: indexPath) as? WeekInfoTableViewCell else { return UITableViewCell() }

        return weekInfoCell
    }
}

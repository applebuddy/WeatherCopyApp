//
//  WeatherAPIProtocol.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 08/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

// MARK: - Weather API Protoocl

/// * **WeatherAPI 요청 간 상태를 감지하기 위해 사용하는 텔리게이트 프로토콜**
// ✓ Review: [Refactoring] Delegate는 class 에서만 사용해야 한다고 하네요.
// protocol WeatherAPIDelegate: class
protocol WeatherAPIDelegate: class {
    func weatherAPIDidRequested(_ weatherApi: WeatherAPI)
    func weatherAPIDidFinished(_ weatherApi: WeatherAPI)
    func weatherAPIDidError(_ weatherApi: WeatherAPI)
}

//
//  CommonData.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import CoreLocation
import UIKit

final class CommonData {
    static let shared = CommonData()

    var temperatureType: TemperatureType = .celsius
    var mainCelsius: Double?
    var isLocationAuthority = UserDefaults.standard.bool(forKey: DataIdentifier.isLocationAuthority)
    var mainCoordinate = WeatherCoordinate(latitude: 0, longitude: 0)
    var selectedMainCellIndex = 0
    var mainCityName = "-"
    var weatherURLString = "https://weather.com/ko-KR/weather/today/"
    var isAppForeground = false
    var mainWeatherData: WeatherAPIData?
    let locationManager = CLLocationManager()

    let mainDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "a HH:mm"
        mainDateFormatter.locale = Locale(identifier: "ko_KR")
        return mainDateFormatter
    }()

    let infoHeaderDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "EEEE"
        mainDateFormatter.locale = Locale(identifier: "ko_KR")
        return mainDateFormatter
    }()

    let hourInfoDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "a h시"
        mainDateFormatter.locale = Locale(identifier: "ko_KR")
        return mainDateFormatter
    }()

    let todayInfoDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "a h:mm"
        mainDateFormatter.locale = Locale(identifier: "ko_KR")
        return mainDateFormatter
    }()

    // MARK: - Set Method

    func setMainCelsius(celsius: String) {
        mainCelsius = Double(celsius)
    }

    func setLocationAuthData(isAuth: Bool) {
        UserDefaults.standard.set(isAuth, forKey: DataIdentifier.isLocationAuthority)
        isLocationAuthority = isAuth
    }

    func setMainCoordinate(latitude: Double, longitude: Double) {
        mainCoordinate.latitude = latitude
        mainCoordinate.longitude = longitude
    }

    func setMainCityName(coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { placeMarks, error in

            if error != nil {
                print("\(error?.localizedDescription ?? "could not get cityName")")
                return
            }
            guard let address = placeMarks?.first else { return }
            let cityName = address.dictionaryWithValues(forKeys: ["locality"])["locality"]
            guard let cityNameString = cityName as? String else { return }
            self.mainCityName = cityNameString
        }
    }

    func setSelectedMainCellIndex(index: Int) {
        selectedMainCellIndex = index
    }

    func changeTemperatureType() {
        switch temperatureType {
        case .celsius:
            temperatureType = .fahrenheit
        case .fahrenheit:
            temperatureType = .celsius
        }
    }

    func setMainWeatherData(weatherData: WeatherAPIData) {
        mainWeatherData = weatherData
    }

    func setIsAppForegroundValue(isForeground: Bool) {
        isAppForeground = isForeground
    }

    // MARK: - Get Method

    func calculateCelsius(celsius: Double) -> Int {
        var celsius = celsius

        switch temperatureType {
        case .celsius:
            celsius = celsius.changeTemperatureFToC().roundedValue(roundSize: 0)
        case .fahrenheit:
            celsius = celsius.roundedValue(roundSize: 0)
        }
        return Int(celsius)
    }

    func getWeatherImage(imageType: WeatherType) -> UIImage {
        let weatherImageIndex: String
        switch imageType {
        case .clearDay:
            weatherImageIndex = imageType.rawValue
        case .clearNight:
            weatherImageIndex = imageType.rawValue
        case .rain:
            weatherImageIndex = imageType.rawValue
        case .snow:
            weatherImageIndex = imageType.rawValue
        case .sleet:
            weatherImageIndex = imageType.rawValue
        case .wind:
            weatherImageIndex = imageType.rawValue
        case .fog:
            weatherImageIndex = imageType.rawValue
        case .cloudy:
            weatherImageIndex = imageType.rawValue
        case .partlyCloudyDay:
            weatherImageIndex = imageType.rawValue
        case .partlyCloudyNight:
            weatherImageIndex = imageType.rawValue
        case .hail:
            weatherImageIndex = imageType.rawValue
        case .thunderstorm:
            weatherImageIndex = imageType.rawValue
        case .tornado:
            weatherImageIndex = imageType.rawValue
        }
        guard let image = UIImage(named: weatherImageIndex) else { return UIImage() }
        return image
    }

    // MARK: Action Method

    func openWeatherURL(latitude: Double, longitude: Double) {
        let CustomUrlString = "\(CommonData.shared.weatherURLString)\(latitude),\(longitude)?par=apple_widget&locale=ko_KR"
        if latitude != 0.0, longitude != 0.0 {
            if let url = NSURL(string: CustomUrlString) {
                UIApplication.shared.open(url as URL)
            }
        } else {
            if let url = NSURL(string: "\(CommonData.shared.weatherURLString)") {
                UIApplication.shared.open(url as URL)
            }
        }
    }

    // MARK: Check Method

    func checkLocationAuthority() -> Bool {
        return isLocationAuthority
    }

    // MARK: - Get Method

    func getSelectedMainCellIndex() -> Int {
        return selectedMainCellIndex
    }

    func getIsAppForegroundValue() -> Bool {
        return isAppForeground
    }
}

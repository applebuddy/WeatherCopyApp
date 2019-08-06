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

    public var weatherURLString = "https://weather.com/ko-KR/weather/today/"
    public var mainCityName = "-"
    public var subCityNameList = [String]()
    public var subWeatherDataList = [SubWeatherData]()
    public var subLocationDataList = [SubLocationData]()
    public var mainWeatherData: WeatherAPIData?

    public var temperatureType: TemperatureType = .celsius
    public var mainCelsius: Double?
    public var isLocationAuthority = UserDefaults.standard.bool(forKey: DataIdentifier.isLocationAuthority)
    public var mainCoordinate = WeatherCoordinate(latitude: 0, longitude: 0)
    public var selectedMainCellIndex = 0

    public var isAppForeground = false

    public let locationManager = CLLocationManager()

    public let mainDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "a h:mm"
        mainDateFormatter.locale = Locale(identifier: "ko_KR")
        return mainDateFormatter
    }()

    public let infoHeaderDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "EEEE"
        mainDateFormatter.locale = Locale(identifier: "ko_KR")
        return mainDateFormatter
    }()

    public let hourInfoDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "a h시"
        mainDateFormatter.locale = Locale(identifier: "ko_KR")
        return mainDateFormatter
    }()

    public let todayInfoDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "a h:mm"
        mainDateFormatter.locale = Locale(identifier: "ko_KR")
        return mainDateFormatter
    }()

    // MARK: - Set Method

    public func setDateFormatter(dateFormatter: DateFormatter, timeZone: String, timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let newDateFormatter = dateFormatter
        var timeZoneIdentifier = "KST"

        for (key, value) in TimeZone.abbreviationDictionary {
            if timeZone == value {
                timeZoneIdentifier = key
                break
            }
        }

        newDateFormatter.timeZone = TimeZone(abbreviation: timeZoneIdentifier)
        let formattedDate = newDateFormatter.string(from: date)
        return formattedDate
    }

    public func setMainCelsius(celsius: String) {
        mainCelsius = Double(celsius)
    }

    public func setLocationAuthData(isAuth: Bool) {
        UserDefaults.standard.set(isAuth, forKey: DataIdentifier.isLocationAuthority)
        isLocationAuthority = isAuth
    }

    public func setMainCoordinate(latitude: Double, longitude: Double) {
        mainCoordinate.latitude = latitude
        mainCoordinate.longitude = longitude
    }

    // MARK: Set SubWeatherDataList

    public func addSubWeatherData(coordinate: CLLocationCoordinate2D, defaultCityName _: String, completion: @escaping () -> Void) {
        var weatherData = SubWeatherData(subData: nil, subCityName: "")

        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let subLocationData = SubLocationData(latitude: coordinate.latitude, longitude: coordinate.longitude)

        let geoCoder = CLGeocoder()

        let locale = Locale(identifier: "Ko-kr")
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { placeMarks, error in

            if error != nil {
                print("\(error?.localizedDescription ?? "could not get cityName")")
                return
            }

            guard let address = placeMarks?.first else { return }
            let cityName = address.dictionaryWithValues(forKeys: ["locality"])["locality"]
            guard let cityNameString = cityName as? String else {
                self.subWeatherDataList.append(weatherData)
                self.subLocationDataList.append(subLocationData)
                completion()
                return
            }
            weatherData.subCityName = cityNameString
            self.subWeatherDataList.append(weatherData)
            self.subLocationDataList.append(subLocationData)
            completion()
        }
    }

    public func setMainCityName(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
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

    public func setSubWeatherData(_ weatherData: WeatherAPIData, index: Int) {
        if subWeatherDataList.count - 1 >= index {
            subWeatherDataList[index].subData = weatherData
        }
    }

    public func saveSubWeatherDataList() {
        if let subWeatherData = try? JSONEncoder().encode(subWeatherDataList) {
            UserDefaults.standard.set(subWeatherData, forKey: DataIdentifier.subWeatherDataList)
        }

        if let subLocationData = try? JSONEncoder().encode(subLocationDataList) {
            UserDefaults.standard.set(subLocationData, forKey: DataIdentifier.subLocationDataList)
        }
    }

    public func setSubWeatherDataList() {
        if let subData = UserDefaults.standard.value(forKey: DataIdentifier.subWeatherDataList) as? Data,
            let subDataList = try? JSONDecoder().decode([SubWeatherData].self, from: subData) {
            subWeatherDataList = subDataList
        }
    }

    public func setSubWeatherLocationList() {
        if let subData = UserDefaults.standard.value(forKey: DataIdentifier.subLocationDataList) as? Data,
            let subLocationList = try? JSONDecoder().decode([SubLocationData].self, from: subData) {
            subLocationDataList = subLocationList
        }
    }

    public func setSelectedMainCellIndex(index: Int) {
        selectedMainCellIndex = index
    }

    public func initSubWeatherDataList() {
        subWeatherDataList = [SubWeatherData]()
    }

    public func addSubWeatherList(weatherData: WeatherAPIData, index: Int) {
        subWeatherDataList[index].subData = weatherData
    }

    public func changeTemperatureType() {
        switch temperatureType {
        case .celsius:
            temperatureType = .fahrenheit
        case .fahrenheit:
            temperatureType = .celsius
        }
    }

    public func setMainWeatherData(weatherData: WeatherAPIData) {
        mainWeatherData = weatherData
    }

    public func setIsAppForegroundValue(isForeground: Bool) {
        isAppForeground = isForeground
    }

    // MARK: - Get Method

    public func calculateCelsius(celsius: Double) -> Int {
        var celsius = celsius

        switch temperatureType {
        case .celsius:
            celsius = celsius.changeTemperatureFToC().roundedValue(roundSize: 0)
        case .fahrenheit:
            celsius = celsius.roundedValue(roundSize: 0)
        }
        return Int(celsius)
    }

    public func getWeatherImage(imageType: WeatherType) -> UIImage {
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

    public func openWeatherURL(latitude: Double, longitude: Double) {
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

    public func checkLocationAuthority() -> Bool {
        return isLocationAuthority
    }

    // MARK: - Get Method

    public func getSelectedMainCellIndex() -> Int {
        return selectedMainCellIndex
    }

    public func getIsAppForegroundValue() -> Bool {
        return isAppForeground
    }
}

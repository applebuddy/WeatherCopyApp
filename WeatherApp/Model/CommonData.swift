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

    var weatherURLString = "https://weather.com/ko-KR/weather/today/"

    var mainCityName = "-"
    var mainCelsius: Double?

    var subCityNameList = [String]()
    var weatherDataList = [SubWeatherData]()
    var subWeatherDataList = [SubWeatherData]()
    var weatherLocationDataList = [SubLocationData]()

    var temperatureType: TemperatureType = .celsius

    var isLocationAuthority = UserDefaults.standard.bool(forKey: DataIdentifier.isLocationAuthority)
    var mainCoordinate = WeatherCoordinate(latitude: 0, longitude: 0)
    var selectedMainCellIndex = 0

    var isAppForeground = false

    let locationManager = CLLocationManager()

    let mainDateFormatter: DateFormatter = {
        let mainDateFormatter = DateFormatter()
        mainDateFormatter.dateFormat = "a h:mm"
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

    func initWeatherDataListSize() {}

    func setUserDefaultsData() {
        setWeatherLocationList()
        setWeatherDataList()
    }

    func setDateFormatter(dateFormatter: DateFormatter, timeZone: String, timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let newDateFormatter = dateFormatter

        newDateFormatter.timeZone = TimeZone(identifier: timeZone)
        let formattedDate = newDateFormatter.string(from: date)
        return formattedDate
    }

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

    // MARK: Set SubWeatherDataList

    func addSubWeatherData(coordinate: CLLocationCoordinate2D, defaultCityName _: String, completion: @escaping (Bool) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let subLocationData = SubLocationData(latitude: coordinate.latitude, longitude: coordinate.longitude)

        let geoCoder = CLGeocoder()

        let locale = Locale(identifier: "Ko-kr")
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { placeMarks, error in

            if error != nil {
                return
            }

            guard let address = placeMarks?.first else { return }
            let cityName = address.dictionaryWithValues(forKeys: ["locality"])["locality"]
            guard let cityNameString = cityName as? String else {
                completion(false)
                return
            }

            WeatherAPI.shared.requestAPI(latitude: coordinate.latitude, longitude: coordinate.longitude) { weatherAPIData in

                let weatherData = SubWeatherData(subData: weatherAPIData, subCityName: cityNameString)
                self.weatherDataList.append(weatherData)
                self.weatherLocationDataList.append(subLocationData)
                completion(true)
            }
        }
    }

    func setMainCityName(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { placeMarks, error in

            if error != nil {
                return
            }
            guard let address = placeMarks?.first else { return }
            let cityName = address.dictionaryWithValues(forKeys: ["locality"])["locality"]
            guard let cityNameString = cityName as? String else { return }
            self.mainCityName = cityNameString
        }
    }

    func setWeatherData(_ weatherData: WeatherAPIData, index: Int) {
        weatherDataList[index].subData = weatherData
    }

    // 저장 구현 준비중
    func saveWeatherDataList() {
        if let subWeatherData = try? JSONEncoder().encode(weatherDataList) {
            UserDefaults.standard.set(subWeatherData, forKey: DataIdentifier.weatherDataList)
        }

        if let subLocationData = try? JSONEncoder().encode(weatherLocationDataList) {
            UserDefaults.standard.set(subLocationData, forKey: DataIdentifier.locationDataList)
        }
    }

    func setWeatherDataList() {
        if let subData = UserDefaults.standard.value(forKey: DataIdentifier.weatherDataList) as? Data,
            let dataList = try? JSONDecoder().decode([SubWeatherData].self, from: subData) {
            for data in dataList {
                weatherDataList.append(data)
            }
        } else {
            weatherDataList = [SubWeatherData](repeating: SubWeatherData(), count: 1)
        }
    }

    func setWeatherLocationList() {
        if let subData = UserDefaults.standard.value(forKey: DataIdentifier.locationDataList) as? Data,
            let locationList = try? JSONDecoder().decode([SubLocationData].self, from: subData) {
            for locationData in locationList {
                weatherLocationDataList.append(locationData)
            }
        } else {
            weatherLocationDataList = [SubLocationData](repeating: SubLocationData(), count: 1)
        }
    }

    func setSelectedMainCellIndex(index: Int) {
        selectedMainCellIndex = index
    }

    func initSubWeatherDataList() {
        weatherDataList = [SubWeatherData]()
    }

    func addSubWeatherList(weatherData: WeatherAPIData, index: Int) {
        weatherDataList[index].subData = weatherData
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
        weatherDataList[0].subCityName = mainCityName
        weatherDataList[0].subData = weatherData
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
        let weatherImageIndex = imageType.rawValue
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

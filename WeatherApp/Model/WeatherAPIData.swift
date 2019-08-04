
import UIKit

// MARK: - WeatherAPIData

// MARK: - Empty

struct WeatherAPIData: Codable {
    let latitude, longitude: Double
    let timezone: String
    let currently: Currently
    let hourly: Hourly
    let daily: Daily
    let offset: Int
}

// MARK: - Currently

struct Currently: Codable {
    let time: Int
    let summary: Summary
    let icon: Icon
    let nearestStormDistance: Int?
    let precipIntensity, precipProbability: Double
    let precipType: PrecipType?
    let temperature, apparentTemperature, dewPoint, humidity: Double
    let pressure, windSpeed, windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility, ozone: Double
}

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
}

enum PrecipType: String, Codable {
    case rain
}

enum Summary: String, Codable {
    case 맑음
    case 습함
    case 습함약간흐림 = "습함, 약간 흐림"
    case 습함흐림 = "습함, 흐림"
    case 약간흐림 = "약간 흐림"
    case 흐림
}

// MARK: - Daily

struct Daily: Codable {
    let summary: String
    let icon: PrecipType
    let data: [SubInfo]
}

// MARK: - Datum

struct SubInfo: Codable {
    let time: Int
    let summary, icon: String
    let sunriseTime, sunsetTime: Int
    let moonPhase, precipIntensity, precipIntensityMax: Double
    let precipIntensityMaxTime: Int
    let precipProbability: Double
    let precipType: PrecipType
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
    let windGustTime, windBearing: Int
    let cloudCover: Double
    let uvIndex, uvIndexTime: Int
    let visibility, ozone, temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
}

// MARK: - Hourly

struct Hourly: Codable {
    let summary: String
    let icon: Icon
    let data: [Currently]
}


import UIKit

// MARK: - WeatherAPIData

// MARK: - WeatherAPIData

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
    let summary: String
    let time: Int
    let icon: WeatherType
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

enum WeatherType: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain, snow, sleet, wind
    case fog, cloudy
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case hail, thunderstorm, tornado
}

enum PrecipType: String, Codable {
    case rain
    case snow
    case sleet
}

// MARK: - Daily

struct Daily: Codable {
    let summary: String
    let icon: WeatherType
    let data: [SubInfo]
}

// MARK: - SubInfo

struct SubInfo: Codable {
    let time: Int
    let icon: String
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
    let icon: WeatherType
    let data: [Currently]
}

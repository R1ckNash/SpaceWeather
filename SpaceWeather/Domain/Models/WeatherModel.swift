//
//  WeatherModel.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

struct WeatherModel {
    let name: String
    let temp: Int
    let description: String
    let humidity: Int
    let pressure: Int
    let iconName: String
    
    private static func iconNameForWeather(conditionId: Int, icon: String) -> String {
        let isNight = icon.hasSuffix("n")
        
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return isNight ? "moon.stars" : "sun.max"
        case 801:
            return isNight ? "cloud.moon" : "cloud.sun"
        case 802:
            return "cloud"
        case 803, 804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
}

extension WeatherModel {
    init(weatherDto: WeatherDTO) {
        name = weatherDto.name
        temp = Int(weatherDto.main.temp)
        description = weatherDto.weather.first?.description ?? "Описание отсутствует"
        humidity = weatherDto.main.humidity
        pressure = weatherDto.main.pressure
        
        let conditionId = weatherDto.weather.first?.id ?? 0
        let iconCode = weatherDto.weather.first?.icon ?? ""
        iconName = WeatherModel.iconNameForWeather(conditionId: conditionId, icon: iconCode)
    }
}

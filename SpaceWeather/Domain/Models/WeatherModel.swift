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
    
}

extension WeatherModel {
    
    init(weatherDto: CurrentWeatherDTO) {
        name = weatherDto.name
        temp = Int(weatherDto.main.temp)
        description = weatherDto.weather.first?.description ?? "Empty description".localized
        humidity = weatherDto.main.humidity
        pressure = weatherDto.main.pressure
        
        let conditionId = weatherDto.weather.first?.id ?? 0
        let iconCode = weatherDto.weather.first?.icon ?? ""
        let isNight = iconCode.hasSuffix("n")
        
        switch conditionId {
        case 200...232:
            iconName = "cloud.bolt"
        case 300...321:
            iconName = "cloud.drizzle"
        case 500...531:
            iconName = "cloud.rain"
        case 600...622:
            iconName = "cloud.snow"
        case 701...781:
            iconName = "cloud.fog"
        case 800:
            iconName = isNight ? "moon.stars" : "sun.max"
        case 801:
            iconName = isNight ? "cloud.moon" : "cloud.sun"
        case 802:
            iconName = "cloud"
        case 803, 804:
            iconName = "cloud.fill"
        default:
            iconName = "cloud"
        }
    }
    
}

//
//  CurrentWeatherDTO.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

struct CurrentWeatherDTO: Codable {
    let name: String
    let weather: [WeatherDTO]
    let main: MainDTO
}

struct WeatherDTO: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainDTO: Codable {
    let temp: Float
    let feelsLike: Float
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

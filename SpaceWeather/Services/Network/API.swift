//
//  API.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 15/09/2024.
//

import Foundation

enum API {
    
    //GET Current weather
    case fetchWeather
    
    var path: String {
        switch self {
        case .fetchWeather:
            return "https://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg,ru&appid=fcb53881381b95a0d5ae2afc1964bdc0&units=metric"
        }
    }
}

//
//  CurrentWeatherDTO.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

struct CurrentWeatherDTO {
    
    let weather: [Weather]
    
    
}

struct Weather {
    let id: Int
    let main: String
    let description: String
    
}


//"weather": [
//    {
//      "id": 800,
//      "main": "Clear",
//      "description": "clear sky",
//      "icon": "01d"
//    }
//  ]

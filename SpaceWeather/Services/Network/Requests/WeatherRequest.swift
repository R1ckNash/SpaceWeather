//
//  WeatherRequest.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 15/09/2024.
//

import Foundation

struct WeatherRequest: APIRequest {
    
    var urlString: String { API.fetchWeather.path }
    
}

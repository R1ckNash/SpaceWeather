//
//  WeatherDetailsInteractor.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherDetailsInteractorInput {
    
}

final class WeatherDetailsInteractor {
    
    private let presenter: WeatherDetailsPresenter
    private let weatherService: WeatherServiceProtocol
    
    init(presenter: WeatherDetailsPresenter, weatherService: WeatherServiceProtocol) {
        self.presenter = presenter
        self.weatherService = weatherService
    }
}

extension WeatherDetailsInteractor: WeatherDetailsInteractorInput {
    
}

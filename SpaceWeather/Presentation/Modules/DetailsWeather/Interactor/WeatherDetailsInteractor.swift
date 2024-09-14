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
    private let networkService: NetworkServiceProtocol
    
    init(presenter: WeatherDetailsPresenter, networkService: NetworkServiceProtocol) {
        self.presenter = presenter
        self.networkService = networkService
    }
}

extension WeatherDetailsInteractor: WeatherDetailsInteractorInput {
    
}

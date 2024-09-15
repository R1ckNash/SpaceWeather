//
//  WeatherDetailsPresenter.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherDetailsPresenterInput {
    func showLoading()
    func showError(_ error: Error)
    func showContent(_ model: WeatherModel)
}

final class WeatherDetailsPresenter {
    
    //MARK: - Properties
    weak var view: WeatherDetailsViewControllerInput?
}

//MARK: - Extensions
extension WeatherDetailsPresenter: WeatherDetailsPresenterInput {
    
    func showLoading() {
        view?.configure(state: .loading)
    }
    
    func showError(_ error: Error) {
        view?.configure(state: .error(error))
    }
    
    func showContent(_ model: WeatherModel) {
        view?.configure(state: .content(model))
    }
    
}

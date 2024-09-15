//
//  WeatherMainPresenter.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherMainPresenterInput {
    func showLoading()
    func showError(_ error: Error)
    func showContent(_ model: WeatherModel)
}

final class WeatherMainPresenter {
    
    //MARK: - Properties
    weak var view: WeatherMainViewControllerInput?
}

//MARK: - Extensions
extension WeatherMainPresenter: WeatherMainPresenterInput {
    
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

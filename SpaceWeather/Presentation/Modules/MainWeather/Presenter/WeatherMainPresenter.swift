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
    func showContent()
}

final class WeatherMainPresenter {
    
    weak var view: WeatherMainViewControllerInput?
}

extension WeatherMainPresenter: WeatherMainPresenterInput {
    
    func showLoading() {
        view?.configure(state: .loading)
    }
    
    func showError(_ error: Error) {
        view?.configure(state: .error(error))
    }
    
    func showContent() {
        view?.configure(state: .content)
    }
}

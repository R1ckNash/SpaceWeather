//
//  WeatherMainPresenter.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherMainPresenterInput {
    func showLoading()
}

final class WeatherMainPresenter {
    
    weak var view: WeatherMainViewControllerInput?
}

extension WeatherMainPresenter: WeatherMainPresenterInput {
    
    func showLoading() {
        view?.configure(state: .loading)
    }
    
    
}

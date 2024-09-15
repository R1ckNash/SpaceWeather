//
//  WeatherDetailsInteractor.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherDetailsInteractorInput: AnyObject {
    func viewDidLoad()
}

final class WeatherDetailsInteractor {
    
    //MARK: - Properties
    private let presenter: WeatherDetailsPresenter
    private let weatherModel: WeatherModel
    
    //MARK: - Lifecycle
    init(presenter: WeatherDetailsPresenter, weatherModel: WeatherModel) {
        self.presenter = presenter
        self.weatherModel = weatherModel
    }
    
}

//MARK: - Extensions
extension WeatherDetailsInteractor: WeatherDetailsInteractorInput {
    
    func viewDidLoad() {
        presenter.showContent(weatherModel)
    }
    
}

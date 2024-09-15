//
//  WeatherDetailsBuilder.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation
import UIKit

final class WeatherDetailsBuilder {
    
    //MARK: - Properties
    private let container: DIContainer
    private let weatherModel: WeatherModel
    
    //MARK: - Lifecycle
    init(container: DIContainer, weatherModel: WeatherModel) {
        self.container = container
        self.weatherModel = weatherModel
    }
}

//MARK: - Extensions
extension WeatherDetailsBuilder: BuilderProtocol {
    
    func build() -> UIViewController {
        let presenter = WeatherDetailsPresenter()
        let interactor = WeatherDetailsInteractor(presenter: presenter, weatherModel: weatherModel)
        let viewController = WeatherDetailsViewController(interactor: interactor)
        
        presenter.view = viewController
        return viewController
    }
    
}

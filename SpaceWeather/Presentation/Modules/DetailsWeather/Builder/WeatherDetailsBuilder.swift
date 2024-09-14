//
//  WeatherDetailsBuilder.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation
import UIKit

final class WeatherDetailsBuilder {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
}

extension WeatherDetailsBuilder: BuilderProtocol {
    
    func build() -> UIViewController {
        let presenter = WeatherDetailsPresenter()
        let interactor = WeatherDetailsInteractor(presenter: presenter,
                                               weatherService: container.weatherService)
        
        let viewController = WeatherDetailsViewController(interactor: interactor)
        
        presenter.view = viewController
        
        return viewController
    }
    
}

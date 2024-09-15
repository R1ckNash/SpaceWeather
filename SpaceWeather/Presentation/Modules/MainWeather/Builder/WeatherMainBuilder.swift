//
//  WeatherMainBuilder.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    func build() -> UIViewController
}

final class WeatherMainBuilder {
    
    //MARK: - Properties
    private let container: DIContainer
    
    //MARK: - Lifecycle
    init(container: DIContainer) {
        self.container = container
    }
}

//MARK: - Extensions
extension WeatherMainBuilder: BuilderProtocol {
    
    func build() -> UIViewController {
        let presenter = WeatherMainPresenter()
        let router = WeatherMainRouter(container: container)
        let interactor = WeatherMainInteractor(presenter: presenter,
                                               router: router,
                                               weatherService: container.weatherService)
        let viewController = WeatherMainViewController(interactor: interactor)
        
        router.view = viewController
        presenter.view = viewController
        return viewController
    }
    
}

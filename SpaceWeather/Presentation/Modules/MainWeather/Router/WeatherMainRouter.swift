//
//  WeatherMainRouter.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation
import UIKit


protocol WeatherMainRouterInput {
    func openDetailsScreen(with model: WeatherModel)
}

final class WeatherMainRouter {
    
    //MARK: - Properties
    weak var view: UIViewController?
    private let container: DIContainer
    
    //MARK: - Lifecycle
    init(container: DIContainer) {
        self.container = container
    }
}

//MARK: - Extensions
extension WeatherMainRouter: WeatherMainRouterInput {
    
    func openDetailsScreen(with model: WeatherModel) {
        let detailsViewController = WeatherDetailsBuilder(container: container, weatherModel: model).build()
        view?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

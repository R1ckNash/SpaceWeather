//
//  WeatherMainRouter.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation
import UIKit


protocol WeatherMainRouterInput {
    func openDetailsScreen()
}

protocol WeatherRouterProtocol {
    
}

final class WeatherMainRouter: WeatherRouterProtocol {
    
    weak var view: UIViewController?
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
}

extension WeatherMainRouter: WeatherMainRouterInput {
    
    func openDetailsScreen() {
        let detailsViewController = WeatherDetailsBuilder(container: container).build()
        view?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

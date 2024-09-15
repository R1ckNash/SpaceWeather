//
//  AppRouter.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation
import UIKit

final class AppRouter {
    
    //MARK: - Properties
    private let window: UIWindow
    private let container: DIContainer
    
    //MARK: - Lifecycle
    init(window: UIWindow, container: DIContainer) {
        self.window = window
        self.container = container
    }
    
    //MARK: - Public methods
    func start() {
        let builder = WeatherMainBuilder(container: container)
        
        let mainViewController = builder.build()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}

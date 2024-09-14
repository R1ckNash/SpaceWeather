//
//  WeatherMainInteractor .swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherMainInteractorInput: AnyObject {
    func viewDidLoad()
    func didTapDetailsButton()
}

final class WeatherMainInteractor {
    
    private let presenter: WeatherMainPresenterInput
    private let router: WeatherMainRouter
    private let networkService: NetworkServiceProtocol
    
    init(presenter: WeatherMainPresenter, router: WeatherMainRouter, networkService: NetworkServiceProtocol) {
        self.presenter = presenter
        self.router = router
        self.networkService = networkService
    }
    
    func loadCurrentWeather() {
        
    }
        
}

extension WeatherMainInteractor: WeatherMainInteractorInput {
    
    func didTapDetailsButton() {
        router.openDetailsScreen()
    }
    
    func viewDidLoad() {
        presenter.showLoading()
        loadCurrentWeather()
    }
    
    
}

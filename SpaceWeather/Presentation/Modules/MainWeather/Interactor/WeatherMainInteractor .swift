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
    func didTapUpdateButton()
}

final class WeatherMainInteractor {
    
    private let presenter: WeatherMainPresenterInput
    private let router: WeatherMainRouter
    private let weatherService: WeatherServiceProtocol
    
    init(presenter: WeatherMainPresenter, router: WeatherMainRouter, weatherService: WeatherServiceProtocol) {
        self.presenter = presenter
        self.router = router
        self.weatherService = weatherService
    }
    
    func fetchCurrentWeather() {
        weatherService.fetch { [weak self] result in
            DispatchQueue.main.async {
                self?.handle(result)
            }
        }
    }
    
    func handle(_ result: Result<WeatherDTO, ApiError>) {
        switch result {
        case .success(let weatherDto):
            print(weatherDto)
            // map to domain
            presenter.showContent()
        case .failure(let error):
            presenter.showError(error)
        }
    }
        
}

extension WeatherMainInteractor: WeatherMainInteractorInput {
    
    func didTapDetailsButton() {
        router.openDetailsScreen()
    }
    
    func didTapUpdateButton() {
        presenter.showLoading()
        fetchCurrentWeather()
    }
    
    func viewDidLoad() {
        presenter.showLoading()
        fetchCurrentWeather()
    }
    
    
}

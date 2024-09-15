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
    
    //MARK: - Properties
    private let presenter: WeatherMainPresenterInput
    private let router: WeatherMainRouterInput
    private let weatherService: WeatherServiceProtocol
    
    private var weatherModel: WeatherModel?
    
    //MARK: - Lifecycle
    init(presenter: WeatherMainPresenter, router: WeatherMainRouterInput, weatherService: WeatherServiceProtocol) {
        self.presenter = presenter
        self.router = router
        self.weatherService = weatherService
    }
    
    //MARK: - Public methods
    func fetchCurrentWeather() {
        weatherService.fetch { [weak self] result in
            DispatchQueue.main.async {
                self?.handle(result)
            }
        }
    }
    
    func handle(_ result: Result<CurrentWeatherDTO, APIError>) {
        switch result {
        case .success(let weatherDto):
            let weatherModel = WeatherModel(weatherDto: weatherDto)
            self.weatherModel = weatherModel
            presenter.showContent(weatherModel)
        case .failure(let error):
            presenter.showError(error)
        }
    }
        
}

//MARK: - Extensions
extension WeatherMainInteractor: WeatherMainInteractorInput {
    
    func didTapDetailsButton() {
        if let model = weatherModel {
            router.openDetailsScreen(with: model)
        }
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

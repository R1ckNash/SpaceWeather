//
//  WeatherService.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetch(completion: @escaping (Result<CurrentWeatherDTO, APIError>) -> Void)
}

final class WeatherService {

    //MARK: - Properties
    let remote: WeatherRemoteDataSourceProtocol
    let local: WeatherLocalDataSourceProtocol
    
    //MARK: - Lifecycle
    init(remote: WeatherRemoteDataSourceProtocol, local: WeatherLocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }
}

//MARK: - Extensions
extension WeatherService: WeatherServiceProtocol {
    
    func fetch(completion: @escaping (Result<CurrentWeatherDTO, APIError>) -> Void) {
        
        remote.fetch { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let weatherDto):
                self.local.saveData(weatherDto)
                completion(.success(weatherDto))
                
            case .failure:
                if let cachedData = self.local.loadData() {
                    completion(.success(cachedData))
                } else {
                    completion(.failure(.somethingWentWrong))
                }
            }
        }
    }
    
}

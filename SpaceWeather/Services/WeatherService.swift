//
//  WeatherService.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetch(completion: @escaping (Result<WeatherDTO, ApiError>) -> Void)
}

final class WeatherService {

    //MARK: - Properties
    let remote: RemoteDataSourceProtocol
    let local: LocalDataSourceProtocol
    
    //MARK: - Lifecycle
    init(remote: RemoteDataSourceProtocol, local: LocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }
}

//MARK: - Extensions
extension WeatherService: WeatherServiceProtocol {
    func fetch(completion: @escaping (Result<WeatherDTO, ApiError>) -> Void) {
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

//
//  RemoteDataSource.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherRemoteDataSourceProtocol {
    func fetch(completion: @escaping (Result<CurrentWeatherDTO, Error>) -> Void)
}

final class WeatherRemoteDataSource {
    
    //MARK: - Properties
    private let networkClient: NetworkClientProtocol
    
    //MARK: - Lifecycle
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
}

//MARK: - Extensions
extension WeatherRemoteDataSource: WeatherRemoteDataSourceProtocol {
    
    func fetch(completion: @escaping (Result<CurrentWeatherDTO, Error>) -> Void) {
        
        let urlString = WeatherRequest().urlString
        
        networkClient.fetch(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let weatherDto = try JSONDecoder().decode(CurrentWeatherDTO.self, from: data)
                    completion(.success(weatherDto))
                } catch {
                    completion(.failure(APIError.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

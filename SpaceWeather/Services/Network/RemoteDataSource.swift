//
//  RemoteDataSource.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol RemoteDataSourceProtocol {
    func fetch(completion: @escaping (Result<WeatherDTO, Error>) -> Void)
}

final class RemoteDataSource {
    
    //MARK: - Properties
    private let networkClient = NetworkClient()
    
    private var weatherUrl: URL {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg,ru&appid=fcb53881381b95a0d5ae2afc1964bdc0&units=metric") else {
            preconditionFailure("Unable to construct Url")
        }
        return url
    }
}

//MARK: - Extensions
extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func fetch(completion: @escaping (Result<WeatherDTO, Error>) -> Void) {
        networkClient.fetch(url: weatherUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let weatherDto = try JSONDecoder().decode(WeatherDTO.self, from: data)
                    completion(.success(weatherDto))
                } catch {
                    completion(.failure(ApiError.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

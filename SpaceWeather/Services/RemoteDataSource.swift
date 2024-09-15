//
//  RemoteDataSource.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol RemoteDataSourceProtocol {
    func fetch(urlString: String, completion: @escaping (Result<WeatherDTO, Error>) -> Void)
}

final class RemoteDataSource {
    
    //MARK: - Properties
    private let networkClient = NetworkClient() // создать в контейнере
    
}

//MARK: - Extensions
extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func fetch(urlString: String, completion: @escaping (Result<WeatherDTO, Error>) -> Void) {
        networkClient.fetch(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let weatherDto = try JSONDecoder().decode(WeatherDTO.self, from: data)
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

//
//  DIContainer.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

final class DIContainer {
    
    //MARK: - Properties
    private lazy var networkService: NetworkClientProtocol = NetworkClient()
    private lazy var weatherRemoteDataSource: WeatherRemoteDataSourceProtocol = WeatherRemoteDataSource(networkClient: networkService)
    private lazy var weatherLocalDataSource: WeatherLocalDataSourceProtocol = WeatherLocalDataSource()
    private(set) lazy var weatherService: WeatherServiceProtocol = WeatherService(remote: weatherRemoteDataSource, local: weatherLocalDataSource)
}

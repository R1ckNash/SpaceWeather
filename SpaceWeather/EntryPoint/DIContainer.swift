//
//  DIContainer.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

final class DIContainer {
    
    private lazy var remoteDataSource: RemoteDataSourceProtocol = RemoteDataSource()
    private lazy var localDataSource: LocalDataSourceProtocol = LocalDataSource()
    private lazy var weatherServiceInstance: WeatherServiceProtocol = WeatherService(remote: remoteDataSource, local: localDataSource)
    
    var weatherService: WeatherServiceProtocol {
            return weatherServiceInstance
        }

    
}

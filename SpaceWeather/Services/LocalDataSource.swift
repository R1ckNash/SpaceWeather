//
//  LocalDataSource.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol LocalDataSourceProtocol {
    func saveData(_ data: WeatherDTO)
    func loadData() -> WeatherDTO?
}

final class LocalDataSource {
    
    //MARK: - Properties
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    //MARK: - Lifecycle
    init() {
        if let cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            self.cacheDirectory = cacheDir
        } else {
            fatalError("Unable to locate cache directory")
        }
    }
}

//MARK: - Extensions
extension LocalDataSource: LocalDataSourceProtocol {
    
    func saveData(_ data: WeatherDTO) {
        let fileURL = cacheDirectory.appendingPathComponent("weatherData.json")
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            try jsonData.write(to: fileURL)
        } catch {
            print("Error saving data to disk: \(error)")
        }
    }
    
    func loadData() -> WeatherDTO? {
        let fileURL = cacheDirectory.appendingPathComponent("weatherData.json")
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let weatherData = try JSONDecoder().decode(WeatherDTO.self, from: jsonData)
            return weatherData
        } catch {
            return nil
        }
    }
}

//
//  WeatherLocalDataSource.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol WeatherLocalDataSourceProtocol {
    func saveData(_ data: CurrentWeatherDTO)
    func loadData() -> CurrentWeatherDTO?
}

final class WeatherLocalDataSource {
    
    //MARK: - Properties
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let queue = DispatchQueue(label: "com.weather.concurrent", attributes: .concurrent)
    
    private var fileName: String {
        return "weatherData.json"
    }
    
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
extension WeatherLocalDataSource: WeatherLocalDataSourceProtocol {
    
    func saveData(_ data: CurrentWeatherDTO) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            
            let fileURL = self.cacheDirectory.appendingPathComponent(fileName)
            
            do {
                let jsonData = try JSONEncoder().encode(data)
                try jsonData.write(to: fileURL)
            } catch {
                return
            }
        }
    }
    
    func loadData() -> CurrentWeatherDTO? {
        
        var result: CurrentWeatherDTO?
        queue.sync { [weak self] in
            guard let self else { return }
            
            let fileURL = self.cacheDirectory.appendingPathComponent(fileName)
            
            guard self.fileManager.fileExists(atPath: fileURL.path) else {
                return
            }
            
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let weatherData = try JSONDecoder().decode(CurrentWeatherDTO.self, from: jsonData)
                result = weatherData
            } catch {
                return
            }
        }
        return result
    }
    
}

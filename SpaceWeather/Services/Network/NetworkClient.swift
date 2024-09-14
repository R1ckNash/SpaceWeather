//
//  NetworkClient.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

struct NetworkClient {
    
    func fetch(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ApiError.codeError))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                decodeResponse(from: data, completion: completion)
                return
            case 500...599:
                completion(.failure(ApiError.serverIsNotResponding))
                return
            default:
                completion(.failure(ApiError.somethingWentWrong))
                return
            }
        }
        
        task.resume()
    }
    
    private func decodeResponse(from data: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(ApiError.decodingError))
        }
    }
}

//
//  NetworkClient.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

protocol NetworkClientProtocol {
    func fetch(urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkClient: NetworkClientProtocol {
    
    func fetch(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        do {
            
            let url = try makeURL(for: urlString)
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(APIError.codeError))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    decodeResponse(from: data, completion: completion)
                    return
                case 500...599:
                    completion(.failure(APIError.serverIsNotResponding))
                    return
                default:
                    completion(.failure(APIError.somethingWentWrong))
                    return
                }
            }
            task.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
    
}

extension NetworkClient {
    
    private func decodeResponse(from data: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(APIError.decodingError))
        }
    }
    
    private func makeURL(for urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else { throw APIError.invalidURL }
        return url
    }
}

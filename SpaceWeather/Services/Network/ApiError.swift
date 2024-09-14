//
//  DataError.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

enum ApiError: Error {
    case decodingError
    case codeError
    case somethingWentWrong
    case serverIsNotResponding
}

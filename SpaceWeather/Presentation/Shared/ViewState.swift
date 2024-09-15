//
//  ViewState.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation

enum ViewState<T> {
    case loading
    case error(Error)
    case content(T)
}

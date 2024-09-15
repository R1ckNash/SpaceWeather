//
//  String+Extensions.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 16/09/2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

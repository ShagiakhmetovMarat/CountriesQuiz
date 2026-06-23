//
//  String + Localized.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 30.01.2025.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

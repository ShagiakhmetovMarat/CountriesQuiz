//
//  UIKit + Extension.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 20.06.2026.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}

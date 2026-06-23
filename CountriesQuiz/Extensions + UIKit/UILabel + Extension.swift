//
//  UILabel + Extension.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 20.06.2026.
//

import UIKit

extension UILabel {
    static func label(text: String, font: String, color: UIColor, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: font, size: size)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

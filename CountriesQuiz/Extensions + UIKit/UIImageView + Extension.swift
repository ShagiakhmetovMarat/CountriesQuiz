//
//  UIImageView + Extension.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 28.06.2026.
//

import UIKit

extension UIImageView {
    static func image(image: String, color: UIColor, size: CGFloat) -> UIImageView {
        let size = UIImage.SymbolConfiguration(pointSize: size)
        let image = UIImage(systemName: image, withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}

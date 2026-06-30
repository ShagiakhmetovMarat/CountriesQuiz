//
//  UIImageView + Extension.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 28.06.2026.
//

import UIKit

extension UIImageView {
    static func image(image: String? = nil, color: UIColor, size: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: size)
        if let image = image {
            imageView.image = UIImage(systemName: image)
        }
        imageView.tintColor = color
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}

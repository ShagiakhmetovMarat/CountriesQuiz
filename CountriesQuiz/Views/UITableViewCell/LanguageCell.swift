//
//  LanguageCell.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 28.10.2024.
//

import UIKit

class LanguageCell: UITableViewCell {
    let title = UILabel()
    let additional = UILabel()
    let indicator = UIActivityIndicatorView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setSubviews()
        setConfigure()
        setConstraints()
    }
    
    private func setSubviews() {
        setSubviews(subviews: title, additional, indicator, on: contentView)
    }
    
    private func setSubviews(subviews: UIView..., on subviewOther: UIView) {
        subviews.forEach { subview in
            subviewOther.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConfigure() {
        setTitle(title: title, font: "GillSans-Semibold", size: 18)
        setTitle(title: additional, font: "GillSans", size: 17)
        setIndicator(indicator: indicator)
    }
}

extension LanguageCell {
    private func setTitle(title: UILabel, font: String, size: CGFloat) {
        title.textColor = .blueBlackSea
        title.font = UIFont(name: font, size: size)
    }
    
    private func setIndicator(indicator: UIActivityIndicatorView) {
        indicator.color = .blueBlackSea
        indicator.hidesWhenStopped = true
    }
}

extension LanguageCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            additional.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            additional.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22)
        ])
    }
}

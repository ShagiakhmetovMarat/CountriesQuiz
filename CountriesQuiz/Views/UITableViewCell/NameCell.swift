//
//  NameCell.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 22.08.2023.
//

import UIKit

class NameCell: UITableViewCell {
    let nameCountry = UILabel()
    let progressView = UIProgressView()
    let labelNumber = UILabel()
    let imageArrow = UIImageView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setSubviews()
        setConfigure()
        setConstraints()
    }
    
    private func setSubviews() {
        addSubviews(subviews: nameCountry, progressView, labelNumber,
                    imageArrow, on: contentView)
    }
    
    private func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConfigure() {
        setLabel(label: nameCountry, size: 25)
        setProgressView(progressView: progressView)
        setLabel(label: labelNumber, size: 22)
        setImageArrow(image: imageArrow)
    }
}

extension NameCell {
    private func setProgressView(progressView: UIProgressView) {
        progressView.progressTintColor = .white
        progressView.trackTintColor = .white.withAlphaComponent(0.3)
        progressView.layer.cornerRadius = progressView.frame.height / 2
        progressView.clipsToBounds = true
    }
    
    private func setLabel(label: UILabel, size: CGFloat) {
        label.font = UIFont(name: "GillSans", size: size)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    private func setImageArrow(image: UIImageView) {
        let size = UIImage.SymbolConfiguration(pointSize: 25)
        image.image = UIImage(systemName: "chevron.right", withConfiguration: size)
        image.tintColor = .white
    }
}

extension NameCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameCountry.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15),
            nameCountry.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameCountry.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45)
        ])
        
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: labelNumber.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        NSLayoutConstraint.activate([
            labelNumber.topAnchor.constraint(equalTo: nameCountry.bottomAnchor, constant: 5),
            labelNumber.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 10),
            labelNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45)
        ])
        
        NSLayoutConstraint.activate([
            imageArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}

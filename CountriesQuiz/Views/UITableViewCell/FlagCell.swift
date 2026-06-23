//
//  FlagCell.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 18.08.2023.
//

import UIKit

class FlagCell: UITableViewCell {
    let image = UIImageView()
    let progressView = UIProgressView()
    let labelNumber = UILabel()
    let imageArrow = UIImageView()
    private let radius: CGFloat = 27.5
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setSubviews()
        setConfigure()
        setConstraints()
    }
    
    private func setSubviews() {
        addSubviews(subviews: image, progressView, labelNumber, imageArrow,
                    on: contentView)
    }
    
    private func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConfigure() {
        setImage(image: image)
        setProgressView(progressView: progressView)
        setLabel(label: labelNumber)
        setImageArrow(image: imageArrow)
    }
}

extension FlagCell {
    private func setImage(image: UIImageView) {
        image.layer.borderWidth = 1
        image.layer.cornerRadius = radius
        image.clipsToBounds = true
    }
    
    private func setImageArrow(image: UIImageView) {
        let size = UIImage.SymbolConfiguration(pointSize: 25)
        image.image = UIImage(systemName: "chevron.right", withConfiguration: size)
        image.tintColor = .white
    }
    
    private func setProgressView(progressView: UIProgressView) {
        progressView.progressTintColor = .white
        progressView.trackTintColor = .white.withAlphaComponent(0.3)
        progressView.layer.cornerRadius = progressView.frame.height / 2
        progressView.clipsToBounds = true
    }
    
    private func setLabel(label: UILabel) {
        label.font = UIFont(name: "GillSans", size: 22)
        label.textColor = .white
        label.textAlignment = .center
    }
}

extension FlagCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.widthAnchor.constraint(equalToConstant: radius * 2),
            image.heightAnchor.constraint(equalToConstant: radius * 2)
        ])
        
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        NSLayoutConstraint.activate([
            labelNumber.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            labelNumber.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 10),
            labelNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45)
        ])
        
        NSLayoutConstraint.activate([
            imageArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}

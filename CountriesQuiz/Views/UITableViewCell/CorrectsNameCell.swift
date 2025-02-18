//
//  CorrectsNameCell.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 06.09.2024.
//

import UIKit

class CorrectsNameCell: UITableViewCell {
    let name = UILabel()
    let progressView = UIProgressView()
    let number = UILabel()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setSubviews()
        setConfigure()
        setConstraints()
    }
    
    private func setSubviews() {
        addSubviews(subviews: name, progressView, number, on: contentView)
    }
    
    private func addSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConfigure() {
        setLabel(label: name, size: 25)
        setProgressView(progressView: progressView)
        setLabel(label: number, size: 22)
    }
}

extension CorrectsNameCell {
    private func setLabel(label: UILabel, size: CGFloat) {
        label.font = UIFont(name: "GillSans", size: size)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    private func setProgressView(progressView: UIProgressView) {
        progressView.progressTintColor = .white
        progressView.trackTintColor = .white.withAlphaComponent(0.3)
        progressView.layer.cornerRadius = progressView.frame.height / 2
        progressView.clipsToBounds = true
    }
}

extension CorrectsNameCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: number.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        NSLayoutConstraint.activate([
            number.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            number.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 10),
            number.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}

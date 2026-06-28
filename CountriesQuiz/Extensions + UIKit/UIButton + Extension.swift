//
//  UIButton + Extension.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 27.07.2023.
//

import UIKit

class Button: UIButton {
    override var isHighlighted: Bool {
        didSet {
            guard let color = backgroundColor else { return }
            
            UIView.animate(
                withDuration: self.isHighlighted ? 0 : 0.25,
                delay: 0,
                options: [.beginFromCurrentState, .allowUserInteraction]) {
                    self.backgroundColor = color.withAlphaComponent(self.isHighlighted ? 0.4 : 1)
                }
        }
    }
}

extension Button {
    func button(image: String, color: UIColor,
                selector: Selector, isEnable: Bool? = nil) {
        let size = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: image, withConfiguration: size)
        let button = Button(type: .system)
        button.backgroundColor = color
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.layer.shadowColor = color.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = .init(width: 0, height: 4)
        button.isEnabled = isEnable ?? true
        button.addTarget(self, action: selector, for: .touchUpInside)
    }
    /*
    static func button(color: UIColor, tag: Int,
                       selector: Selector, isEnable: Bool? = nil) -> Button {
        let button = Button(type: .system)
        button.backgroundColor = color
        button.layer.cornerRadius = 20
        button.layer.shadowColor = color.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = .init(width: 0, height: 4)
        button.tag = tag
        button.isEnabled = isEnable ?? true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
     */
}

class InfoCardButton: Button {
    private let dataLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dataTitle: String, descriptionTitle: String,
                   color: UIColor, dataLabelSize: CGFloat) {
        // Text
        dataLabel.text = dataTitle
        descriptionLabel.text = descriptionTitle
        // Color
        backgroundColor = color
        layer.shadowColor = color.cgColor
        // Size
        dataLabel.font = UIFont(name: "GillSans", size: dataLabelSize)
    }
    
    private func setupUI() {
        // Button
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .init(width: 0, height: 4)
        translatesAutoresizingMaskIntoConstraints = false
        // dataLabel
        dataLabel.textColor = .white
        dataLabel.textAlignment = .center
        // descriptionLabel
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "GillSans", size: 17)
        // stackView
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubviews(dataLabel, descriptionLabel)
        
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}

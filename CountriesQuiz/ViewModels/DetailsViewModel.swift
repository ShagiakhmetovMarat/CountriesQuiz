//
//  DetailsViewModel.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 22.08.2024.
//

import UIKit

protocol DetailsViewModelProtocol {
    var background: UIColor { get }
    var flag: String { get }
    var name: String { get }
    var capital: String { get }
    var continent: String { get }
    var buttonFirst: String { get }
    var buttonSecond: String { get }
    var buttonThird: String { get }
    var buttonFour: String { get }
    var titleButton: String { get }
    var title: String { get }
    var height: CGFloat { get }
    var heightContent: CGFloat { get }
    var delegate: FavoritesViewControllerDelegate! { get set }
    var favorites: [Favorites] { get }
    
    init(mode: Setting, game: Games, favorite: Favorites, favorites: [Favorites], indexPath: IndexPath)
    
    func setBarButton(_ button: UIButton,_ navigationItem: UINavigationItem)
    func setSubviews(subviews: UIView..., on otherSubview: UIView)
    func setImage(image: String, color: UIColor, size: CGFloat) -> UIImageView
    func setView(color: UIColor, subviews: UIView...) -> UIView
    func setView() -> UIView
    func setView(_ viewFlag: UIView, and imageFlag: UIImageView) -> UIView
    func setView(addSubview: UIView) -> UIView
    func setView(addFirst: UIView, addSecond: UIView) -> UIView
    func setView(_ viewIcons: UIView, _ stackView: UIStackView, _ timeUp: UILabel) -> UIView
    func setViewNames(_ view: UIView, _ label: UILabel) -> UIView
    func setLabel(title: String, size: CGFloat, style: String, color: UIColor) -> UILabel
    func setView(_ title: String, addSubview: UIView, and tag: Int) -> UIView
    func subview(title: String, and tag: Int) -> UIView
    func stackView(_ first: UIView,_ second: UIView,_ third: UIView,_ fourth: UIView) -> UIStackView
    func deleteFavorite()
    
    func setSquare(button: UIButton, sizes: CGFloat)
    func setConstraints(_ subview: UIView, on button: UIView,_ view: UIView,_ flag: String)
}

class DetailsViewModel: DetailsViewModelProtocol {
    var background: UIColor {
        game.swap
    }
    var flag: String {
        favorite.flag
    }
    var name: String {
        favorite.name
    }
    var capital: String {
        favorite.capital
    }
    var continent: String {
        favorite.continent
    }
    var buttonFirst: String {
        favorite.buttonFirst
    }
    var buttonSecond: String {
        favorite.buttonSecond
    }
    var buttonThird: String {
        favorite.buttonThird
    }
    var buttonFour: String {
        favorite.buttonFourth
    }
    var titleButton: String {
        switch mode.language {
        case .russian: "   Удалить из избранных"
        default: "    Remove from favorites"
        }
    }
    var title: String {
        switch mode.language {
        case .russian: favorite.isTimeUp ? "Время вышло!" : ""
        default: favorite.isTimeUp ? "Time is up!" : ""
        }
    }
    var height: CGFloat {
        heightStackView + constant + (favorite.isTimeUp ? 44 : 0) + 10
    }
    var heightContent: CGFloat {
        favorite.isTimeUp ? 1.15 : 1.1
    }
    var delegate: FavoritesViewControllerDelegate!
    
    var favorites: [Favorites]
    private let mode: Setting
    private let game: Games
    private let favorite: Favorites
    private let indexPath: IndexPath
    
    var heightStackView: CGFloat {
        isFlag ? 205 : 225
    }
    private let constant: CGFloat = 58
    private var isFlag: Bool {
        favorite.isFlag
    }
    private var question: String {
        switch game.gameType {
        case .quizOfCapitals: favorite.capital
        default: isFlag ? name : flag
        }
    }
    
    required init(mode: Setting, game: Games, favorite: Favorites,
                  favorites: [Favorites], indexPath: IndexPath) {
        self.mode = mode
        self.game = game
        self.favorite = favorite
        self.favorites = favorites
        self.indexPath = indexPath
    }
    // MARK: - Subviews
    func setBarButton(_ button: UIButton, _ navigationItem: UINavigationItem) {
        let button = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = button
    }
    
    func setSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    func setImage(image: String, color: UIColor, size: CGFloat) -> UIImageView {
        let size = UIImage.SymbolConfiguration(pointSize: size)
        let image = UIImage(systemName: image, withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func setLabel(title: String, size: CGFloat, style: String, 
                  color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: style, size: size)
        label.textColor = color
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setView() -> UIView {
        let view = UIView()
        view.backgroundColor = background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setView(_ viewFlag: UIView, and imageFlag: UIImageView) -> UIView {
        let view = setView(color: game.background)
        setSubviews(subviews: viewFlag, imageFlag, on: view)
        setConstraints(viewFlag, and: imageFlag, on: view)
        return view
    }
    
    func setView(addSubview: UIView) -> UIView {
        let view = setView(color: game.favorite)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.addSubview(addSubview)
        setConstraints(subview: addSubview, on: view)
        return view
    }
    
    func setView(addFirst: UIView, addSecond: UIView) -> UIView {
        let view = setView(color: game.favorite)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setSubviews(subviews: addFirst, addSecond, on: view)
        setConstraints(addFirst, addSecond, on: view)
        return view
    }
    
    func setViewNames(_ viewIcon: UIView, _ label: UILabel) -> UIView {
        let view = setView(color: game.background)
        setSubviews(subviews: viewIcon, label, on: view)
        setConstraints(viewIcon, label, on: view)
        return view
    }
    
    func setView(_ viewIcons: UIView, _ stackView: UIStackView,
                 _ timeUp: UILabel) -> UIView {
        let view = setView(color: game.background)
        setSubviews(subviews: viewIcons, stackView, timeUp, on: view)
        setConstraints(viewIcons: viewIcons, stackView, and: timeUp, on: view)
        return view
    }
    
    func setView(_ title: String, addSubview: UIView, and tag: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor(title, tag)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = game.gameType == .questionnaire ? 1.5 : 0
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(subview: addSubview, on: view, and: title, tag: tag)
        return view
    }
    
    func setView(color: UIColor, subviews: UIView...) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        subviews.forEach { subview in
            view.addSubview(subview)
        }
        return view
    }
    
    func subview(title: String, and tag: Int) -> UIView {
        if isFlag {
            setLabel(title: title, size: 20, style: "GillSans-SemiBold", color: textColor(title, tag))
        } else {
            setSubview(title, tag)
        }
    }
    
    func stackView(_ first: UIView, _ second: UIView,
                   _ third: UIView, _ fourth: UIView) -> UIStackView {
        if isFlag {
            setStackView(first, second, third, fourth)
        } else {
            checkGameType(first, second, third, fourth)
        }
    }
    // MARK: - Delete favorite
    func deleteFavorite() {
        favorites.remove(at: indexPath.row)
        StorageManager.shared.deleteFavorite(favorite: indexPath.row, key: game.keys)
    }
    // MARK: - Constraints
    func setSquare(button: UIButton, sizes: CGFloat) {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: sizes),
            button.heightAnchor.constraint(equalToConstant: sizes)
        ])
    }
    
    func setConstraints(_ subview: UIView, on button: UIView, _ view: UIView, 
                        _ flag: String) {
        if isFlag {
            let constant: CGFloat = game.gameType == .questionnaire ? 50 : 20
            NSLayoutConstraint.activate([
                subview.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                subview.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: constant),
                subview.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -20)
            ])
        } else {
            NSLayoutConstraint.activate([
                layoutConstraint(subview: subview, on: button, view),
                subview.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                subview.widthAnchor.constraint(equalToConstant: widthImage(flag, view)),
                subview.heightAnchor.constraint(equalToConstant: setHeight())
            ])
        }
    }
}
// MARK: - Private methods, constants
extension DetailsViewModel {
    private func backgroundColor(_ button: String, _ tag: Int) -> UIColor {
        question == button ? correctBackground() : incorrectBackground(tag)
    }
    
    private func correctBackground() -> UIColor {
        game.gameType == .questionnaire ? .white : .greenYellowBrilliant
    }
    
    private func incorrectBackground(_ tag: Int) -> UIColor {
        favorite.tag == tag ? checkSelect() : checkNotSelect()
    }
    
    private func checkSelect() -> UIColor {
        switch game.gameType {
        case .quizOfFlags: .redTangerineTango
        case .questionnaire: .white
        default: .bismarkFuriozo
        }
    }
    
    private func checkNotSelect() -> UIColor {
        switch game.gameType {
        case .quizOfFlags: isFlag ? .whiteAlpha : .skyGrayLight
        case .questionnaire: .greenHarlequin
        default: .whiteAlpha
        }
    }
    
    private func textColor(_ title: String, _ tag: Int) -> UIColor {
        question == title ? correctTextColor() : incorrectTextColor(tag)
    }
    
    private func correctTextColor() -> UIColor {
        game.gameType == .questionnaire ? .greenHarlequin : .white
    }
    
    private func incorrectTextColor(_ tag: Int) -> UIColor {
        favorite.tag == tag ? checkSelectText() : checkNotSelectText()
    }
    
    private func checkSelectText() -> UIColor {
        game.gameType == .questionnaire ? .redTangerineTango : .white
    }
    
    private func checkNotSelectText() -> UIColor {
        game.gameType == .questionnaire ? .white : .grayLight
    }
    
    private func checkmark(_ name: String, _ tag: Int) -> String {
        question == name ? "checkmark.circle.fill" : incorrectCheckmark(tag)
    }
    
    private func incorrectCheckmark(_ tag: Int) -> String {
        favorite.tag == tag ? "xmark.circle.fill" : "circle"
    }
    
    private func color(_ name: String, _ tag: Int) -> UIColor {
        question == name ? .greenHarlequin : incorrectColor(tag)
    }
    
    private func incorrectColor(_ tag: Int) -> UIColor {
        favorite.tag == tag ? .redTangerineTango : .white
    }
    
    private func setWidth(_ view: UIView) -> CGFloat {
        let buttonWidth = (view.frame.width - 34) / 2
        if game.gameType == .questionnaire {
            return buttonWidth - 45
        } else {
            return buttonWidth - 10
        }
    }
    
    private func setHeight() -> CGFloat {
        let buttonHeight = (heightStackView - 4) / 2
        return buttonHeight - 10
    }
    
    private func widthImage(_ flag: String, _ view: UIView) -> CGFloat {
        switch flag {
        case "nepal", "vatican city", "switzerland": return setHeight()
        default: return setWidth(view)
        }
    }
    
    private func setCenter(_ view: UIView) -> CGFloat {
        let buttonWidth = (view.frame.width - 34) / 2
        let flagWidth = buttonWidth - 45
        let centerFlag = flagWidth / 2 + 5
        return buttonWidth / 2 - centerFlag
    }
    
    private func width(_ image: String) -> CGFloat {
        switch image {
        case "nepal", "vatican city", "switzerland": return 134
        default: return 210
        }
    }
}
// MARK: - Set subviews
extension DetailsViewModel {
    private func setSubview(_ title: String, _ tag: Int) -> UIView {
        if game.gameType == .quizOfCapitals {
            setLabel(title: title, size: 20, style: "GillSans-SemiBold", color: textColor(title, tag))
        } else {
            setImage(image: UIImage(named: title))
        }
    }
    
    private func addSubviews(subview: UIView, on view: UIView, and name: String,
                             tag: Int) {
        if game.gameType == .questionnaire {
            let checkmark = setImage(image: checkmark(name, tag),
                                     color: color(name, tag), size: 26)
            setSubviews(subviews: subview, checkmark, on: view)
            setConstraints(checkmark: checkmark, on: view)
        } else {
            setSubviews(subviews: subview, on: view)
        }
    }
    
    private func setView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func setImage(image: UIImage?) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = isFlag ? 0 : 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func setStackView(_ first: UIView, _ second: UIView,
                              _ third: UIView, _ fourth: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [first, second, third, fourth])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setStackView(_ first: UIView, _ second: UIView,
                              axis: NSLayoutConstraint.Axis? = nil) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [first, second])
        stackView.axis = axis ?? .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func checkGameType(_ first: UIView, _ second: UIView, 
                               _ third: UIView, _ fourth: UIView) -> UIStackView {
        if game.gameType == .quizOfCapitals {
            return setStackView(first, second, third, fourth)
        } else {
            let stackViewOne = setStackView(first, second)
            let stackViewTwo = setStackView(third, fourth)
            return setStackView(stackViewOne, stackViewTwo, axis: .vertical)
        }
    }
}
// MARK: - Constraints
extension DetailsViewModel {
    private func setConstraints(checkmark: UIImageView, on view: UIView) {
        let constant: CGFloat = isFlag ? 10 : 5
        NSLayoutConstraint.activate([
            checkmark.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkmark.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        ])
    }
    
    private func layoutConstraint(subview: UIView, on button: UIView,
                                  _ view: UIView) -> NSLayoutConstraint {
        if game.gameType == .questionnaire {
            let center = setCenter(view)
            return subview.centerXAnchor.constraint(equalTo: button.centerXAnchor, constant: center)
        } else {
            return subview.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        }
    }
    
    private func setConstraints(_ view: UIView, and imageFlag: UIImageView,
                                on viewDetails: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: viewDetails.topAnchor),
            view.leadingAnchor.constraint(equalTo: viewDetails.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: viewDetails.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: viewDetails.leadingAnchor, constant: constant)
        ])
        
        NSLayoutConstraint.activate([
            imageFlag.centerYAnchor.constraint(equalTo: viewDetails.centerYAnchor),
            imageFlag.centerXAnchor.constraint(equalTo: viewDetails.centerXAnchor, constant: constant / 2),
            imageFlag.widthAnchor.constraint(equalToConstant: width(flag)),
            imageFlag.heightAnchor.constraint(equalToConstant: 134)
        ])
    }
    
    private func setConstraints(subview: UIView, on view: UIView) {
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setConstraints(_ viewIcon: UIView, _ label: UILabel,
                                on viewDetails: UIView) {
        NSLayoutConstraint.activate([
            viewIcon.topAnchor.constraint(equalTo: viewDetails.topAnchor),
            viewIcon.leadingAnchor.constraint(equalTo: viewDetails.leadingAnchor),
            viewIcon.bottomAnchor.constraint(equalTo: viewDetails.bottomAnchor),
            viewIcon.trailingAnchor.constraint(equalTo: viewDetails.leadingAnchor, constant: constant)
        ])
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: viewDetails.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: viewIcon.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: viewDetails.trailingAnchor, constant: -10)
        ])
    }
    
    private func setConstraints(_ imageFirst: UIView, _ imageSecond: UIView, 
                                on view: UIView) {
        NSLayoutConstraint.activate([
            imageFirst.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -21.5),
            imageFirst.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageSecond.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 21.5),
            imageSecond.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setConstraints(viewIcons: UIView, _ stackView: UIStackView,
                                and timeUp: UILabel, on viewDetails: UIView) {
        NSLayoutConstraint.activate([
            viewIcons.topAnchor.constraint(equalTo: viewDetails.topAnchor),
            viewIcons.leadingAnchor.constraint(equalTo: viewDetails.leadingAnchor),
            viewIcons.trailingAnchor.constraint(equalTo: viewDetails.trailingAnchor),
            viewIcons.bottomAnchor.constraint(equalTo: viewDetails.topAnchor, constant: constant)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: viewDetails.topAnchor, constant: constant + 5),
            stackView.leadingAnchor.constraint(equalTo: viewDetails.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: viewDetails.trailingAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: heightStackView)
        ])
        
        NSLayoutConstraint.activate([
            timeUp.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            timeUp.centerXAnchor.constraint(equalTo: viewDetails.centerXAnchor)
        ])
    }
}

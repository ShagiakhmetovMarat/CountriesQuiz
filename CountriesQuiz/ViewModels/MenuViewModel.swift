//
//  MenuViewModel.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 06.03.2024.
//

import UIKit

protocol MenuViewModelProtocol {
    var titleQuizOfFlags: String { get }
    var titleQuestionnaire: String { get }
    var titleQuizOfMaps: String { get }
    var titleScrabble: String { get }
    var titleQuizOfCapitals: String { get }
    var mode: Setting? { get set }
    
    func setSubviews(subviews: UIView..., on subviewOther: UIView)
    func setImage(image: String, color: UIColor, size: CGFloat) -> UIImageView
    func setLabel(title: String, size: CGFloat, style: String, color: UIColor) -> UILabel
    func fetchData()
    func size(view: UIView?) -> CGSize
    func forPresented(_ button: UIButton) -> Transition
    func forDismissed(_ button: UIButton) -> Transition
    func setMode(_ setting: Setting)
    func setData(_ setting: Setting, newFavorites: [Favorites])
    func reloadTitles(_ quizOfFlags: UILabel, _ questionnaire: UILabel, _ quizOfMaps: UILabel,
                      _ scrabble: UILabel, _ quizOfCapitals: UILabel)
    
    func gameTypeViewModel(tag: Int) -> GameTypeViewModelProtocol
    func settingViewModel() -> SettingViewModelProtocol
    
    func setSquare(subview: UIView, sizes: CGFloat)
    func setCenterSubview(subview: UIView, on subviewOther: UIView)
    func setConstraintsList(button: UIButton, image: UIImageView, label: UILabel,
                            circle: UIImageView, imageGame: UIImageView,
                            layout: NSLayoutYAxisAnchor, view: UIView)
}

class MenuViewModel: MenuViewModelProtocol {
    var titleQuizOfFlags = "Quiz_of_flags.title".localized
    var titleQuestionnaire = "Questionnaire.title".localized
    var titleQuizOfMaps = "Quiz_of_maps.title".localized
    var titleScrabble = "Scrabble.title".localized
    var titleQuizOfCapitals = "Quiz_of_capitals.title".localized
    var mode: Setting?
    
    private var games: [Games] = []
    private var favorites: [Favorites] = []
    private let transition = Transition()
    
    func setSubviews(subviews: UIView..., on subviewOther: UIView) {
        subviews.forEach { subview in
            subviewOther.addSubview(subview)
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
    
    func setLabel(title: String, size: CGFloat, style: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: style, size: size)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func fetchData() {
        mode = StorageManager.shared.fetchSetting()
        games = getGames(dialect: mode?.language ?? .english)
        StorageManager.shared.loadLanguage()
    }
    
    func size(view: UIView?) -> CGSize {
        guard let view = view else { return CGSize(width: 0, height: 0) }
        return CGSize(width: view.frame.width, height: view.frame.height + 5)
    }
    
    func forPresented(_ button: UIButton) -> Transition {
        transition.transitionMode = .present
        transition.startingPoint = button.center
        return transition
    }
    
    func forDismissed(_ button: UIButton) -> Transition {
        transition.transitionMode = .dismiss
        transition.startingPoint = button.center
        return transition
    }
    
    func setMode(_ setting: Setting) {
        mode = setting
    }
    
    func setData(_ setting: Setting, newFavorites: [Favorites]) {
        mode = setting
        favorites = newFavorites
    }
    
    func reloadTitles(_ quizOfFlags: UILabel, _ questionnaire: UILabel,
                      _ quizOfMaps: UILabel, _ scrabble: UILabel, _ quizOfCapitals: UILabel) {
        quizOfFlags.text = titleQuizOfFlags
        questionnaire.text = titleQuestionnaire
        quizOfMaps.text = titleQuizOfMaps
        scrabble.text = titleScrabble
        quizOfCapitals.text = titleQuizOfCapitals
    }
    
    func gameTypeViewModel(tag: Int) -> GameTypeViewModelProtocol {
        let mode = mode ?? Setting.getSettingDefault(mode?.language ?? .english)
        let game = games[tag]
        favorites = StorageManager.shared.fetchFavorites(key: game.keys)
        return GameTypeViewModel(mode: mode, game: game, tag: tag, favorites: favorites)
    }
    
    func settingViewModel() -> SettingViewModelProtocol {
        let mode = mode ?? Setting.getSettingDefault(mode?.language ?? .english)
        return SettingViewModel(mode: mode)
    }
    
    func setSquare(subview: UIView, sizes: CGFloat) {
        NSLayoutConstraint.activate([
            subview.widthAnchor.constraint(equalToConstant: sizes),
            subview.heightAnchor.constraint(equalToConstant: sizes)
        ])
    }
    
    func setCenterSubview(subview: UIView, on subviewOther: UIView) {
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: subviewOther.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: subviewOther.centerYAnchor)
        ])
    }
    
    func setConstraintsList(button: UIButton, image: UIImageView, label: UILabel, 
                            circle: UIImageView, imageGame: UIImageView,
                            layout: NSLayoutYAxisAnchor, view: UIView) {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: layout, constant: 15),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: button.topAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            circle.topAnchor.constraint(equalTo: button.topAnchor),
            circle.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        setCenterSubview(subview: imageGame, on: circle)
    }
}

extension MenuViewModel {
    private func getGames(dialect: Dialect) -> [Games] {
        var games: [Games] = []
        
        let gameType = GameType.shared.gameType
        let images = GameType.shared.images
        let backgrounds = GameType.shared.backgrounds
        let keys = GameType.shared.keys
        let plays = GameType.shared.buttonsPlay
        let favorites = GameType.shared.buttonsFavorite
        let swaps = GameType.shared.buttonsSwap
        let dones = GameType.shared.buttonsDone
        let iterrationCount = min(images.count, backgrounds.count, plays.count,
                                  favorites.count, swaps.count)
        
        for index in 0..<iterrationCount {
            let information = Games(
                gameType: gameType[index],
                image: images[index],
                background: backgrounds[index], 
                keys: keys[index],
                play: plays[index],
                favorite: favorites[index],
                swap: swaps[index],
                done: dones[index])
            games.append(information)
        }
        
        return games
    }
}

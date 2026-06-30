//
//  MenuViewModel.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 06.03.2024.
//

import UIKit

protocol MenuViewModelProtocol {
//    var titleQuizOfFlags: String { get }
//    var titleQuestionnaire: String { get }
//    var titleQuizOfMaps: String { get }
//    var titleScrabble: String { get }
//    var titleQuizOfCapitals: String { get }
    var settings: Settings? { get set }
    var gameModes: [GameMode] { get }
    
    func fetchData()
    func getGameModes()
    func forPresented(_ button: UIButton) -> Transition
    func forDismissed(_ button: UIButton) -> Transition
    func setMode(_ newSettings: Settings)
    func setData(_ newSettings: Settings, newFavorites: [Favorites])
    
    func gameTypeViewModel(gameType: GameType) -> GameTypeViewModelProtocol
    func settingsViewModel() -> SettingsViewModelProtocol
}

class MenuViewModel: MenuViewModelProtocol {
//    var titleQuizOfFlags = "Quiz_of_flags.title".localized
//    var titleQuestionnaire = "Questionnaire.title".localized
//    var titleQuizOfMaps = "Quiz_of_maps.title".localized
//    var titleScrabble = "Scrabble.title".localized
//    var titleQuizOfCapitals = "Quiz_of_capitals.title".localized
    var settings: Settings?
    
    var gameModes: [GameMode] = []
    private var favorites: [Favorites] = []
    private let transition = Transition()
    
    func getGameModes() {
        gameModes = [
            GameMode(
                gameType: .quizOfFlags,
                color: .cyanDark,
                modeImage: "flag",
                title: "Викторина флагов",
                gameImage: "filemenu.and.selection"
            ),
            GameMode(
                gameType: .questionnaire,
                color: .greenHarlequin,
                modeImage: "checkmark.circle.badge.questionmark",
                title: "Опрос",
                gameImage: "checklist"
            ),
            GameMode(
                gameType: .quizOfMaps,
                color: .redYellowBrown,
                modeImage: "map",
                title: "Викторина карт",
                gameImage: "globe.desk"
            ),
            GameMode(
                gameType: .scrabble,
                color: .indigo,
                modeImage: "textformat.abc",
                title: "Эрудит",
                gameImage: "a.square"
            ),
            GameMode(
                gameType: .quizOfCapitals,
                color: .redTangerineTango,
                modeImage: "house.and.flag",
                title: "Викторина столиц",
                gameImage: "building.2"
            )
        ]
    }
    
    func fetchData() {
        settings = StorageManager.shared.fetchSetting()
//        games = getGames(dialect: mode?.language ?? .english)
//        StorageManager.shared.loadLanguage()
    }
    /*
    func size(view: UIView?) -> CGSize {
        guard let view = view else { return CGSize(width: 0, height: 0) }
        return CGSize(width: view.frame.width, height: view.frame.height + 5)
    }
    */
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
    
    func setMode(_ newSettings: Settings) {
        settings = newSettings
    }
    
    func setData(_ newSettings: Settings, newFavorites: [Favorites]) {
        settings = newSettings
        favorites = newFavorites
    }
    
    func gameTypeViewModel(gameType: GameType) -> GameTypeViewModelProtocol {
        let settings = settings ?? Settings.getSettingDefault(settings?.language ?? .english)
        favorites = StorageManager.shared.fetchFavorites(key: gameType.rawValue)
        return GameTypeViewModel(settings: settings, gameType: gameType, favorites: favorites)
    }
    
    func settingsViewModel() -> SettingsViewModelProtocol {
        let mode = settings ?? Settings.getSettingDefault(settings?.language ?? .english)
        return SettingsViewModel(mode: mode)
    }
    /*
    private func getGameTypes() {
        gameTypes = [
            GameType(
                mode: .quizOfFlags,
                image: "filemenu.and.selection",
                background: .cyanDark,
                keys: "quizOfFlags",
                buttonPlay: .skyBlueLight,
                buttonFavorite: .blueMiddlePersian,
                buttonSwap: .blueBlackSea,
                buttonDone: .skyCyanLight
            ),
            GameType(
                mode: .questionnaire,
                image: "checklist",
                background: .greenHarlequin,
                keys: "questionnaire",
                buttonPlay: .greenYellowBrilliant,
                buttonFavorite: .greenEmerald,
                buttonSwap: .greenDartmouth,
                buttonDone: .greenWhite
            ),
            GameType(
                mode: .quizOfMaps,
                image: "globe.desk",
                background: .redYellowBrown,
                keys: "quizOfMaps",
                buttonPlay: .redBeige,
                buttonFavorite: .brown,
                buttonSwap: .brownDeep,
                buttonDone: .somon
            ),
            GameType(
                mode: .scrabble,
                image: "a.square",
                background: .indigo,
                keys: "scrabble",
                buttonPlay: .fuchsiaCrayolaDeep,
                buttonFavorite: .amethyst,
                buttonSwap: .blueSlate,
                buttonDone: .veryLightPurple
            ),
            GameType(
                mode: .quizOfCapitals,
                image: "building.2",
                background: .redTangerineTango,
                keys: "quizOfCapitals",
                buttonPlay: .redCardinal,
                buttonFavorite: .bismarkFuriozo,
                buttonSwap: .brownRed,
                buttonDone: .salmon
            )
        ]
    }
     */
}
/*
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
*/

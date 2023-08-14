//
//  GameTypeManager.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 06.08.2023.
//

import UIKit

struct Games {
    let name: String
    let image: String
    let description: String
    let background: UIColor
    let play: UIColor
    let favourite: UIColor
    let swap: UIColor
}

extension Games {
    static func getGames() -> [Games] {
        var games: [Games] = []
        
        let names = GameType.shared.names
        let images = GameType.shared.images
        let descriptions = GameType.shared.descriptions
        let backgrounds = GameType.shared.backgrounds
        let plays = GameType.shared.buttonsPlay
        let favourites = GameType.shared.buttonsFavourite
        let swaps = GameType.shared.buttonsSwap
        let iterrationCount = min(names.count, images.count, descriptions.count,
                                  backgrounds.count, plays.count,
                                  favourites.count, swaps.count)
        
        for index in 0..<iterrationCount {
            let information = Games(
                name: names[index],
                image: images[index],
                description: descriptions[index],
                background: backgrounds[index],
                play: plays[index],
                favourite: favourites[index],
                swap: swaps[index])
            games.append(information)
        }
        
        return games
    }
}
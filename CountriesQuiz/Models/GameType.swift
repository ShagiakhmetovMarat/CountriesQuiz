//
//  GameType.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 03.08.2023.
//

import UIKit

class GameType {
    static let shared = GameType()
    
    let gameType: [TypeOfGame] = [.quizOfFlags, .questionnaire, .quizOfMaps,
                                  .scrabble, .quizOfCapitals]
    
    let images = ["filemenu.and.selection", "checklist", "globe.desk",
                  "a.square", "building.2"]
    
    let keys = ["quizOfFlags", "questionnaire", "quizOfMaps" , "scrabble", "quizOfCapitals"]
    
    let backgrounds: [UIColor] = [.cyanDark, .greenHarlequin, .redYellowBrown,
                                  .indigo, .redTangerineTango]
    
    let buttonsPlay: [UIColor] = [.skyBlueLight, .greenYellowBrilliant,
                                  .redBeige, .fuchsiaCrayolaDeep, .redCardinal]
    
    let buttonsFavorite: [UIColor] = [.blueMiddlePersian, .greenEmerald, .brown,
                                       .amethyst, .bismarkFuriozo]
    
    let buttonsSwap: [UIColor] = [.blueBlackSea, .greenDartmouth, .brownDeep,
                                  .blueSlate, .brownRed]
    
    let buttonsDone: [UIColor] = [.skyCyanLight, .greenWhite, .somon,
                                  .veryLightPurple, .salmon]
    
    private init() {}
}

enum TypeOfGame {
    case quizOfFlags
    case questionnaire
    case quizOfMaps
    case scrabble
    case quizOfCapitals
}

//
//  ViewControllerFactory.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 01.07.2026.
//

import UIKit

enum ViewControllerFactory {
    static func build(for gameType: GameType) -> UIViewController {
        switch gameType {
        case .quizOfFlags: return QuizOfFlagsViewController()
        case .questionnaire: return QuestionnaireViewController()
        case .quizOfMaps: return QuizOfFlagsViewController()
        case .scrabble: return ScrabbleViewController()
        case .quizOfCapitals: return QuizOfCapitalsViewController()
        }
    }
}

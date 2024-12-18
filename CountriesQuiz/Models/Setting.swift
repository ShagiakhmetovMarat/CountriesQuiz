//
//  Setting.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 12.12.2022.
//

import Foundation

struct Setting: Codable {
    var countQuestions: Int
    var countRows: Int
    var allCountries: Bool
    var americaContinent: Bool
    var europaContinent: Bool
    var africaContinent: Bool
    var asiaContinent: Bool
    var oceaniaContinent: Bool
    var flag: Bool
    var scrabbleType: Int
    var timeElapsed: TimeElapsed
    var language: Dialect
}

struct TimeElapsed: Codable {
    var timeElapsed: Bool
    var questionSelect: QuestionSelect
}

struct QuestionSelect: Codable {
    var oneQuestion: Bool
    var questionTime: QuestionTime
}

struct QuestionTime: Codable {
    var oneQuestionTime: Int
    var allQuestionsTime: Int
}

extension Setting {
    static func getSettingDefault(_ dialect: Dialect) -> Setting {
        let setting = Setting(
            countQuestions: DefaultSetting.countQuestions.rawValue,
            countRows: DefaultSetting.countRows.rawValue,
            allCountries: true,
            americaContinent: false,
            europaContinent: false,
            africaContinent: false,
            asiaContinent: false,
            oceaniaContinent: false,
            flag: true,
            scrabbleType: DefaultSetting.scrabbleType.rawValue,
            timeElapsed: TimeElapsed(
                timeElapsed: true,
                questionSelect: QuestionSelect(
                    oneQuestion: true,
                    questionTime: QuestionTime(
                        oneQuestionTime: DefaultSetting.oneQuestionTime.rawValue,
                        allQuestionsTime: DefaultSetting.allQuestionsTime.rawValue
                    )
                )
            ),
            language: dialect
        )
        return setting
    }
}

enum DefaultSetting: Int {
    case countQuestions = 20
    case countRows = 91
    case scrabbleType = 0
    case oneQuestionTime = 10
    case allQuestionsTime = 100
}

enum Dialect: Codable, CaseIterable {
    case russian
    case english
}

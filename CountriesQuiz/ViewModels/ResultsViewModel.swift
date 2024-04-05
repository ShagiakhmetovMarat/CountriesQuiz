//
//  ResultsViewModel.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 05.04.2024.
//

import UIKit

protocol ResultsViewModelProtocol {
    var time: Int { get }
    var radiusView: CGFloat { get }
    var titleTimeSpend: String { get }
    var imageTimeSpend: String { get }
    var numberTimeSpend: String { get }
    
    var mode: Setting { get }
    var game: Games { get }
    var correctAnswers: [Countries] { get }
    var incorrectAnswers: [Results] { get }
    var spendTime: [CGFloat] { get }
    var percentTimeSpend: String { get }
    var circleTime: Float { get }
    var timer: Timer { get set }
    
    init(mode: Setting, game: Games, correctAnswers: [Countries],
         incorrectAnswers: [Results], spendTime: [CGFloat])
    
    func isTime() -> Bool
    func isOneQuestion() -> Bool
    func oneQuestionTime() -> Int
    func allQuestionsTime() -> Int
    
    func setupSubviews(subviews: UIView..., on subviewOther: UIView)
    func opacity(subviews: UIView..., opacity: Float)
    
    func percentCorrectAnswers() -> String
    func percentIncorrectAnswers() -> String
    func percentCheckMode() -> CGFloat
    
    func showAnimate(stackView: UIStackView)
}

class ResultsViewModel: ResultsViewModelProtocol {
    var time: Int {
        isOneQuestion() ? oneQuestionTime() : allQuestionsTime()
    }
    var radiusView: CGFloat = 10
    var titleTimeSpend: String {
        isTime() ? "\(checkTitleTimeSpend())" : "Обратный отсчет выключен"
    }
    var imageTimeSpend: String {
        isTime() ? "\(checkImageTimeSpend())" : "clock.badge.xmark"
    }
    var numberTimeSpend: String {
        isTime() ? "\(checkNumberTimeSpend())" : " "
    }
    var percentTimeSpend: String {
        isTime() ? stringWithoutNull(count: percentCheckMode()) + "%" : " "
    }
    var circleTime: Float {
        roundf(Float(percentCheckMode() * 100)) / 100
    }
    var timer = Timer()
    
    let mode: Setting
    let game: Games
    let correctAnswers: [Countries]
    let incorrectAnswers: [Results]
    let spendTime: [CGFloat]
    
    required init(mode: Setting, game: Games, correctAnswers: [Countries], 
                  incorrectAnswers: [Results], spendTime: [CGFloat]) {
        self.mode = mode
        self.game = game
        self.correctAnswers = correctAnswers
        self.incorrectAnswers = incorrectAnswers
        self.spendTime = spendTime
    }
    // MARK: - Constants
    func isTime() -> Bool {
        mode.timeElapsed.timeElapsed ? true : false
    }
    
    func isOneQuestion() -> Bool {
        mode.timeElapsed.questionSelect.oneQuestion ? true : false
    }
    
    func oneQuestionTime() -> Int {
        mode.timeElapsed.questionSelect.questionTime.oneQuestionTime
    }
    
    func allQuestionsTime() -> Int {
        mode.timeElapsed.questionSelect.questionTime.allQuestionsTime
    }
    // MARK: - Set subviews
    func setupSubviews(subviews: UIView..., on subviewOther: UIView) {
        subviews.forEach { subview in
            subviewOther.addSubview(subview)
        }
    }
    
    func opacity(subviews: UIView..., opacity: Float) {
        subviews.forEach { subview in
            subview.layer.opacity = opacity
        }
    }
    // MARK: - Percent titles
    func percentCorrectAnswers() -> String {
        let correctAnswers = CGFloat(correctAnswers.count)
        let percent = correctAnswers / CGFloat(mode.countQuestions) * 100
        return stringWithoutNull(count: percent) + "%"
    }
    
    func percentIncorrectAnswers() -> String {
        let incorrectAnswers = CGFloat(incorrectAnswers.count)
        let percent = incorrectAnswers / CGFloat(mode.countQuestions) * 100
        return stringWithoutNull(count: percent) + "%"
    }
    
    func percentCheckMode() -> CGFloat {
        isOneQuestion() ? checkGameType() : timeSpend()
    }
    // MARK: - Animations
    func showAnimate(stackView: UIStackView) {
        UIView.animate(withDuration: 1) {
            self.opacity(subviews: stackView, opacity: 1)
        }
    }
    // MARK: - Constants, countinue
    private func checkTitleTimeSpend() -> String {
        isOneQuestion() ? isQuestionnaire() : titleAllQuestions()
    }
    
    private func isQuestionnaire() -> String {
        game.gameType == .questionnaire ? titleAllQuestions() : "Среднее время на вопрос"
    }
    
    private func titleAllQuestions() -> String {
        spendTime.isEmpty ? "Вы не успели ответить за это время" :
        "Потраченное время на все вопросы"
    }
    
    private func checkImageTimeSpend() -> String {
        isOneQuestion() ? "timer" : imageAllQuestions()
    }
    
    private func imageAllQuestions() -> String {
        spendTime.isEmpty ? "clock" : "timer"
    }
    
    private func checkNumberTimeSpend() -> String {
        var text: String
        if isOneQuestion() {
            let averageTime = spendTime.reduce(0.0, +) / CGFloat(spendTime.count)
            text = "\(string(seconds: averageTime))"
        } else {
            text = numberCheckAllQuestions()
        }
        return text
    }
    
    private func numberCheckAllQuestions() -> String {
        var text: String
        if spendTime.isEmpty {
            text = "-"
        } else {
            let spendTime = spendTime.first ?? 0
            text = "\(string(seconds: spendTime))"
        }
        return text
    }
    // MARK: - Number format
    private func string(seconds: CGFloat) -> String {
        String(format: "%.2f", seconds)
    }
    
    private func stringWithoutNull(count: CGFloat) -> String {
        String(format: "%.0f", count)
    }
    // MARK: - Percent titles, countinue
    private func checkGameType() -> CGFloat {
        game.gameType == .questionnaire ? questionnaireTime() : averageTime()
    }
    
    private func questionnaireTime() -> CGFloat {
        var seconds: CGFloat
        if spendTime.isEmpty {
            seconds = 0
        } else {
            let time = allQuestionsTime()
            let timeSpent = spendTime.first ?? 0
            seconds = timeSpent / CGFloat(time) * 100
        }
        return seconds
    }
    
    private func averageTime() -> CGFloat {
        let averageTime = spendTime.reduce(0.0, +) / CGFloat(spendTime.count)
        return averageTime / CGFloat(time) * 100
    }
    
    private func timeSpend() -> CGFloat {
        var seconds: CGFloat
        if spendTime.isEmpty {
            seconds = 0
        } else {
            let timeSpent = spendTime.first ?? 0
            seconds = timeSpent / CGFloat(time) * 100
        }
        return seconds
    }
}

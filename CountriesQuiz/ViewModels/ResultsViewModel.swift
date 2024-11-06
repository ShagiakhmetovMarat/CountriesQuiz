//
//  ResultsViewModel.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 05.04.2024.
//

import UIKit

protocol ResultsViewModelProtocol {
    var titleResults: String { get }
    var titleMoreDetailed: String { get }
    var titleCorrectAnswers: String { get }
    var titleIncorrectAnswers: String { get }
    var titleAnsweredQuestions: String { get }
    var titleComplete: String { get }
    var radius: CGFloat { get }
    var titleTimeSpend: String { get }
    var imageTimeSpend: String { get }
    var numberTimeSpend: String { get }
    var rightAnswersCount: Int { get }
    var wrongAnswersCount: Int { get }
    var answeredQuestions: Int { get }
    var description: String { get }
    var height: CGFloat { get }
    var favorites: [Favorites] { get }
    
    var mode: Setting { get }
    var game: Games { get }
    var correctAnswers: [Corrects] { get }
    var incorrectAnswers: [Incorrects] { get }
    
    init(mode: Setting, game: Games, correctAnswers: [Corrects],
         incorrectAnswers: [Incorrects], timeSpend: [CGFloat],
         answeredQuestions: Int, favorites: [Favorites])
    
    func isTime() -> Bool
    func isOneQuestion() -> Bool
    func oneQuestionTime() -> Int
    func allQuestionsTime() -> Int
    func width(_ view: UIView) -> CGFloat
    
    func setSubviews(subviews: UIView..., on subviewOther: UIView)
    func setLabel(title: String, font: String, size: CGFloat, color: UIColor, alignment: NSTextAlignment) -> UILabel
    func setImage(image: String, size: CGFloat, color: UIColor) -> UIImageView
    func setImage(image: String, size: CGFloat, color: UIColor, addView: UIView) -> UIImageView
    func setStackView(_ first: UIView, _ second: UIView, and distribution: UIStackView.Distribution) -> UIStackView
    func setStackView(_ first: UIView, _ second: UIView, _ third: UIView, _ fourth: UIView) -> UIStackView
    
    func percentCorrectAnswers() -> String
    func attributedText(text: String) -> NSMutableAttributedString
    func setFavorites(newFavorites: [Favorites])
    
    func constraintsView(view: UIView, image: UIImageView, label: UILabel, button: UIButton)
    func constraintsButton(subview: UIView, labelFirst: UILabel, image: UIImageView,
                           labelSecond: UILabel)
    func setupCenterSubview(_ subview: UIView, on subviewOther: UIView)
    
    func ratio() -> RatioViewModelProtocol
    func correctAnswersViewController() -> CorrectAnswersViewModelProtocol
    func incorrectAnswersViewController() -> IncorrectAnswersViewModelProtocol
}

class ResultsViewModel: ResultsViewModelProtocol {
    var titleResults: String {
        switch mode.language {
        case .russian: "Результаты"
        default: "Results"
        }
    }
    var titleMoreDetailed: String {
        switch mode.language {
        case .russian: "Подробнее..."
        default: "More detailed..."
        }
    }
    var titleCorrectAnswers: String {
        switch mode.language {
        case .russian: "Правильные ответы"
        default: "Correct answers"
        }
    }
    var titleIncorrectAnswers: String {
        switch mode.language {
        case .russian: "Неправильные ответы"
        default: "Incorrect answers"
        }
    }
    var titleAnsweredQuestions: String {
        switch mode.language {
        case .russian: "Количество отвеченных вопросов"
        default: "Number of answered questions"
        }
    }
    var titleComplete: String {
        switch mode.language {
        case .russian: "Завершить"
        default: "Complete"
        }
    }
    var radius: CGFloat = 15
    var titleTimeSpend: String {
        isTime() ? "\(checkTitleTimeSpend())" : titleCountdownOff
    }
    var imageTimeSpend: String {
        isTime() ? "\(checkImageTimeSpend())" : "clock.badge.xmark"
    }
    var numberTimeSpend: String {
        isTime() ? "\(checkNumberTimeSpend())" : " "
    }
    var rightAnswersCount: Int {
        correctAnswers.count
    }
    var wrongAnswersCount: Int {
        incorrectAnswers.count
    }
    var description: String {
        "\(titleDescription) \(percentCorrectAnswers())."
    }
    var height: CGFloat {
        mode.language == .russian ? 150 : 125
    }
    
    let mode: Setting
    let game: Games
    let correctAnswers: [Corrects]
    let incorrectAnswers: [Incorrects]
    var answeredQuestions: Int
    var favorites: [Favorites]
    private let timeSpend: [CGFloat]
    
    private var titleDescription: String {
        switch mode.language {
        case .russian:
        """
        Соотношение ответов
        На все вопросы вы смогли ответить правильно точно на
        """
        default:
        """
        Answers ratio
        You were able to answer all the questions exactly
        """
        }
    }
    private var heading: String {
        switch mode.language {
        case .russian: "Соотношение ответов"
        default: "Answers ratio"
        }
    }
    private var titleCountdownOff: String {
        switch mode.language {
        case .russian: "Обратный отсчет выключен"
        default: "Countdown off"
        }
    }
    private var titleAverageTime: String {
        switch mode.language {
        case .russian: "Среднее время на вопрос"
        default: "Average time on question"
        }
    }
    private var titleTimeUp: String {
        switch mode.language {
        case .russian: "Вы не успели ответить за это время"
        default: "You didn't have time to respond"
        }
    }
    private var titleTimeSpent: String {
        switch mode.language {
        case .russian: "Потраченное время на вопросы"
        default: "Time spent on questions"
        }
    }
    private var percent: String {
        percentCorrectAnswers()
    }
    
    required init(mode: Setting, game: Games, correctAnswers: [Corrects],
                  incorrectAnswers: [Incorrects], timeSpend: [CGFloat],
                  answeredQuestions: Int, favorites: [Favorites]) {
        self.mode = mode
        self.game = game
        self.correctAnswers = correctAnswers
        self.incorrectAnswers = incorrectAnswers
        self.timeSpend = timeSpend
        self.answeredQuestions = answeredQuestions
        self.favorites = favorites
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
    
    func width(_ view: UIView) -> CGFloat {
        view.frame.width / 2 + 10
    }
    
    func percentCorrectAnswers() -> String {
        let percent = CGFloat(rightAnswersCount) / CGFloat(mode.countQuestions) * 100
        return stringWithoutNull(count: percent) + "%"
    }
    
    func attributedText(text: String) -> NSMutableAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        let keyFont = NSAttributedString.Key.font
        let keyColor = NSAttributedString.Key.foregroundColor
        let font = UIFont(name: "GillSans-SemiBold", size: 22)
        let color = game.favorite
        let rangeHeading = getRange(subString: heading, fromString: text)
        let rangePercent = getRange(subString: percent, fromString: text)
        attributed.addAttribute(keyFont, value: font ?? "", range: rangeHeading)
        attributed.addAttribute(keyColor, value: color, range: rangePercent)
        return attributed
    }
    // MARK: - Set subviews
    func setSubviews(subviews: UIView..., on subviewOther: UIView) {
        subviews.forEach { subview in
            subviewOther.addSubview(subview)
        }
    }
    
    func setLabel(title: String, font: String, size: CGFloat, color: UIColor,
                  alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: font, size: size)
        label.textColor = color
        label.numberOfLines = 0
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setImage(image: String, size: CGFloat, color: UIColor) -> UIImageView {
        let size = UIImage.SymbolConfiguration(pointSize: size)
        let image = UIImage(systemName: image, withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func setImage(image: String, size: CGFloat, color: UIColor,
                  addView: UIView) -> UIImageView {
        let size = UIImage.SymbolConfiguration(pointSize: size)
        let image = UIImage(systemName: image, withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        setSubviews(subviews: addView, on: imageView)
        return imageView
    }
    
    func setStackView(_ first: UIView, _ second: UIView, and
                      distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [first, second])
        stackView.spacing = 10
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func setStackView(_ first: UIView, _ second: UIView, _ third: UIView,
                      _ fourth: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [first, second, third, fourth])
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    // MARK: - Transition to RatioViewController
    func ratio() -> RatioViewModelProtocol {
        RatioViewModel(mode: mode, game: game, correctAnswers: correctAnswers,
                       incorrectAnswers: incorrectAnswers, timeSpend: timeSpend, 
                       answeredQuestions: answeredQuestions)
    }
    // MARK: - Transition to CorrectAnswersViewController
    func correctAnswersViewController() -> CorrectAnswersViewModelProtocol {
        CorrectAnswersViewModel(mode: mode, game: game, correctAnswers: correctAnswers)
    }
    // MARK: - Transition to IncorrectAnswersViewController
    func incorrectAnswersViewController() -> IncorrectAnswersViewModelProtocol {
        IncorrectAnswersViewModel(mode: mode, game: game, results: incorrectAnswers,
                                  favourites: favorites)
    }
    // MARK: - Constraints
    func constraintsView(view: UIView, image: UIImageView, label: UILabel, button: UIButton) {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 95),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: -5),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 95)
        ])
    }
    
    func constraintsButton(subview: UIView, labelFirst: UILabel, image: UIImageView,
                           labelSecond: UILabel) {
        NSLayoutConstraint.activate([
            labelFirst.topAnchor.constraint(equalTo: subview.topAnchor, constant: 10),
            labelFirst.leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: 5),
            labelFirst.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: -51)
        ])
        
        NSLayoutConstraint.activate([
            image.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: -20),
            image.centerYAnchor.constraint(equalTo: labelFirst.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelSecond.leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: 10),
            labelSecond.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: -10),
            labelSecond.bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: -10)
        ])
    }
    
    func setupCenterSubview(_ subview: UIView, on subviewOther: UIView) {
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: subviewOther.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: subviewOther.centerYAnchor)
        ])
    }
    
    func setFavorites(newFavorites: [Favorites]) {
        favorites = newFavorites
    }
    
    // MARK: - Constants, countinue
    private func checkTitleTimeSpend() -> String {
        isOneQuestion() ? isQuestionnaire() : titleAllQuestions()
    }
    
    private func isQuestionnaire() -> String {
        game.gameType == .questionnaire ? titleAllQuestions() : titleAverageTime
    }
    
    private func titleAllQuestions() -> String {
        timeSpend.isEmpty ? titleTimeUp : titleTimeSpent
    }
    
    private func checkImageTimeSpend() -> String {
        isOneQuestion() ? "timer" : imageAllQuestions()
    }
    
    private func imageAllQuestions() -> String {
        timeSpend.isEmpty ? "clock" : "timer"
    }
    
    private func checkNumberTimeSpend() -> String {
        var text: String
        if isOneQuestion() {
            let averageTime = timeSpend.reduce(0.0, +) / CGFloat(timeSpend.count)
            text = "\(string(seconds: averageTime))"
        } else {
            text = numberCheckAllQuestions()
        }
        return text
    }
    
    private func numberCheckAllQuestions() -> String {
        var text: String
        if timeSpend.isEmpty {
            text = "0"
        } else {
            let spendTime = timeSpend.first ?? 0
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
    
    private func getRange(subString: String, fromString: String) -> NSRange {
        let linkRange = fromString.range(of: subString)!
        let start = fromString.distance(from: fromString.startIndex, to: linkRange.lowerBound)
        let end = fromString.distance(from: fromString.startIndex, to: linkRange.upperBound)
        let range = NSMakeRange(start, end - start)
        return range
    }
}

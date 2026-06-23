//
//  ResultsViewController.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 25.01.2023.
//

import UIKit

protocol ResultsViewControllerDelegate {
    func dataToResults(favourites: [Favorites])
}

class ResultsViewController: UIViewController, ResultsViewControllerDelegate {
    private lazy var imageColor: UIImageView = {
        viewModel.setImage(image: "circle.fill", size: 60, color: viewModel.game.background, addView: imageCircle)
    }()
    
    private lazy var imageCircle: UIImageView = {
        viewModel.setImage(image: "circle.fill", size: 60, color: .whiteAlphaLight, addView: imageGameType)
    }()
    
    private lazy var imageGameType: UIImageView = {
        viewModel.setImage(image: viewModel.game.image, size: 36, color: viewModel.game.background)
    }()
    
    private lazy var labelResults: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleResults,
            font: "echorevival",
            size: 38,
            color: viewModel.game.swap,
            alignment: .natural)
    }()
    
    private lazy var stackViewResults: UIStackView = {
        viewModel.setStackView(labelResults, imageColor, and: .fill)
    }()
    
    private lazy var imageCheckmark: UIImageView = {
        viewModel.setImage(image: "checkmark", size: 21, color: viewModel.game.swap)
    }()
    
    private lazy var imageMultiply: UIImageView = {
        viewModel.setImage(image: "multiply", size: 21, color: viewModel.game.swap)
    }()
    
    private lazy var imageClock: UIImageView = {
        viewModel.setImage(image: viewModel.imageTimeSpend, size: 21, color: viewModel.game.swap)
    }()
    
    private lazy var imageQuestionmark: UIImageView = {
        viewModel.setImage(image: "questionmark.bubble", size: 21, color: viewModel.game.swap)
    }()
    
    private lazy var stackViewImages: UIStackView = {
        viewModel.setStackView(imageCheckmark, imageMultiply, imageClock, imageQuestionmark)
    }()
    
    private lazy var viewDescription: UIView = {
        let view = UIView()
        view.backgroundColor = .skyGrayLight.withAlphaComponent(0.6)
        view.layer.cornerRadius = 22
        view.translatesAutoresizingMaskIntoConstraints = false
        viewModel.setSubviews(subviews: imageDescription, labelDescription, buttonDescription, on: view)
        return view
    }()
    
    private lazy var imageDescription: UIImageView = {
        viewModel.setImage(image: "seal.fill", size: 70, color: viewModel.game.background, addView: labelPercent)
    }()
    
    private lazy var labelPercent: UILabel = {
        viewModel.setLabel(
            title: viewModel.percentCorrectAnswers(),
            font: "Gill Sans",
            size: 28,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var labelDescription: UILabel = {
        let text = viewModel.description
        let label = viewModel.setLabel(title: text, font: "GillSans", size: 21, color: .black, alignment: .natural)
        let attributed = viewModel.attributedText(text: text)
        label.attributedText = attributed
        return label
    }()
    
    private lazy var buttonDescription: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.titleMoreDetailed, for: .normal)
        button.setTitleColor(viewModel.game.background, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-SemiBold", size: 21)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showRatio), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonCorrectAnswers: UIButton = {
        setButton(
            color: viewModel.rightAnswersCount > 0 ? .greenEmerald : .grayStone,
            action: #selector(showCorrectAnswers),
            labelFirst: labelCorrectCount,
            image: imageCorrectAnswers,
            labelSecond: labelCorrectTitle,
            tag: 1,
            isEnabled: viewModel.rightAnswersCount > 0 ? true : false)
    }()
    
    private lazy var labelCorrectCount: UILabel = {
        viewModel.setLabel(
            title: "\(viewModel.rightAnswersCount)",
            font: "GillSans",
            size: 33,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var imageCorrectAnswers: UIImageView = {
        viewModel.setImage(image: "checkmark", size: 26, color: .white)
    }()
    
    private lazy var labelCorrectTitle: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleCorrectAnswers,
            font: "GillSans",
            size: 18,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var buttonIncorrectAnswers: UIButton = {
        setButton(
            color: viewModel.wrongAnswersCount > 0 ? .bismarkFuriozo : .grayStone,
            action: #selector(showIncorrectAnswers),
            labelFirst: labelIncorrectCount,
            image: imageIncorrectAnswers,
            labelSecond: labelIncorrectTitle,
            tag: 2,
            isEnabled: viewModel.wrongAnswersCount > 0 ? true : false)
    }()
    
    private lazy var labelIncorrectCount: UILabel = {
        viewModel.setLabel(
            title: "\(viewModel.wrongAnswersCount)",
            font: "GillSans",
            size: 33,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var imageIncorrectAnswers: UIImageView = {
        viewModel.setImage(image: "multiply", size: 26, color: .white)
    }()
    
    private lazy var labelIncorrectTitle: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleIncorrectAnswers,
            font: "GillSans",
            size: 18,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var stackViewAnswers: UIStackView = {
        viewModel.setStackView(buttonCorrectAnswers, buttonIncorrectAnswers, and: .fillEqually)
    }()
    
    private lazy var buttonTimeSpend: UIButton = {
        setButton(
            color: .blueMiddlePersian,
            action: #selector(showIncorrectAnswers),
            labelFirst: labelNumberTimeSpend,
            image: imageTimeSpend,
            labelSecond: labelTimeSpend,
            tag: 3)
    }()
    
    private lazy var labelNumberTimeSpend: UILabel = {
        viewModel.setLabel(
            title: viewModel.numberTimeSpend,
            font: "GillSans",
            size: 33,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var imageTimeSpend: UIImageView = {
        viewModel.setImage(image: viewModel.imageTimeSpend, size: 26, color: .white)
    }()
    
    private lazy var labelTimeSpend: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleTimeSpend,
            font: "GillSans",
            size: 18,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var imageInfinity: UIImageView = {
        viewModel.setImage(image: "infinity", size: 35, color: .white)
    }()
    
    private lazy var buttonAnsweredQuestions: UIButton = {
        setButton(
            color: .gummigut,
            action: #selector(showIncorrectAnswers),
            labelFirst: labelAnsweredQuestions,
            image: imageAnsweredQuestions,
            labelSecond: labelAnsweredTitle,
            tag: 4)
    }()
    
    private lazy var labelAnsweredQuestions: UILabel = {
        viewModel.setLabel(
            title: "\(viewModel.answeredQuestions)",
            font: "GillSans",
            size: 33,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var imageAnsweredQuestions: UIImageView = {
        viewModel.setImage(image: "questionmark.bubble", size: 26, color: .white)
    }()
    
    private lazy var labelAnsweredTitle: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleAnsweredQuestions,
            font: "GillSans",
            size: 18,
            color: .white,
            alignment: .center)
    }()
    
    private lazy var stackViewTime: UIStackView = {
        viewModel.setStackView(buttonTimeSpend, buttonAnsweredQuestions, and: .fillEqually)
    }()
    
    private lazy var buttonComplete: UIButton = {
        let button = Button(type: .system)
        button.setTitle(viewModel.titleComplete, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-SemiBold", size: 25)
        button.backgroundColor = viewModel.game.background
        button.layer.cornerRadius = 12
        button.layer.shadowColor = viewModel.game.background.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 0, height: 4.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitToMenu), for: .touchUpInside)
        return button
    }()
    
    var viewModel: ResultsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupSubviews()
        setConstraints()
    }
    
    func dataToResults(favourites: [Favorites]) {
        viewModel.setFavorites(newFavorites: favourites)
    }
    
    private func setupDesign() {
        view.backgroundColor = UIColor.white
        navigationItem.hidesBackButton = true
        imageInfinity.isHidden = viewModel.isTime() ? true : false
    }
    
    private func setupSubviews() {
        viewModel.setSubviews(subviews: stackViewResults, stackViewImages,
                                viewDescription, stackViewAnswers, stackViewTime,
                                imageInfinity, buttonComplete, on: view)
    }
    // MARK: - Press complete button
    @objc private func exitToMenu() {
        viewModel.delegate.dataToMenu(setting: viewModel.mode, favorites: viewModel.favorites)
    }
    // MARK: - Show ratio
    @objc private func showRatio() {
        let ratio = viewModel.ratio()
        let ratioVC = RatioViewController()
        let navigationVC = UINavigationController(rootViewController: ratioVC)
        ratioVC.viewModel = ratio
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true)
    }
    // MARK: - Show correct answers
    @objc private func showCorrectAnswers() {
        let correctAnswers = viewModel.correctAnswersViewController()
        let correctAnswersVC = CorrectAnswersViewController()
        let navigationVC = UINavigationController(rootViewController: correctAnswersVC)
        correctAnswersVC.viewModel = correctAnswers
        navigationVC.modalPresentationStyle = .custom
        present(navigationVC, animated: true)
    }
    // MARK: - Show incorrect answers
    @objc private func showIncorrectAnswers() {
        let incorrectAnswers = viewModel.incorrectAnswersViewController()
        let incorrectAnswersVC = IncorrectAnswersViewController()
        let navigationVC = UINavigationController(rootViewController: incorrectAnswersVC)
        incorrectAnswersVC.viewModel = incorrectAnswers
        incorrectAnswersVC.viewModel.delegate = self
        navigationVC.modalPresentationStyle = .custom
        present(navigationVC, animated: true)
    }
}
// MARK: - Setup subviews
extension ResultsViewController {
    private func setButton(color: UIColor, action: Selector, labelFirst: UILabel,
                           image: UIImageView, labelSecond: UILabel, tag: Int,
                           isEnabled: Bool? = nil) -> UIButton {
        let button = Button(type: .custom)
        button.backgroundColor = color
        button.layer.cornerRadius = 22
        button.layer.shadowColor = color.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 0, height: 4.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = tag
        button.isEnabled = isEnabled ?? true
        button.addTarget(self, action: action, for: .touchUpInside)
        viewModel.setSubviews(subviews: labelFirst, image, labelSecond, on: button)
        return button
    }
}
// MARK: - Setup constraints
extension ResultsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewResults.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            stackViewResults.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewResults.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        viewModel.setupCenterSubview(imageCircle, on: imageColor)
        viewModel.setupCenterSubview(imageGameType, on: imageCircle)
        
        NSLayoutConstraint.activate([
            stackViewImages.topAnchor.constraint(equalTo: stackViewResults.bottomAnchor, constant: -15),
            stackViewImages.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            viewDescription.topAnchor.constraint(equalTo: stackViewImages.bottomAnchor, constant: 20),
            viewDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewDescription.heightAnchor.constraint(equalToConstant: viewModel.height)
        ])
        viewModel.setupCenterSubview(labelPercent, on: imageDescription)
        viewModel.constraintsView(view: viewDescription, image: imageDescription,
                                  label: labelDescription, button: buttonDescription)
        
        NSLayoutConstraint.activate([
            stackViewAnswers.topAnchor.constraint(equalTo: viewDescription.bottomAnchor, constant: 10),
            stackViewAnswers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewAnswers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewAnswers.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackViewTime.topAnchor.constraint(equalTo: stackViewAnswers.bottomAnchor, constant: 10),
            stackViewTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewTime.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        viewModel.constraintsButton(subview: buttonCorrectAnswers, labelFirst: labelCorrectCount,
                                    image: imageCorrectAnswers, labelSecond: labelCorrectTitle)
        viewModel.constraintsButton(subview: buttonIncorrectAnswers, labelFirst: labelIncorrectCount,
                                    image: imageIncorrectAnswers, labelSecond: labelIncorrectTitle)
        viewModel.constraintsButton(subview: buttonTimeSpend, labelFirst: labelNumberTimeSpend,
                                    image: imageTimeSpend, labelSecond: labelTimeSpend)
        viewModel.constraintsButton(subview: buttonAnsweredQuestions, labelFirst: labelAnsweredQuestions,
                                    image: imageAnsweredQuestions, labelSecond: labelAnsweredTitle)
        
        viewModel.setupCenterSubview(imageInfinity, on: labelNumberTimeSpend)
        
        NSLayoutConstraint.activate([
            buttonComplete.topAnchor.constraint(equalTo: stackViewTime.bottomAnchor, constant: 25),
            buttonComplete.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonComplete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonComplete.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

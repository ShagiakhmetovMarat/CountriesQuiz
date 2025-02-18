//
//  MenuViewController.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 01.12.2022.
//

import UIKit

protocol MenuViewControllerInput: AnyObject {
    func dataToMenu(setting: Setting, favorites: [Favorites])
    func modeToMenu(setting: Setting)
}

class MenuViewController: UIViewController {
    private lazy var labelMenu: UILabel = {
        viewModel.setLabel(title: "Countries Quiz", size: 40, style: "echorevival", color: .blueBlackSea)
    }()
    
    private lazy var buttonSettings: UIButton = {
        setButton(color: .blueMiddlePersian, image: imageSettings, action: #selector(setting))
    }()
    
    private lazy var imageSettings: UIImageView = {
        viewModel.setImage(image: "gear", color: .white, size: 26)
    }()
    
    private lazy var stackViewMenu: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelMenu, buttonSettings])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = viewModel.size(view: view)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = viewModel.size(view: view)
        return scrollView
    }()
    
    private lazy var buttonQuizOfFlags: UIButton = {
        setButton(
            color: .cyanDark,
            image: imageFlag,
            label: labelQuizOfFlags,
            circle: circleQuizOfFlag,
            imageGame: imageQuizOfFlags,
            action: #selector(gameType))
    }()
    
    private lazy var imageFlag: UIImageView = {
        viewModel.setImage(image: "flag", color: .white, size: 20)
    }()
    
    private lazy var labelQuizOfFlags: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleQuizOfFlags,
            size: 26,
            style: "GillSans",
            color: .white)
    }()
    
    private lazy var circleQuizOfFlag: UIImageView = {
        viewModel.setImage(image: "circle.fill", color: .white.withAlphaComponent(0.8), size: 100)
    }()
    
    private lazy var imageQuizOfFlags: UIImageView = {
        viewModel.setImage(image: "filemenu.and.selection", color: .cyanDark, size: 60)
    }()
    
    private lazy var buttonQuestionnaire: UIButton = {
        setButton(
            color: .greenHarlequin,
            image: imageCheckmark,
            label: labelQuestionnaire,
            circle: circleQuestionnare,
            imageGame: imageQuestionnaire,
            tag: 1,
            action: #selector(gameType))
    }()
    
    private lazy var imageCheckmark: UIImageView = {
        viewModel.setImage(image: "checkmark.circle.badge.questionmark", color: .white, size: 20)
    }()
    
    private lazy var labelQuestionnaire: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleQuestionnaire,
            size: 26,
            style: "GillSans",
            color: .white)
    }()
    
    private lazy var circleQuestionnare: UIImageView = {
        viewModel.setImage(image: "circle.fill", color: .white.withAlphaComponent(0.8), size: 100)
    }()
    
    private lazy var imageQuestionnaire: UIImageView = {
        viewModel.setImage(image: "checklist", color: .greenHarlequin, size: 60)
    }()
    
    private lazy var buttonQuizOfMaps: UIButton = {
        setButton(
            color: .redYellowBrown,
            image: imageMap,
            label: labelQuizOfMaps,
            circle: circleQuizOfMaps,
            imageGame: imageQuizOfMaps,
            tag: 2,
            action: #selector(gameType))
    }()
    
    private lazy var imageMap: UIImageView = {
        viewModel.setImage(image: "map", color: .white, size: 20)
    }()
    
    private lazy var labelQuizOfMaps: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleQuizOfMaps,
            size: 26,
            style: "GillSans",
            color: .white)
    }()
    
    private lazy var circleQuizOfMaps: UIImageView = {
        viewModel.setImage(image: "circle.fill", color: .white.withAlphaComponent(0.8), size: 100)
    }()
    
    private lazy var imageQuizOfMaps: UIImageView = {
        viewModel.setImage(image: "globe.desk", color: .redYellowBrown, size: 60)
    }()
    
    private lazy var buttonScrabble: UIButton = {
        setButton(
            color: .indigo,
            image: imageText,
            label: labelScrabble,
            circle: circleScrabble,
            imageGame: imageScrabble,
            tag: 3,
            action: #selector(gameType))
    }()
    
    private lazy var imageText: UIImageView = {
        viewModel.setImage(image: "textformat.abc", color: .white, size: 20)
    }()
    
    private lazy var labelScrabble: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleScrabble,
            size: 26,
            style: "GillSans",
            color: .white)
    }()
    
    private lazy var circleScrabble: UIImageView = {
        viewModel.setImage(image: "circle.fill", color: .white.withAlphaComponent(0.8), size: 100)
    }()
    
    private lazy var imageScrabble: UIImageView = {
        viewModel.setImage(image: "a.square", color: .indigo, size: 60)
    }()
    
    private lazy var buttonQuizOfCapitals: UIButton = {
        setButton(
            color: .redTangerineTango,
            image: imageHouse,
            label: labelQuizOfCapitals,
            circle: circleQuizOfCapitals,
            imageGame: imageQuizOfCapitals,
            tag: 4,
            action: #selector(gameType))
    }()
    
    private lazy var imageHouse: UIImageView = {
        viewModel.setImage(image: "house.and.flag", color: .white, size: 20)
    }()
    
    private lazy var labelQuizOfCapitals: UILabel = {
        viewModel.setLabel(
            title: viewModel.titleQuizOfCapitals,
            size: 26,
            style: "GillSans",
            color: .white)
    }()
    
    private lazy var circleQuizOfCapitals: UIImageView = {
        viewModel.setImage(image: "circle.fill", color: .white.withAlphaComponent(0.8), size: 100)
    }()
    
    private lazy var imageQuizOfCapitals: UIImageView = {
        viewModel.setImage(image: "building.2", color: .redTangerineTango, size: 60)
    }()
    
    private var viewModel: MenuViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupSubviews()
        setupSubviewOnContentView()
        setupSubviewsOnScrollView()
        setConstraints()
    }
}
// MARK: - Delegates for send data
extension MenuViewController: MenuViewControllerInput {
    func dataToMenu(setting: Setting, favorites: [Favorites]) {
        navigationController?.popToRootViewController(animated: true)
        viewModel.setData(setting, newFavorites: favorites)
    }
    
    func modeToMenu(setting: Setting) {
        viewModel.setMode(setting)
        viewModel.reloadTitles(labelQuizOfFlags, labelQuestionnaire, labelQuizOfMaps,
                               labelScrabble, labelQuizOfCapitals)
    }
}
// MARK: - UIViewControllerTransitioningDelegate
extension MenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        viewModel.forPresented(buttonQuizOfFlags)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        viewModel.forDismissed(buttonQuizOfFlags)
    }
}
// MARK: - General methods
extension MenuViewController {
    private func setupDesign() {
        view.backgroundColor = .white
        viewModel = MenuViewModel()
        viewModel.fetchData()
    }
    
    private func setupSubviews() {
        viewModel.setSubviews(subviews: stackViewMenu, contentView, on: view)
    }
    
    private func setupSubviewOnContentView() {
        viewModel.setSubviews(subviews: scrollView, on: contentView)
    }
    
    private func setupSubviewsOnScrollView() {
        viewModel.setSubviews(subviews: buttonQuizOfFlags, buttonQuestionnaire,
                              buttonQuizOfMaps, buttonScrabble, buttonQuizOfCapitals,
                              on: scrollView)
    }
    // MARK: - Button activate. Press game type, setting
    @objc private func gameType(sender: UIButton) {
        let tag = sender.tag
        let gameTypeViewModel = viewModel.gameTypeViewModel(tag: tag)
        let gameTypeVC = GameTypeViewController()
        gameTypeVC.viewModel = gameTypeViewModel
        gameTypeVC.viewModel.delegate = self
        navigationController?.pushViewController(gameTypeVC, animated: true)
    }
    
    @objc private func setting() {
        let settingViewModel = viewModel.settingViewModel()
        let settingVC = SettingViewController()
        let navigationVC = UINavigationController(rootViewController: settingVC)
        settingVC.viewModel = settingViewModel
        settingVC.viewModel.delegate = self
        navigationVC.transitioningDelegate = self
        navigationVC.modalPresentationStyle = .custom
        present(navigationVC, animated: true)
    }
}
// MARK: - Setup subviews
extension MenuViewController {
    private func setButton(color: UIColor, image: UIView, label: UILabel? = nil,
                           circle: UIView? = nil, imageGame: UIView? = nil,
                           tag: Int? = nil, action: Selector) -> UIButton {
        let button = Button(type: .custom)
        button.backgroundColor = color
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.4
        button.layer.shadowColor = color.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 6)
        button.tag = tag ?? 0
        button.translatesAutoresizingMaskIntoConstraints = false
        if let label = label, let circle = circle, let imageGame = imageGame {
            viewModel.setSubviews(subviews: image, label, circle, imageGame, on: button)
        } else {
            viewModel.setSubviews(subviews: image, on: button)
        }
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}
// MARK: - Set constraints
extension MenuViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackViewMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        viewModel.setSquare(subview: buttonSettings, sizes: 40)
        viewModel.setCenterSubview(subview: imageSettings, on: buttonSettings)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: stackViewMenu.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewModel.setConstraintsList(button: buttonQuizOfFlags, image: imageFlag,
                                     label: labelQuizOfFlags, circle: circleQuizOfFlag,
                                     imageGame: imageQuizOfFlags,
                                     layout: scrollView.topAnchor, view: view)
        viewModel.setConstraintsList(button: buttonQuestionnaire, image: imageCheckmark,
                                     label: labelQuestionnaire, circle: circleQuestionnare,
                                     imageGame: imageQuestionnaire,
                                     layout: buttonQuizOfFlags.bottomAnchor, view: view)
        viewModel.setConstraintsList(button: buttonQuizOfMaps, image: imageMap,
                                     label: labelQuizOfMaps, circle: circleQuizOfMaps,
                                     imageGame: imageQuizOfMaps,
                                     layout: buttonQuestionnaire.bottomAnchor, view: view)
        viewModel.setConstraintsList(button: buttonScrabble, image: imageText,
                                     label: labelScrabble, circle: circleScrabble,
                                     imageGame: imageScrabble,
                                     layout: buttonQuizOfMaps.bottomAnchor, view: view)
        viewModel.setConstraintsList(button: buttonQuizOfCapitals, image: imageHouse,
                                     label: labelQuizOfCapitals, circle: circleQuizOfCapitals,
                                     imageGame: imageQuizOfCapitals,
                                     layout: buttonScrabble.bottomAnchor, view: view)
    }
}

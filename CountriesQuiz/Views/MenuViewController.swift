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
    private var viewModel: MenuViewModelProtocol
    
    private let menuLabel = UILabel.label(
        text: "Countries Quiz",
        font: "echorevival",
        color: .blueBlackSea,
        size: 40
    )
    
    private let settingsButton: UIButton = {
        let button = Button(type: .system)
        button.backgroundColor = .blueMiddlePersian
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.4
        button.layer.shadowColor = UIColor.blueMiddlePersian.cgColor
        button.layer.shadowOffset = .init(width: 0, height: 6)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingsImage: UIImageView = {
        let size = UIImage.SymbolConfiguration(pointSize: 26)
        let image = UIImage(systemName: "gear", withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let modesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(viewModel: MenuViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupUI()
        setupSubviews()
        setupButtonsModes()
        setupConstraints()
    }
    
    private func setupAppearance() {
        view.backgroundColor = .systemBackground
        viewModel.fetchData()
        viewModel.getGameModes()
    }
    
    private func setupUI() {
        view.addSubviews(menuStackView, scrollView)
        menuStackView.addArrangedSubviews(menuLabel, settingsButton)
        scrollView.addSubview(contentView)
        contentView.addSubview(modesStackView)
    }
    
    private func setupSubviews() {
        settingsButton.addSubview(settingsImage)
        settingsButton.addTarget(self, action: #selector(navigateToSettings), for: .touchUpInside)
    }
    
    private func setupButtonsModes() {
        for (index, mode) in viewModel.gameModes.enumerated() {
            let button = setupModeButton(mode: mode, tag: index)
            modesStackView.addArrangedSubview(button)
        }
    }
    
    private func setupModeButton(mode: GameMode, tag: Int) -> UIButton {
        let modeImage = setupImage(image: mode.modeImage, color: .white, size: 20)
        let circleImage = setupImage(image: "circle.fill", color: .white.withAlphaComponent(0.8), size: 100)
        let gameImage = setupImage(image: mode.gameImage, color: mode.color, size: 60)
        let modeLabel = setupModeLabel(mode: mode)
        let button = Button(type: .custom)
        button.backgroundColor = mode.color
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.4
        button.layer.shadowColor = mode.color.cgColor
        button.layer.shadowOffset = .init(width: 0, height: 6)
        button.tag = tag
        button.addTarget(self, action: #selector(navigateToGameType), for: .touchUpInside)
        button.addSubviews(modeImage, circleImage, gameImage, modeLabel)
        setupConstraints(button: button, modeImage: modeImage, modeLabel: modeLabel,
                         circleImage: circleImage, gameImage: gameImage)
        return button
    }
    
    private func setupImage(image: String, color: UIColor, size: CGFloat) -> UIImageView {
        let size = UIImage.SymbolConfiguration(pointSize: size)
        let image = UIImage(systemName: image, withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func setupModeLabel(mode: GameMode) -> UILabel {
        let label = UILabel()
        label.text = mode.title
        label.font = UIFont(name: "GillSans", size: 26)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
//        viewModel.reloadTitles(labelQuizOfFlags, labelQuestionnaire, labelQuizOfMaps,
//                               labelScrabble, labelQuizOfCapitals)
    }
}
/*
// MARK: - UIViewControllerTransitioningDelegate
extension MenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        viewModel.forPresented(buttonQuizOfFlags)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        viewModel.forDismissed(buttonQuizOfFlags)
    }
}
 */
// MARK: - Navigate to other view controllers
extension MenuViewController {
    @objc private func navigateToGameType(sender: UIButton) {
        let tag = sender.tag
        let gameTypeViewModel = viewModel.gameTypeViewModel(tag: tag)
        let gameTypeVC = GameTypeViewController()
        gameTypeVC.viewModel = gameTypeViewModel
        gameTypeVC.viewModel.delegate = self
        navigationController?.pushViewController(gameTypeVC, animated: true)
    }
    
    @objc private func navigateToSettings() {
        let settingsViewModel = viewModel.settingsViewModel()
        let settingsVC = SettingsViewController()
        let navigationVC = UINavigationController(rootViewController: settingsVC)
        settingsVC.viewModel = settingsViewModel
        settingsVC.viewModel.delegate = self
//        navigationVC.transitioningDelegate = self
        navigationVC.modalPresentationStyle = .custom
        present(navigationVC, animated: true)
    }
}
// MARK: - Set constraints
extension MenuViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            menuStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            menuStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            settingsImage.centerXAnchor.constraint(equalTo: settingsButton.centerXAnchor),
            settingsImage.centerYAnchor.constraint(equalTo: settingsButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: menuStackView.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            modesStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            modesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            modesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            modesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupConstraints(button: UIButton, modeImage: UIImageView,
                                  modeLabel: UILabel, circleImage: UIImageView, gameImage: UIImageView) {
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            modeImage.topAnchor.constraint(equalTo: button.topAnchor, constant: 20),
            modeImage.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            modeLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20),
            modeLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            circleImage.topAnchor.constraint(equalTo: button.topAnchor),
            circleImage.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gameImage.centerXAnchor.constraint(equalTo: circleImage.centerXAnchor),
            gameImage.centerYAnchor.constraint(equalTo: circleImage.centerYAnchor)
        ])
    }
}

//
//  GameTypeViewController.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 03.08.2023.
//

import UIKit

protocol GameTypeViewControllerInput: AnyObject {
    func dataToMenu(setting: Settings, favorites: [Favorites])
    func favoritesToGameType(favorites: [Favorites])
    func disableFavoriteButton()
}

class GameTypeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, GameTypeViewControllerInput {
    var viewModel: GameTypeViewModelProtocol!
    
    private let gameTypeView = UIView()
    private var gameTypeImage = UIImageView()
    private var gameTypeLabel = UILabel()
    private lazy var backButton = makeBarButton(
        image: "multiply",
        selector: #selector(backToMenu)
    )
    private lazy var helpButton = makeBarButton(
        image: "questionmark",
        selector: #selector(showViewHelp)
    )
    private lazy var helpView: UIView = {
        setView(action: #selector(closeView), view: viewModel.viewHelp())
    }()
    private let visualEffectView = UIVisualEffectView()
    private let playButton = Button()
    private let favoritesButton = Button()
    private let swapButton = Button()
    private let menuStackView = UIStackView()
    private var countQuestionsButton = InfoCardButton()
    private var continentsButton = InfoCardButton()
    private var countdownButton = InfoCardButton()
    private var timeButton = InfoCardButton()
    private var imageInfinity = UIImageView()
    
    private lazy var pickerViewQuestions: UIPickerView = {
        setPickerView(tag: 1)
    }()
    
    private lazy var buttonAllCountries: UIButton = {
        setButton(
            backgroundIsOn: !viewModel.allCountries,
            colorIsOn: viewModel.allCountries)
    }()
    
    private lazy var buttonAmericaContinent: UIButton = {
        setButton(
            backgroundIsOn: !viewModel.americaContinent,
            colorIsOn: viewModel.americaContinent,
            tag: 1)
    }()
    
    private lazy var buttonEuropeContinent: UIButton = {
        setButton(
            backgroundIsOn: !viewModel.europeContinent,
            colorIsOn: viewModel.europeContinent,
            tag: 2)
    }()
    
    private lazy var buttonAfricaContinent: UIButton = {
        setButton(
            backgroundIsOn: !viewModel.africaContinent,
            colorIsOn: viewModel.africaContinent,
            tag: 3)
    }()
    
    private lazy var buttonAsiaContinent: UIButton = {
        setButton(
            backgroundIsOn: !viewModel.asiaContinent,
            colorIsOn: viewModel.asiaContinent,
            tag: 4)
    }()
    
    private lazy var buttonOceanContinent: UIButton = {
        setButton(
            backgroundIsOn: !viewModel.oceaniaContinent,
            colorIsOn: viewModel.oceaniaContinent,
            tag: 5)
    }()
    
    private lazy var stackViewContinents: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [buttonAllCountries, buttonAmericaContinent,
                               buttonEuropeContinent, buttonAfricaContinent,
                               buttonAsiaContinent, buttonOceanContinent])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.tag = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewModel.setStackView(stackView: stackView)
        return stackView
    }()
    
    private lazy var buttonCheckmark: UIButton = {
        let checkmark = viewModel.isCheckmark(isOn: viewModel.isCountdown())
        let size = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: checkmark, withConfiguration: size)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = viewModel.background
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(countdown), for: .touchUpInside)
        viewModel.setSquare(subviews: button, sizes: 50)
        viewModel.setButtonCheckmark(button: button)
        return button
    }()
    
    private lazy var viewCheckmark: UIView = {
        setView(color: .white, radius: 13, addButton: buttonCheckmark, sizes: 60)
    }()
    
    private lazy var labelCheckmark: UILabel = {
        setLabel(
            color: .white,
            title: viewModel.titleOnOff,
            size: 26,
            style: "GillSans",
            alignment: .center)
    }()
    
    private lazy var stackViewCheckmark: UIStackView = {
        setStackView(view: viewCheckmark, label: labelCheckmark)
    }()
    
    private lazy var pickerViewOneTime: UIPickerView = {
        setPickerView(tag: 2)
    }()
    
    private lazy var pickerViewAllTime: UIPickerView = {
        setPickerView(tag: 3)
    }()
    
    private lazy var stackViewPickerViews: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pickerViewOneTime, pickerViewAllTime])
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: viewModel.titleItems)
        let font = UIFont(name: "GillSans", size: 22)
        segment.backgroundColor = .white
        segment.selectedSegmentTintColor = viewModel.background
        segment.setTitleTextAttributes([NSAttributedString.Key
            .font: font ?? "", .foregroundColor: UIColor.white
        ], for: .selected)
        segment.setTitleTextAttributes([NSAttributedString.Key
            .font: font ?? "", .foregroundColor: viewModel.background
        ], for: .normal)
        segment.layer.borderWidth = 5
        segment.layer.borderColor = UIColor.white.cgColor
        segment.addTarget(self, action: #selector(segmentSelect), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        viewModel.setHeightSegment(segment: segment)
        viewModel.setSegmentedControl(segment: segment)
        return segment
    }()
    
    private lazy var stackViewTime: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, stackViewPickerViews])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.tag = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewModel.setStackView(stackView: stackView)
        return stackView
    }()
    
    private lazy var buttonDone: UIButton = {
        setButton(title: viewModel.titleOk, color: viewModel.colorDoneButton, action: #selector(done))
    }()
    
    private lazy var buttonCancel: UIButton = {
        setButton(title: viewModel.titleCancel, color: .white, action: #selector(closeViewSetting))
    }()
    
    private lazy var stackView: UIStackView = {
        setStackView(buttonFirst: buttonDone, buttonSecond: buttonCancel, spacing: 15)
    }()
    
    private lazy var viewSetting: UIView = {
        let view = setView(action: #selector(closeViewSetting), view: viewModel.viewSetting())
        viewModel.setSubviews(subviews: stackView, on: view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearence()
        setupSubviews()
        setupBarButtons()
        setupGameTypeView()
        setupGameTypeImage()
        setupGameTypeLabel()
        setupVisualEffectView()
        setupMenuButtons()
        setupStackView()
        setupConstraints()
    }
    // MARK: - UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.numberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfRows(pickerView)
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        viewModel.titles(pickerView, row, and: segmentedControl)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        viewModel.heightOfRows
    }
    // MARK: - Press button count questions / continents / countdown / time
    @objc func showSetting(sender: UIButton) {
//        viewModel.setSubviews(subviews: viewSetting, on: view)
//        viewModel.setSubviewsTag(subviews: buttonDone, viewSetting, tag: sender.tag)
//        viewModel.setSubview(subview(tag: sender.tag), on: viewSetting, and: view)
//        viewModel.setConstraints(stackView: stackView)
//        viewModel.setDataSubviews(tag: sender.tag)
//        viewModel.barButtonsOnOff(buttonBack, buttonHelp, bool: false)
//        viewModel.showViewSetting(viewSetting, and: visualEffectView, view)
    }
    
    @objc func closeViewSetting() {
//        viewModel.barButtonsOnOff(buttonBack, buttonHelp, bool: true)
//        viewModel.hideViewSetting(viewSetting, and: visualEffectView, view)
    }
    // MARK: - Button press continents, change setting continents
    @objc func continents(sender: UIButton) {
        guard sender.tag > 0 else { return viewModel.setAllCountries(sender) }
        viewModel.setCountContinents(sender.backgroundColor == .white ? -1 : 1)
        guard viewModel.countContinents > 4 else { return viewModel.condition(sender) }
        viewModel.setAllCountries(buttonAllCountries)
    }
    // MARK: - Button press checkmark, change setting countdown
    @objc func countdown() {
        viewModel.checkmarkOnOff(buttonCheckmark)
    }
    // MARK: - Press done button for change setting
    @objc func done(sender: UIButton) {
        switch sender.tag {
        case 1: viewModel.setQuestions(labelCountQuestion, and: labelTime)
        case 2: viewModel.setContinents(labelContinents, labelCountQuestion, and: pickerViewQuestions)
        case 3: viewModel.setCountdown(labelCountdown, imageInfinity, labelTime, and: buttonTime)
        default: viewModel.setTime(labelTime, and: labelTimeDesription)
        }
        closeViewSetting()
    }
    // MARK: - GameTypeViewControllerInput
    func dataToMenu(setting: Settings, favorites: [Favorites]) {
        viewModel.delegate.dataToMenu(setting: setting, favorites: favorites)
    }
    
    func favoritesToGameType(favorites: [Favorites]) {
        viewModel.setFavorites(newFavorites: favorites)
    }
    
    func disableFavoriteButton() {
        viewModel.buttonOnOff(button: favoritesButton, isOn: false)
    }
}
// MARK: - Setup UI
extension GameTypeViewController {
    private func setupAppearence() {
        view.backgroundColor = viewModel.background
        imageInfinity.isHidden = viewModel.isCountdown()
    }
    
    private func setupSubviews() {
        view.addSubviews(gameTypeView, gameTypeImage, gameTypeLabel, menuStackView,
                         countQuestionsButton, continentsButton, countdownButton, timeButton,
                         visualEffectView, imageInfinity)
    }
    
    private func makeBarButton(image: String, selector: Selector) -> UIBarButtonItem {
        let size = UIImage.SymbolConfiguration(pointSize: 26)
        let image = UIImage(systemName: image, withConfiguration: size)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    private func setupBarButtons() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = helpButton
    }
    
    private func setupGameTypeView() {
        gameTypeView.backgroundColor = viewModel.background
        gameTypeView.layer.cornerRadius = viewModel.radius
        gameTypeView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupGameTypeImage() {
        gameTypeImage = UIImageView.image(
            image: viewModel.image,
            color: viewModel.background,
            size: 60
        )
    }
    
    private func setupGameTypeLabel() {
        gameTypeLabel = UILabel.label(
            text: viewModel.name,
            font: "GillSans",
            color: .white,
            size: 30
        )
    }
    
    private func setupVisualEffectView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(popUpViewCheck))
        visualEffectView.effect = UIBlurEffect(style: .dark)
        visualEffectView.alpha = 0
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.addGestureRecognizer(tap)
    }
    
    private func setupMenuButtons() {
        playButton.button(
            image: "play",
            color: viewModel.colorPlayButton,
            selector: #selector(startGame)
        )
        favoritesButton.button(
            image: "star",
            color: viewModel.colorFavouriteButton,
            selector: #selector(favorites),
            isEnable: viewModel.haveFavourites()
        )
        swapButton.button(
            image: viewModel.imageMode(),
            color: viewModel.colorSwapButton,
            selector: #selector(swap),
            isEnable: viewModel.isEnabled()
        )
    }
    
    private func setupStackView() {
        menuStackView.addArrangedSubviews(playButton, favoritesButton, swapButton)
        menuStackView.spacing = 20
        menuStackView.distribution = .fillEqually
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSettingsButton() {
        countQuestionsButton = configureButton(
            dataTitle: "\(viewModel.countQuestions)",
            descriptionTitle: "Количество вопросов",
            color: viewModel.colorSwapButton,
            dataLabelSize: 60,
            tag: 1
        )
        countQuestionsButton = configureButton(
            dataTitle: "\(viewModel.comma())",
            descriptionTitle: "Континенты",
            color: viewModel.colorSwapButton,
            dataLabelSize: 30,
            tag: 2
        )
        countdownButton = configureButton(
            dataTitle: viewModel.isCountdown() ? "Да" : "Нет",
            descriptionTitle: "Обратный отсчет",
            color: viewModel.colorSwapButton,
            dataLabelSize: 60,
            tag: 3
        )
        timeButton = configureButton(
            dataTitle: "\(viewModel.countdownOnOff())",
            descriptionTitle: "\(viewModel.checkTimeDescription())",
            color: viewModel.colorSwapButton,
            dataLabelSize: 60,
            tag: 4,
            isEnable: viewModel.isCountdown()
        )
    }
    
    private func configureButton(dataTitle: String, descriptionTitle: String,
                                 color: UIColor, dataLabelSize: CGFloat,
                                 tag: Int, isEnable: Bool? = nil) -> InfoCardButton {
        let button = InfoCardButton()
        button.configure(
            dataTitle: dataTitle,
            descriptionTitle: descriptionTitle,
            color: color,
            dataLabelSize: dataLabelSize
        )
        button.tag = tag
        button.isEnabled = isEnable ?? true
        button.addTarget(self, action: #selector(showSetting), for: .touchUpInside)
        return button
    }
    
    private func setupInfinityImage() {
        imageInfinity = UIImageView.image(
            image: "infinity",
            color: .white,
            size: 60
        )
    }
    
    private func subview(tag: Int) -> UIView {
        switch tag {
        case 1: pickerViewQuestions
        case 2: stackViewContinents
        case 3: stackViewCheckmark
        default: stackViewTime
        }
    }
    // MARK: - Bar buttons activate
    @objc private func backToMenu() {
        viewModel.delegate.dataToMenu(setting: viewModel.settings, favorites: viewModel.favorites)
    }
    
    @objc private func showViewHelp(sender: UIButton) {
//        viewModel.popUpViewHelpToggle()
//        viewModel.setSubviews(subviews: viewHelp, on: view)
//        viewModel.setConstraints(viewHelp, view)
//        viewModel.barButtonsOnOff(buttonBack, buttonHelp, bool: false)
//        viewModel.showAnimationView(viewHelp, and: visualEffectView)
    }
    
    @objc private func closeView() {
//        viewModel.popUpViewHelpToggle()
//        viewModel.barButtonsOnOff(buttonBack, buttonHelp, bool: true)
//        viewModel.hideAnimationView(viewHelp, and: visualEffectView)
    }
    
    @objc private func popUpViewCheck() {
//        viewModel.popUpViewHelp ? closeView() : closeViewSetting()
    }
    // MARK: - Start game, favorites and swap
    @objc private func startGame() {
        switch viewModel.tag {
        case 0: quizOfFlagsViewController()
        case 1: questionnaireViewController()
        case 3: scrabbleViewController()
        default: quizOfCapitalsViewController()
        }
    }
    
    private func quizOfFlagsViewController() {
        let quizOfFlagsViewModel = viewModel.quizOfFlagsViewModel()
        let quizOfFlagsVC = QuizOfFlagsViewController()
        quizOfFlagsVC.viewModel = quizOfFlagsViewModel
        quizOfFlagsVC.viewModel.delegate = self
        navigationController?.pushViewController(quizOfFlagsVC, animated: true)
    }
    
    private func questionnaireViewController() {
        let questionnaireViewModel = viewModel.questionnaireViewModel()
        let questionnaireVC = QuestionnaireViewController()
        questionnaireVC.viewModel = questionnaireViewModel
        questionnaireVC.viewModel.delegate = self
        navigationController?.pushViewController(questionnaireVC, animated: true)
    }
    
    private func scrabbleViewController() {
        print("Scrabble view controller will be create.")
        /*
        let startGameVC = ScrabbleViewController()
        startGameVC.mode = viewModel.setting
        startGameVC.game = viewModel.games
        navigationController?.pushViewController(startGameVC, animated: true)
         */
    }
    
    private func quizOfCapitalsViewController() {
        let quizOfCapitalsViewModel = viewModel.quizOfCapitalsViewModel()
        let startGameVC = QuizOfCapitalsViewController()
        startGameVC.viewModel = quizOfCapitalsViewModel
        startGameVC.viewModel.delegate = self
        navigationController?.pushViewController(startGameVC, animated: true)
    }
    
    @objc private func favorites() {
        let favorites = viewModel.favouritesViewModel()
        let favoritesVC = FavoritesViewController()
        let navigationVC = UINavigationController(rootViewController: favoritesVC)
        favoritesVC.viewModel = favorites
        favoritesVC.viewModel.delegate = self
        navigationVC.modalPresentationStyle = .custom
        present(navigationVC, animated: true)
    }
    
    @objc private func swap() {
        viewModel.swap(swapButton)
    }
    // MARK: - Segmented control press, change setting time for one question or for all questions
    @objc private func segmentSelect() {
        viewModel.segmentSelect()
    }
}
// MARK: - Setup constraints
extension GameTypeViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameTypeView.widthAnchor.constraint(equalToConstant: viewModel.diameter),
            gameTypeView.heightAnchor.constraint(equalToConstant: viewModel.diameter)
        ])
        
//        viewModel.setSquare(subviews: buttonBack, buttonHelp, sizes: 40)
        
        NSLayoutConstraint.activate([
            gameTypeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            gameTypeView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gameTypeImage.centerXAnchor.constraint(equalTo: gameTypeView.centerXAnchor),
            gameTypeImage.centerYAnchor.constraint(equalTo: gameTypeView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gameTypeLabel.topAnchor.constraint(equalTo: gameTypeView.bottomAnchor, constant: 10),
            gameTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            menuStackView.topAnchor.constraint(equalTo: gameTypeLabel.bottomAnchor, constant: 15),
            menuStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            menuStackView.widthAnchor.constraint(equalToConstant: 160),
            menuStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        setupConstraints(
            countQuestionsButton,
            layout: menuStackView.bottomAnchor,
            leading: 20,
            trailing: -(view.frame.width / 2 + 10),
            height: 160
        )
        setupConstraints(
            continentsButton,
            layout: menuStackView.bottomAnchor,
            leading: view.frame.width / 2 + 10,
            trailing: -20,
            height: 190
        )
        setupConstraints(
            countdownButton,
            layout: countQuestionsButton.bottomAnchor,
            leading: 20,
            trailing: -(view.frame.width / 2 + 10),
            height: 150
        )
        setupConstraints(
            timeButton,
            layout: continentsButton.bottomAnchor,
            leading: view.frame.width / 2 + 10,
            trailing: -20,
            height: 120
        )
        
        NSLayoutConstraint.activate([
            imageInfinity.centerXAnchor.constraint(equalTo: timeButton.centerXAnchor),
            imageInfinity.centerYAnchor.constraint(equalTo: timeButton.centerYAnchor, constant: -25)
        ])
//        viewModel.setConstraints(labelCountQuestion, on: buttonCountQuestions, constant: -30)
//        viewModel.setConstraints(labelCount, on: buttonCountQuestions, constant: 35)

//        viewModel.setConstraints(labelContinents, on: continentsButton, constant: -15)
//        viewModel.setConstraints(labelContinentsDescription, on: continentsButton, constant: 75)

//        viewModel.setConstraints(labelCountdown, on: countdownButton, constant: -25)
//        viewModel.setConstraints(labelCountdownDesription, on: countdownButton, constant: 35)

//        viewModel.setConstraints(labelTime, on: timeButton, constant: -25)
//        viewModel.setConstraints(labelTimeDesription, on: timeButton, constant: 30)
    }
    
    func setupConstraints(_ button: UIButton, layout: NSLayoutYAxisAnchor,
                          leading: CGFloat, trailing: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: layout, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing),
            button.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

//
//  GameTypeViewController.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 03.08.2023.
//

import UIKit

protocol GameTypeViewControllerInput: AnyObject {
    func dataToMenu(setting: Setting, favourites: [Favorites])
    func favoritesToGameType(favorites: [Favorites])
    func disableFavoriteButton()
}

class GameTypeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, GameTypeViewControllerInput {
    private lazy var viewGameType: UIView = {
        setView(color: .white.withAlphaComponent(0.8), radius: viewModel.diameter / 2)
    }()
    
    private lazy var imageGameType: UIImageView = {
        setImage(image: "\(viewModel.image)", color: viewModel.background, size: 60)
    }()
    
    private lazy var labelGameName: UILabel = {
        setLabel(color: .white, title: "\(viewModel.name)", size: 30, style: "Gill Sans")
    }()
    
    private lazy var buttonBack: UIButton = {
        setButton(image: "multiply", action: #selector(backToMenu), isBarButton: true)
    }()
    
    private lazy var buttonHelp: UIButton = {
        setButton(image: "questionmark", action: #selector(showViewHelp), isBarButton: true)
    }()
    
    private lazy var viewHelp: UIView = {
        setView(action: #selector(closeView), view: viewModel.viewHelp())
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(popUpViewCheck))
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var buttonStart: UIButton = {
        setButton(image: "play", color: viewModel.colorPlay, action: #selector(startGame))
    }()
    
    private lazy var buttonFavorites: UIButton = {
        setButton(
            image: "star",
            color: viewModel.colorFavourite,
            action: #selector(favorites),
            isEnabled: viewModel.haveFavourites())
    }()
    
    private lazy var buttonSwap: UIButton = {
        setButton(
            image: viewModel.imageMode(),
            color: viewModel.colorSwap,
            action: #selector(swap),
            isEnabled: viewModel.isEnabled())
    }()
    
    private lazy var stackViewButtons: UIStackView = {
        setStackView(
            buttonFirst: buttonStart,
            buttonSecond: buttonFavorites,
            buttonThird: buttonSwap)
    }()
    
    private lazy var buttonCountQuestions: UIButton = {
        setButton(
            color: viewModel.colorSwap,
            labelFirst: labelCountQuestion,
            labelSecond: labelCount,
            tag: 1)
    }()
    
    private lazy var labelCountQuestion: UILabel = {
        setLabel(color: .white, title: "\(viewModel.countQuestions)", size: 60, style: "Gill Sans")
    }()
    
    private lazy var labelCount: UILabel = {
        setLabel(color: .white, title: "Количество вопросов", size: 17, style: "Gill Sans")
    }()
    
    private lazy var buttonContinents: UIButton = {
        setButton(
            color: viewModel.colorSwap,
            labelFirst: labelContinents,
            labelSecond: labelContinentsDescription,
            tag: 2)
    }()
    
    private lazy var labelContinents: UILabel = {
        setLabel(color: .white, title: "\(viewModel.comma())", size: 30, style: "Gill Sans")
    }()
    
    private lazy var labelContinentsDescription: UILabel = {
        setLabel(color: .white, title: "Континенты", size: 17, style: "Gill Sans")
    }()
    
    private lazy var buttonCountdown: UIButton = {
        setButton(
            color: viewModel.colorSwap,
            labelFirst: labelCountdown,
            labelSecond: labelCountdownDesription,
            tag: 3)
    }()
    
    private lazy var labelCountdown: UILabel = {
        setLabel(
            color: .white,
            title: viewModel.isCountdown() ? "Да" : "Нет",
            size: 60,
            style: "Gill Sans")
    }()
    
    private lazy var labelCountdownDesription: UILabel = {
        setLabel(
            color: .white,
            title: "Обратный отсчёт",
            size: 17,
            style: "Gill Sans")
    }()
    
    private lazy var buttonTime: UIButton = {
        setButton(
            color: viewModel.isCountdown() ? viewModel.colorSwap : .grayLight,
            labelFirst: labelTime,
            labelSecond: labelTimeDesription,
            image: imageInfinity,
            tag: 4,
            isEnabled: viewModel.isCountdown())
    }()
    
    private lazy var labelTime: UILabel = {
        setLabel(
            color: .white,
            title: "\(viewModel.countdownOnOff())",
            size: 60,
            style: "Gill Sans")
    }()
    
    private lazy var labelTimeDesription: UILabel = {
        setLabel(
            color: .white,
            title: "\(viewModel.checkTimeDescription())",
            size: 17,
            style: "Gill Sans")
    }()
    
    private lazy var imageInfinity: UIImageView = {
        setImage(image: "infinity", color: .white, size: 60)
    }()
    
    private lazy var labelSetting: UILabel = {
        setLabel(color: .white, title: "", size: 22, style: "Gill Sans")
    }()
    
    private lazy var viewSecondary: UIView = {
        let view = setView(color: viewModel.background)
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private lazy var pickerViewQuestions: UIPickerView = {
        setPickerView(tag: 1)
    }()
    
    private lazy var labelAllCountries: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.allCountries),
            title: "Все страны мира",
            size: 26,
            style: "mr_fontick")
    }()
    
    private lazy var labelCountAllCountries: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.allCountries),
            title: "Количество стран: \(viewModel.countAllCountries)",
            size: 20,
            style: "mr_fontick")
    }()
    
    private lazy var buttonAllCountries: UIButton = {
        setButton(
            color: viewModel.isSelect(isOn: !viewModel.allCountries),
            labelName: labelAllCountries,
            labelCount: labelCountAllCountries)
    }()
    
    private lazy var labelAmericaContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.americaContinent),
            title: "Континент Америки",
            size: 26,
            style: "mr_fontick")
    }()
    
    private lazy var labelCountAmericaContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.americaContinent),
            title: "Количество стран: \(viewModel.countCountriesOfAmerica)",
            size: 20,
            style: "mr_fontick")
    }()
    
    private lazy var buttonAmericaContinent: UIButton = {
        setButton(
            color: viewModel.isSelect(isOn: !viewModel.americaContinent),
            labelName: labelAmericaContinent,
            labelCount: labelCountAmericaContinent,
            tag: 1)
    }()
    
    private lazy var labelEuropeContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.europeContinent),
            title: "Континент Европы",
            size: 26,
            style: "mr_fontick")
    }()
    
    private lazy var labelCountEuropeContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.europeContinent),
            title: "Количество стран: \(viewModel.countCountriesOfEurope)",
            size: 20,
            style: "mr_fontick")
    }()
    
    private lazy var buttonEuropeContinent: UIButton = {
        setButton(
            color: viewModel.isSelect(isOn: !viewModel.europeContinent),
            labelName: labelEuropeContinent,
            labelCount: labelCountEuropeContinent,
            tag: 2)
    }()
    
    private lazy var labelAfricaContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.africaContinent),
            title: "Континент Африки",
            size: 26,
            style: "mr_fontick")
    }()
    
    private lazy var labelCountAfricaContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.africaContinent),
            title: "Количество стран: \(viewModel.countCountriesOfAfrica)",
            size: 20,
            style: "mr_fontick")
    }()
    
    private lazy var buttonAfricaContinent: UIButton = {
        setButton(
            color: viewModel.isSelect(isOn: !viewModel.africaContinent),
            labelName: labelAfricaContinent,
            labelCount: labelCountAfricaContinent,
            tag: 3)
    }()
    
    private lazy var labelAsiaContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.asiaContinent),
            title: "Континент Азии",
            size: 26,
            style: "mr_fontick")
    }()
    
    private lazy var labelCountAsiaContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.asiaContinent),
            title: "Количество стран: \(viewModel.countCountriesOfAsia)",
            size: 20,
            style: "mr_fontick")
    }()
    
    private lazy var buttonAsiaContinent: UIButton = {
        setButton(
            color: viewModel.isSelect(isOn: !viewModel.asiaContinent),
            labelName: labelAsiaContinent,
            labelCount: labelCountAsiaContinent,
            tag: 4)
    }()
    
    private lazy var labelOceanContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.oceaniaContinent),
            title: "Континент Океании",
            size: 26,
            style: "mr_fontick")
    }()
    
    private lazy var labelCountOceanContinent: UILabel = {
        setLabel(
            color: viewModel.isSelect(isOn: viewModel.oceaniaContinent),
            title: "Количество стран: \(viewModel.countCountriesOfOceania)",
            size: 20,
            style: "mr_fontick")
    }()
    
    private lazy var buttonOceanContinent: UIButton = {
        setButton(
            color: viewModel.isSelect(isOn: !viewModel.oceaniaContinent),
            labelName: labelOceanContinent,
            labelCount: labelCountOceanContinent,
            tag: 5)
    }()
    
    private lazy var stackViewContinents: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [buttonAllCountries, buttonAmericaContinent,
                               buttonEuropeContinent, buttonAfricaContinent,
                               buttonAsiaContinent, buttonOceanContinent])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonCheckmark: UIButton = {
        setCheckmarkButton(image: viewModel.isCheckmark(isOn: viewModel.isCountdown()))
    }()
    
    private lazy var viewCheckmark: UIView = {
        setView(color: .white, radius: 13, addButton: buttonCheckmark)
    }()
    
    private lazy var labelCheckmark: UILabel = {
        setLabel(
            color: .white,
            title: "Вкл / Выкл",
            size: 26,
            style: "mr_fontick",
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
        let segment = UISegmentedControl(items: ["Один вопрос", "Все вопросы"])
        let font = UIFont(name: "mr_fontick", size: 22)
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
        return segment
    }()
    
    private lazy var stackViewTime: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, stackViewPickerViews])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonDone: UIButton = {
        setButton(title: "ОК", color: viewModel.colorDone, action: #selector(done))
    }()
    
    private lazy var buttonCancel: UIButton = {
        setButton(title: "Отмена", color: .white, action: #selector(closeViewSetting))
    }()
    
    private lazy var stackView: UIStackView = {
        setStackView(buttonFirst: buttonDone, buttonSecond: buttonCancel, spacing: 15)
    }()
    
    private lazy var viewSetting: UIView = {
        let view = setView(action: #selector(closeViewSetting), view: viewModel.viewSetting())
        viewModel.setSubviews(subviews: stackView, on: view)
        return view
    }()
    
    var viewModel: GameTypeViewModelProtocol!
    weak var delegate: MenuViewControllerInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupSubviews()
        setupBarButton()
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
    // MARK: - Press button count questions / continents / countdown / time
    @objc func showSetting(sender: UIButton) {
        viewModel.setSubviews(subviews: viewSetting, on: view)
        viewModel.setSubviewsTag(subviews: buttonDone, viewSetting, tag: sender.tag)
        viewModel.setSubview(subview: subview(tag: sender.tag), on: viewSetting, and: view)
//        setting(tag: sender.tag)
        viewModel.barButtonsOnOff(buttonBack, buttonHelp, bool: false)
        viewModel.showViewSetting(viewSetting, and: visualEffectView, view)
//        labelSetting.text = viewModel.titleSetting(tag: sender.tag)
    }
    
    @objc func closeViewSetting() {
        viewModel.barButtonsOnOff(buttonBack, buttonHelp, bool: true)
        UIView.animate(withDuration: 0.5) { [self] in
            visualEffectView.alpha = 0
            viewSetting.alpha = 0
            viewSetting.transform = CGAffineTransform.init(translationX: 0, y: view.frame.height)
        } completion: { [self] _ in
            switch viewSetting.tag {
            case 1: viewModel.removeSubviews(subviews: viewSetting, pickerViewQuestions)
            case 2: viewModel.removeSubviews(subviews: viewSetting, stackViewContinents)
            case 3: viewModel.removeSubviews(subviews: viewSetting, stackViewCheckmark)
            default: viewModel.removeSubviews(subviews: viewSetting, stackViewTime)
            }
        }
    }
    // MARK: - Button press continents, change setting continents
    @objc func continents(sender: UIButton) {
        guard sender.tag > 0 else { return colorAllCountries(sender: sender) }
        viewModel.setCountContinents(sender.backgroundColor == .white ? -1 : 1)
        guard viewModel.countContinents > 4 else { return condition(sender: sender) }
        colorAllCountries(sender: buttonAllCountries)
    }
    // MARK: - Button press checkmark, change setting countdown
    @objc func countdown() {
        viewModel.checkmarkOnOff(buttonCheckmark)
    }
    // MARK: - Press done button for change setting
    @objc func done(sender: UIButton) {
        switch sender.tag {
            
        case 1: viewModel.setQuestions(pickerViewQuestions, labelCountQuestion, labelTime) {
            self.closeViewSetting()
        }
        case 2: viewModel.setContinents(
            labelContinents, labelCountQuestion, pickerViewQuestions, buttonAllCountries,
            buttonAmericaContinent, buttonEuropeContinent, buttonAfricaContinent,
            buttonAsiaContinent, buttonOceanContinent) {
                self.closeViewSetting()
            }
        case 3: viewModel.setCountdown(buttonCheckmark, labelCountdown, imageInfinity,
                                       labelTime, buttonTime) {
            self.closeViewSetting()
        }
        default: viewModel.setTime(segmentedControl, labelTime, labelTimeDesription,
                                   pickerViewOneTime, pickerViewAllTime) {
            self.closeViewSetting()
        }
            
        }
    }
    // MARK: - GameTypeViewControllerInput
    func dataToMenu(setting: Setting, favourites: [Favorites]) {
        delegate.dataToMenu(setting: setting, favorites: favourites)
    }
    
    func favoritesToGameType(favorites: [Favorites]) {
        viewModel.setFavorites(newFavorites: favorites)
    }
    
    func disableFavoriteButton() {
        viewModel.buttonOnOff(button: buttonFavorites, isOn: false)
    }
    // MARK: - General methods
    private func setupDesign() {
        view.backgroundColor = viewModel.background
        imageInfinity.isHidden = viewModel.isCountdown()
    }
    
    private func setupSubviews() {
        viewModel.setSubviews(subviews: viewGameType, imageGameType, labelGameName,
                              stackViewButtons, buttonCountQuestions, buttonContinents,
                              buttonCountdown, buttonTime, visualEffectView,
                              on: view)
    }
    
    private func setupBarButton() {
        viewModel.setupBarButtons(buttonBack, buttonHelp, navigationItem)
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
        delegate.dataToMenu(setting: viewModel.mode, favorites: viewModel.favorites)
    }
    
    @objc private func showViewHelp(sender: UIButton) {
        viewModel.popUpViewHelp.toggle()
        viewModel.setSubviews(subviews: viewHelp, on: view)
        viewModel.setConstraints(viewHelp, view)
        viewModel.barButtonsOnOff(buttonBack, buttonHelp, bool: false)
        viewModel.showAnimationView(viewHelp, and: visualEffectView)
    }
    
    @objc private func closeView() {
        viewModel.popUpViewHelp.toggle()
        viewModel.barButtonsOnOff(buttonBack, buttonHelp, bool: true)
        viewModel.hideAnimationView(viewHelp, and: visualEffectView)
    }
    
    @objc private func popUpViewCheck() {
        viewModel.popUpViewHelp ? closeView() : closeViewSetting()
    }
    // MARK: - Methods for popup view controllers
    private func addSubviews(tag: Int) {
        switch tag {
        case 1: viewModel.setPickerViewCountQuestions(pickerViewQuestions, viewSecondary)
        case 2: setButtonsContinents()
        case 3: viewModel.setButtonCheckmarkCountdown(stackViewCheckmark, viewSecondary, buttonCheckmark)
        default: setPickerViewsTime()
        }
    }
    
    private func setButtonsContinents() {
        viewModel.counterContinents()
        viewModel.setSubviews(subviews: stackViewContinents, on: viewSecondary)
        viewModel.setColors(buttons: buttonAllCountries, buttonAmericaContinent,
                            buttonEuropeContinent, buttonAfricaContinent,
                            buttonAsiaContinent, buttonOceanContinent) { [self] colors in
            viewModel.setLabels(labelAllCountries, labelAmericaContinent,
                                labelEuropeContinent, labelAfricaContinent,
                                labelAsiaContinent, labelOceanContinent,
                                and: labelCountAllCountries, labelCountAmericaContinent,
                                labelCountEuropeContinent, labelCountAfricaContinent,
                                labelCountAsiaContinent, labelCountOceanContinent, colors: colors)
        }
    }
    
    private func setPickerViewsTime() {
        viewModel.setPickerViewsTime(stackViewTime, viewSecondary, segmentedControl)
        viewModel.setPickerViewsTime(pickerViewOneTime, pickerViewAllTime)
    }
    // MARK: - Constraints for popup views
    private func setConstraintsSetting(tag: Int) {
        switch tag {
        case 1: setupConstraintsSettingCountQuestions()
        case 2: setupConstraintsSettingContinents()
        case 3: setupConstraintsSettingCountdown()
        default: setupConstraintsSettingTime()
        }
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
        quizOfFlagsVC.delegate = self
        navigationController?.pushViewController(quizOfFlagsVC, animated: true)
    }
    
    private func questionnaireViewController() {
        let questionnaireViewModel = viewModel.questionnaireViewModel()
        let questionnaireVC = QuestionnaireViewController()
        questionnaireVC.viewModel = questionnaireViewModel
        questionnaireVC.delegate = self
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
        startGameVC.delegate = self
        navigationController?.pushViewController(startGameVC, animated: true)
    }
    
    @objc private func favorites() {
        let favourites = viewModel.favouritesViewModel()
        let favouritesVC = FavoritesViewController()
        let navigationVC = UINavigationController(rootViewController: favouritesVC)
        favouritesVC.viewModel = favourites
        favouritesVC.delegate = self
        navigationVC.modalPresentationStyle = .custom
        present(navigationVC, animated: true)
    }
    
    @objc private func swap() {
        viewModel.swap(buttonSwap)
    }
    // MARK: - Press button count questions / continents / countdown / time. Continue
    private func setting(tag: Int) {
        addSubviews(tag: tag)
//        labelSetting.text = viewModel.titleSetting(tag: tag)
//        viewModel.setSubviewsTag(subviews: buttonDone, viewSetting, tag: tag)
        setConstraintsSetting(tag: tag)
    }
    // MARK: - Button press continents, change setting continents. Continue
    private func condition(sender: UIButton) {
        viewModel.countContinents == 0 ? colorAllCountries(sender: buttonAllCountries) : colorContinents(sender: sender)
    }
    
    private func colorAllCountries(sender: UIButton) {
        guard sender.backgroundColor == viewModel.background else { return }
        viewModel.setCountContinents(0)
        viewModel.buttonAllCountries(buttonAllCountries, labelAllCountries, labelCountAllCountries, .white, viewModel.background)
        viewModel.buttonContinents(buttonAmericaContinent, buttonEuropeContinent,
                                   buttonAfricaContinent, buttonAsiaContinent,
                                   buttonOceanContinent,
                                   and: labelAmericaContinent, labelCountAmericaContinent,
                                   labelEuropeContinent, labelCountEuropeContinent,
                                   labelAfricaContinent, labelCountAfricaContinent,
                                   labelAsiaContinent, labelCountAsiaContinent, labelOceanContinent,
                                   labelCountOceanContinent,
                                   and: viewModel.background, .white)
    }
    
    private func colorContinents(sender: UIButton) {
        let colorLabel = sender.backgroundColor == viewModel.background ? viewModel.background : .white
        labelOnOff(tag: sender.tag, color: colorLabel)
        viewModel.colorButtonContinent(sender)
        guard buttonAllCountries.backgroundColor == .white else { return }
        viewModel.buttonAllCountries(buttonAllCountries, labelAllCountries, labelCountAllCountries, viewModel.background, .white)
    }
    
    private func labelOnOff(tag: Int, color: UIColor) {
        switch tag {
        case 0: viewModel.labelOnOff(labelAllCountries, labelCountAllCountries, and: color)
        case 1: viewModel.labelOnOff(labelAmericaContinent, labelCountAmericaContinent, and: color)
        case 2: viewModel.labelOnOff(labelEuropeContinent, labelCountEuropeContinent, and: color)
        case 3: viewModel.labelOnOff(labelAfricaContinent, labelCountAfricaContinent, and: color)
        case 4: viewModel.labelOnOff(labelAsiaContinent, labelCountAsiaContinent, and: color)
        default: viewModel.labelOnOff(labelOceanContinent, labelCountOceanContinent, and: color)
        }
    }
    // MARK: - Segmented control press, change setting time for one question or for all questions
    @objc private func segmentSelect() {
        viewModel.segmentSelect(segmentedControl, pickerViewOneTime, pickerViewAllTime, labelSetting)
    }
}
// MARK: - Setup constraints
extension GameTypeViewController {
    private func setupConstraints() {
        viewModel.setSquare(subviews: buttonBack, buttonHelp, sizes: 40)
        
        NSLayoutConstraint.activate([
            viewGameType.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            viewGameType.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        viewModel.setSquare(subviews: viewGameType, sizes: viewModel.diameter)
        viewModel.setCenterSubview(subview: imageGameType, on: viewGameType)
        
        NSLayoutConstraint.activate([
            labelGameName.topAnchor.constraint(equalTo: viewGameType.bottomAnchor, constant: 10),
            labelGameName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackViewButtons.topAnchor.constraint(equalTo: labelGameName.bottomAnchor, constant: 15),
            stackViewButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        viewModel.setSize(subview: stackViewButtons, width: 160, height: 40)
        
        viewModel.setConstraints(buttonCountQuestions, layout: stackViewButtons.bottomAnchor,
                                 leading: 20, trailing: -viewModel.width(view), height: 160, view)
        viewModel.setConstraints(labelCountQuestion, on: buttonCountQuestions, constant: -30)
        viewModel.setConstraints(labelCount, on: buttonCountQuestions, constant: 35)
        
        viewModel.setConstraints(buttonContinents, layout: stackViewButtons.bottomAnchor,
                                 leading: viewModel.width(view), trailing: -20, height: 190, view)
        viewModel.setConstraints(labelContinents, on: buttonContinents, constant: -15)
        viewModel.setConstraints(labelContinentsDescription, on: buttonContinents, constant: 75)
        
        viewModel.setConstraints(buttonCountdown, layout: buttonCountQuestions.bottomAnchor,
                                 leading: 20, trailing: -viewModel.width(view), height: 150, view)
        viewModel.setConstraints(labelCountdown, on: buttonCountdown, constant: -25)
        viewModel.setConstraints(labelCountdownDesription, on: buttonCountdown, constant: 35)
        
        viewModel.setConstraints(buttonTime, layout: buttonContinents.bottomAnchor,
                                 leading: viewModel.width(view), trailing: -20, height: 120, view)
        viewModel.setConstraints(labelTime, on: buttonTime, constant: -25)
        viewModel.setConstraints(labelTimeDesription, on: buttonTime, constant: 30)
        
        NSLayoutConstraint.activate([
            imageInfinity.centerXAnchor.constraint(equalTo: buttonTime.centerXAnchor),
            imageInfinity.centerYAnchor.constraint(equalTo: buttonTime.centerYAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupConstraintsSettingCountQuestions() {
        setupConstraintsViewsAndLabel(constant: 100)
        setupConstraintsSubviews(subview: pickerViewQuestions, to: viewSecondary, height: 110)
        setupConstraintsDoneCancel()
    }
    
    private func setupConstraintsSettingContinents() {
        setupConstraintsViewsAndLabel(constant: -220)
        setupConstraintsSubviews(subview: stackViewContinents, to: viewSecondary, height: 435)
        setupConstraintsOnButton()
        setupConstraintsDoneCancel()
    }
    
    private func setupConstraintsSettingCountdown() {
        setupConstraintsViewsAndLabel(constant: 165)
        setupConstraintsSubviews(subview: stackViewCheckmark, to: viewSecondary, height: 60)
        viewModel.setSquare(subviews: viewCheckmark, sizes: 60)
        viewModel.setCenterSubview(subview: buttonCheckmark, on: viewCheckmark)
        viewModel.setSquare(subviews: buttonCheckmark, sizes: 50)
        setupConstraintsDoneCancel()
    }
    
    private func setupConstraintsSettingTime() {
        setupConstraintsViewsAndLabel(constant: 60)
        setupConstraintsSubviews(subview: stackViewTime, to: viewSecondary, height: 165)
        setupConstraintsDoneCancel()
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupConstraintsViewsAndLabel(constant: CGFloat) {
        NSLayoutConstraint.activate([
            viewSetting.topAnchor.constraint(equalTo: view.centerYAnchor, constant: constant),
            viewSetting.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            viewSetting.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            viewSetting.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            labelSetting.centerXAnchor.constraint(equalTo: viewSetting.centerXAnchor, constant: 20),
            labelSetting.centerYAnchor.constraint(equalTo: viewSetting.topAnchor, constant: 31.875)
        ])
        
        NSLayoutConstraint.activate([
            viewSecondary.topAnchor.constraint(equalTo: viewSetting.topAnchor, constant: 63.75),
            viewSecondary.leadingAnchor.constraint(equalTo: viewSetting.leadingAnchor),
            viewSecondary.trailingAnchor.constraint(equalTo: viewSetting.trailingAnchor),
            viewSecondary.bottomAnchor.constraint(equalTo: viewSetting.bottomAnchor)
        ])
    }
    
    private func setupConstraintsSubviews(subview: UIView, to otherSubview: UIView, height: CGFloat) {
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: otherSubview.topAnchor, constant: 20),
            subview.leadingAnchor.constraint(equalTo: otherSubview.leadingAnchor, constant: 20),
            subview.trailingAnchor.constraint(equalTo: otherSubview.trailingAnchor, constant: -20),
            subview.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupConstraintsOnButton() {
        setupOnButton(labelFirst: labelAllCountries, and: labelCountAllCountries, on: buttonAllCountries)
        setupOnButton(labelFirst: labelAmericaContinent, and: labelCountAmericaContinent, on: buttonAmericaContinent)
        setupOnButton(labelFirst: labelEuropeContinent, and: labelCountEuropeContinent, on: buttonEuropeContinent)
        setupOnButton(labelFirst: labelAfricaContinent, and: labelCountAfricaContinent, on: buttonAfricaContinent)
        setupOnButton(labelFirst: labelAsiaContinent, and: labelCountAsiaContinent, on: buttonAsiaContinent)
        setupOnButton(labelFirst: labelOceanContinent, and: labelCountOceanContinent, on: buttonOceanContinent)
    }
    
    private func setupOnButton(
        labelFirst: UILabel, and labelSecond: UILabel, on button: UIButton) {
            NSLayoutConstraint.activate([
                labelFirst.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                labelFirst.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: -12.5),
                labelSecond.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                labelSecond.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 12.5)
            ])
    }
    
    private func setupConstraintsDoneCancel() {
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: viewSecondary.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: viewSecondary.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: viewSecondary.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

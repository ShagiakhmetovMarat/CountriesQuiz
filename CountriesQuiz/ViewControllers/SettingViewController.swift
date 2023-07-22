//
//  SettingViewController.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 06.12.2022.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: - Subviews
    private lazy var viewPanel: UIView = {
        let view = setView(color: UIColor.panelViewLightBlueLight)
        return view
    }()
    
    private lazy var buttonBackMenu: UIButton = {
        let button = setButton(
            title: "Главное меню",
            style: "mr_fontick",
            size: 15,
            colorTitle: UIColor.blueLight,
            colorBackgroud: UIColor.cyanLight,
            radiusCorner: 14,
            shadowColor: UIColor.shadowBlueLight.cgColor,
            radiusShadow: 2.5,
            shadowOffsetWidth: 2.5,
            shadowOffsetHeight: 2.5)
        button.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonDefaultSetting: UIButton = {
        let lightBlue = UIColor.cyanLight
        let blue = UIColor.blueLight
        let darkBlue = UIColor.shadowBlueLight
        let lightGray = UIColor.skyGrayLight
        let gray = UIColor.grayLight
        let darkGray = UIColor.shadowGrayLight
        let button = setButton(
            title: "Сброс",
            style: "mr_fontick",
            size: 15,
            colorTitle: conditions() ? blue : gray,
            colorBackgroud: conditions() ? lightBlue : lightGray,
            radiusCorner: 14,
            shadowColor: conditions() ? darkBlue.cgColor : darkGray.cgColor,
            radiusShadow: 2.5,
            shadowOffsetWidth: 2.5,
            shadowOffsetHeight: 2.5,
            isEnabled: conditions() ? true : false)
        button.addTarget(self, action: #selector(defaultSetting), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = setView(color: UIColor.contentLight)
        view.frame.size = contentSize
        return view
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + fixSizeForContentViewBySizeIphone())
    }
    
    private lazy var labelNumberQuestions: UILabel = {
        let label = setLabel(
            title: "Количество вопросов:",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight,
            numberOfLines: 1,
            textAlignment: .center)
        return label
    }()
    
    private lazy var labelNumber: UILabel = {
        let label = setLabel(
            title: "\(settingDefault.countQuestions)",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight,
            textAlignment: .left)
        return label
    }()
    
    private lazy var stackViewNumberQuestion: UIStackView = {
        let stackView = setStackViewLabels(labelFirst: labelNumberQuestions,
                                           labelSecond: labelNumber, spacing: 10)
        return stackView
    }()
    
    private lazy var pickerViewNumberQuestion: UIPickerView = {
        let pickerView = setPickerView(
            backgroundColor: UIColor.skyCyanLight,
            tag: 1,
            isEnabled: true)
        return pickerView
    }()
    
    private lazy var viewAllCountries: UIView = {
        let view = setView(color: UIColor.skyCyanLight, radiusCorner: 13,
                           addButton: buttonAllCountries)
        return view
    }()
    
    private lazy var buttonAllCountries: UIButton = {
        let button = setButtonCheckmark(
            image: checkmark(isOn: settingDefault.allCountries), tag: 1)
        return button
    }()
    
    private lazy var labelAllCountries: UILabel = {
        let label = setLabel(
            title: "Все страны мира",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var labelCountAllCountries: UILabel = {
        let label = setLabel(
            title: "Количество стран: \(FlagsOfCountries.shared.countries.count)",
            size: 20,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var stackViewLabelsAllCountries: UIStackView = {
        let stackView = setStackViewLabels(labelFirst: labelAllCountries,
                                           labelSecond: labelCountAllCountries,
                                           axis: .vertical,
                                           distribution: .fillEqually,
                                           alignment: .center)
        return stackView
    }()
    
    private lazy var stackViewAllCountries: UIStackView = {
        let stackView = setStackViewCheckmark(view: viewAllCountries,
                                              stackView: stackViewLabelsAllCountries)
        return stackView
    }()
    /*
    private lazy var toggleAllCountries: UISwitch = {
        let toggle = setToggle(
            toggleColor: UIColor(
                red: 153/255,
                green: 204/255,
                blue: 255/255,
                alpha: 1),
            onColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1),
            isOn: settingDefault.allCountries,
            shadowColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1).cgColor,
            shadowRadius: 2,
            shadowOffsetWidth: 2,
            shadowOffsetHeight: 2)
        return toggle
    }()
    
    private lazy var stackViewAllCountries: UIStackView = {
        let stackView = setStackView(label: labelAllCountries,
                                     toggle: toggleAllCountries)
        return stackView
    }()
    */
    private lazy var viewAmericaContinent: UIView = {
        let view = setView(color: UIColor.skyCyanLight, radiusCorner: 13,
                           addButton: buttonAmericaContinent)
        return view
    }()
    
    private lazy var buttonAmericaContinent: UIButton = {
        let button = setButtonCheckmark(
            image: checkmark(isOn: settingDefault.americaContinent), tag: 2)
        return button
    }()
    
    private lazy var labelAmericaContinent: UILabel = {
        let label = setLabel(
            title: "Континент Америки",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var labelCountAmericaContinent: UILabel = {
        let label = setLabel(
            title: "Количество стран: \(FlagsOfCountries.shared.countriesOfAmericanContinent.count)",
            size: 20,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var stackViewLabelsAmericaContinent: UIStackView = {
        let stackView = setStackViewLabels(labelFirst: labelAmericaContinent,
                                           labelSecond: labelCountAmericaContinent,
                                           axis: .vertical,
                                           distribution: .fillEqually,
                                           alignment: .center)
        return stackView
    }()
    
    private lazy var stackViewAmericaContinent: UIStackView = {
        let stackView = setStackViewCheckmark(view: viewAmericaContinent,
                                              stackView: stackViewLabelsAmericaContinent)
        return stackView
    }()
    /*
    private lazy var toggleAmericaContinent: UISwitch = {
        let toggle = setToggle(
            toggleColor: UIColor(
                red: 153/255,
                green: 204/255,
                blue: 255/255,
                alpha: 1),
            onColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1),
            isOn: settingDefault.americaContinent,
            shadowColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1).cgColor,
            shadowRadius: 2,
            shadowOffsetWidth: 2,
            shadowOffsetHeight: 2)
        return toggle
    }()
    
    private lazy var stackViewAmericaContinent: UIStackView = {
        let stackView = setStackView(label: labelAmericaContinent,
                                     toggle: toggleAmericaContinent)
        return stackView
    }()
    */
    private lazy var viewEuropeContinent: UIView = {
        let view = setView(color: UIColor.skyCyanLight, radiusCorner: 13,
                           addButton: buttonEuropeContinent)
        return view
    }()
    
    private lazy var buttonEuropeContinent: UIButton = {
        let button = setButtonCheckmark(
            image: checkmark(isOn: settingDefault.europeContinent), tag: 3)
        return button
    }()
    
    private lazy var labelEuropeContinent: UILabel = {
        let label = setLabel(
            title: "Континент Европы",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var labelCountEuropeContinent: UILabel = {
        let label = setLabel(
            title: "Количество стран: \(FlagsOfCountries.shared.countriesOfEuropeanContinent.count)",
            size: 20,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var stackViewLabelsEuropeContinent: UIStackView = {
        let stackView = setStackViewLabels(labelFirst: labelEuropeContinent,
                                           labelSecond: labelCountEuropeContinent,
                                           axis: .vertical,
                                           distribution: .fillEqually,
                                           alignment: .center)
        return stackView
    }()
    
    private lazy var stackViewEuropeContinent: UIStackView = {
        let stackView = setStackViewCheckmark(view: viewEuropeContinent,
                                              stackView: stackViewLabelsEuropeContinent)
        return stackView
    }()
    /*
    private lazy var toggleEuropeContinent: UISwitch = {
        let toggle = setToggle(
            toggleColor: UIColor(
                red: 153/255,
                green: 204/255,
                blue: 255/255,
                alpha: 1),
            onColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1),
            isOn: settingDefault.europeContinent,
            shadowColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1).cgColor,
            shadowRadius: 2,
            shadowOffsetWidth: 2,
            shadowOffsetHeight: 2)
        return toggle
    }()
    
    private lazy var stackViewEuropeContinent: UIStackView = {
        let stackView = setStackView(label: labelEuropeContinent,
                                     toggle: toggleEuropeContinent)
        return stackView
    }()
    */
    private lazy var viewAfricaContinent: UIView = {
        let view = setView(color: UIColor.skyCyanLight, radiusCorner: 13,
                           addButton: buttonAfricaContinent)
        return view
    }()
    
    private lazy var buttonAfricaContinent: UIButton = {
        let button = setButtonCheckmark(
            image: checkmark(isOn: settingDefault.africaContinent), tag: 4)
        return button
    }()
    
    private lazy var labelAfricaContinent: UILabel = {
        let label = setLabel(
            title: "Континент Африки",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var labelCountAfricaContinent: UILabel = {
        let label = setLabel(
            title: "Количество стран: \(FlagsOfCountries.shared.countriesOfAfricanContinent.count)",
            size: 20,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var stackViewLabelsAfricaContinent: UIStackView = {
        let stackView = setStackViewLabels(labelFirst: labelAfricaContinent,
                                           labelSecond: labelCountAfricaContinent,
                                           axis: .vertical,
                                           distribution: .fillEqually,
                                           alignment: .center)
        return stackView
    }()
    
    private lazy var stackViewAfricaContinent: UIStackView = {
        let stackView = setStackViewCheckmark(view: viewAfricaContinent,
                                              stackView: stackViewLabelsAfricaContinent)
        return stackView
    }()
    /*
    private lazy var toggleAfricaContinent: UISwitch = {
        let toggle = setToggle(
            toggleColor: UIColor(
                red: 153/255,
                green: 204/255,
                blue: 255/255,
                alpha: 1),
            onColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1),
            isOn: settingDefault.africaContinent,
            shadowColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1).cgColor,
            shadowRadius: 2,
            shadowOffsetWidth: 2,
            shadowOffsetHeight: 2)
        return toggle
    }()
    
    private lazy var stackViewAfricaContinent: UIStackView = {
        let stackView = setStackView(label: labelAfricaContinent,
                                     toggle: toggleAfricaContinent)
        return stackView
    }()
    */
    private lazy var viewAsiaContinent: UIView = {
        let view = setView(color: UIColor.skyCyanLight, radiusCorner: 13,
                           addButton: buttonAsiaContinent)
        return view
    }()
    
    private lazy var buttonAsiaContinent: UIButton = {
        let button = setButtonCheckmark(
            image: checkmark(isOn: settingDefault.asiaContinent), tag: 5)
        return button
    }()
    
    private lazy var labelAsiaContinent: UILabel = {
        let label = setLabel(
            title: "Континент Азии",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var labelCountAsiaContinent: UILabel = {
        let label = setLabel(
            title: "Количество стран: \(FlagsOfCountries.shared.countriesOfAsianContinent.count)",
            size: 20,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var stackViewLabelsAsiaContinent: UIStackView = {
        let stackView = setStackViewLabels(labelFirst: labelAsiaContinent,
                                           labelSecond: labelCountAsiaContinent,
                                           axis: .vertical,
                                           distribution: .fillEqually,
                                           alignment: .center)
        return stackView
    }()
    
    private lazy var stackViewAsiaContinent: UIStackView = {
        let stackView = setStackViewCheckmark(view: viewAsiaContinent,
                                              stackView: stackViewLabelsAsiaContinent)
        return stackView
    }()
    /*
    private lazy var toggleAsiaContinent: UISwitch = {
        let toggle = setToggle(
            toggleColor: UIColor(
                red: 153/255,
                green: 204/255,
                blue: 255/255,
                alpha: 1),
            onColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1),
            isOn: settingDefault.asiaContinent,
            shadowColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1).cgColor,
            shadowRadius: 2,
            shadowOffsetWidth: 2,
            shadowOffsetHeight: 2)
        return toggle
    }()
    
    private lazy var stackViewAsiaContinent: UIStackView = {
        let stackView = setStackView(label: labelAsiaContinent,
                                     toggle: toggleAsiaContinent)
        return stackView
    }()
    */
    private lazy var viewOceaniaContinent: UIView = {
        let view = setView(color: UIColor.skyCyanLight, radiusCorner: 13,
                           addButton: buttonOceaniaContinent)
        return view
    }()
    
    private lazy var buttonOceaniaContinent: UIButton = {
        let button = setButtonCheckmark(
            image: checkmark(isOn: settingDefault.oceaniaContinent), tag: 6)
        return button
    }()
    
    private lazy var labelOceaniaContinent: UILabel = {
        let label = setLabel(
            title: "Континент Океании",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var labelCountOceaniaContinent: UILabel = {
        let label = setLabel(
            title: "Количество стран: \(FlagsOfCountries.shared.countriesOfOceanContinent.count)",
            size: 20,
            style: "mr_fontick",
            color: UIColor.blueLight)
        return label
    }()
    
    private lazy var stackViewLabelsOceaniaContinent: UIStackView = {
        let stackView = setStackViewLabels(labelFirst: labelOceaniaContinent,
                                           labelSecond: labelCountOceaniaContinent,
                                           axis: .vertical,
                                           distribution: .fillEqually,
                                           alignment: .center)
        return stackView
    }()
    
    private lazy var stackViewOceaniaContinent: UIStackView = {
        let stackView = setStackViewCheckmark(view: viewOceaniaContinent,
                                              stackView: stackViewLabelsOceaniaContinent)
        return stackView
    }()
    /*
    private lazy var toggleOceaniaContinent: UISwitch = {
        let toggle = setToggle(
            toggleColor: UIColor(
                red: 153/255,
                green: 204/255,
                blue: 255/255,
                alpha: 1),
            onColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1),
            isOn: settingDefault.oceaniaContinent,
            shadowColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1).cgColor,
            shadowRadius: 2,
            shadowOffsetWidth: 2,
            shadowOffsetHeight: 2)
        return toggle
    }()
    
    private lazy var stackViewOceaniaContinent: UIStackView = {
        let stackView = setStackView(label: labelOceaniaContinent,
                                     toggle: toggleOceaniaContinent)
        return stackView
    }()
    */
    private lazy var viewTimeElapsed: UIView = {
        let view = setView(color: UIColor.skyCyanLight, radiusCorner: 13,
                           addButton: buttonTimeElapsed)
        return view
    }()
    
    private lazy var buttonTimeElapsed: UIButton = {
        let button = setButtonCheckmark(
            image: checkmark(isOn: settingDefault.timeElapsed.timeElapsed), tag: 7)
        return button
    }()
    
    private lazy var labelTimeElapsed: UILabel = {
        let label = setLabel(
            title: "Обратный отсчет",
            size: 26,
            style: "mr_fontick",
            color: UIColor.blueLight,
            textAlignment: .center)
        return label
    }()
    
    private lazy var stackViewTimeElapsed: UIStackView = {
        let stackView = setStackViewCheckmark(view: viewTimeElapsed,
                                              label: labelTimeElapsed)
        return stackView
    }()
    /*
    private lazy var toggleTimeElapsed: UISwitch = {
        let toggle = setToggle(
            toggleColor: UIColor(
                red: 153/255,
                green: 204/255,
                blue: 255/255,
                alpha: 1),
            onColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1),
            isOn: settingDefault.timeElapsed.timeElapsed,
            shadowColor: UIColor(
                red: 54/255,
                green: 55/255,
                blue: 215/255,
                alpha: 1).cgColor,
            shadowRadius: 2,
            shadowOffsetWidth: 2,
            shadowOffsetHeight: 2)
        return toggle
    }()
    
    private lazy var stackViewTimeElapsed: UIStackView = {
        let stackView = setStackView(label: labelTimeElapsed,
                                     toggle: toggleTimeElapsed)
        return stackView
    }()
    */
    private lazy var labelTimeElapsedQuestion: UILabel = {
        let blue = UIColor.blueLight
        let gray = UIColor.grayLight
        let label = setLabel(
            title: isEnabledText(),
            size: 26,
            style: "mr_fontick",
            color: settingDefault.timeElapsed.timeElapsed ? blue : gray,
            numberOfLines: 1)
        return label
    }()
    
    private lazy var labelTimeElapsedNumber: UILabel = {
        let blue = UIColor.blueLight
        let gray = UIColor.grayLight
        let label = setLabel(
            title: setLabelNumberQuestions(),
            size: 26,
            style: "mr_fontick",
            color: settingDefault.timeElapsed.timeElapsed ? blue : gray,
            textAlignment: .left)
        return label
    }()
    
    private lazy var stackViewLabelTimeElapsed: UIStackView = {
        let stackView = setStackViewLabels(labelFirst: labelTimeElapsedQuestion,
                                           labelSecond: labelTimeElapsedNumber,
                                           spacing: 10)
        return stackView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let lightBlue = UIColor.skyCyanLight
        let blue = UIColor.blueLight
        let lightGray = UIColor.skyGrayLight
        let gray = UIColor.grayLight
        let segment = setSegmentedControl(
            background: settingDefault.timeElapsed.timeElapsed ? lightBlue : lightGray,
            segmentColor: settingDefault.timeElapsed.timeElapsed ? blue : gray,
            elements: ["Один вопрос", "Все вопросы"],
            titleSelectedColor: settingDefault.timeElapsed.timeElapsed ? lightBlue : lightGray,
            titleNormalColor: settingDefault.timeElapsed.timeElapsed ? blue : gray,
            setIndex: settingDefault.timeElapsed.questionSelect.oneQuestion ? 0 : 1,
            isEnabled: settingDefault.timeElapsed.timeElapsed ? true : false,
            borderColor: settingDefault.timeElapsed.timeElapsed ? lightBlue : lightGray)
        return segment
    }()
    
    private lazy var pickerViewOneQuestion: UIPickerView = {
        let gray = UIColor.skyGrayLight
        let pickerView = setPickerView(
            backgroundColor: settingDefault.timeElapsed.timeElapsed ? isEnabledColor(tag: 2) : gray,
            tag: 2,
            isEnabled: settingDefault.timeElapsed.timeElapsed ? isEnabled(tag: 2) : false)
        return pickerView
    }()
    
    private lazy var pickerViewAllQuestions: UIPickerView = {
        let gray = UIColor.skyGrayLight
        let pickerView = setPickerView(
            backgroundColor: settingDefault.timeElapsed.timeElapsed ? isEnabledColor(tag: 3) : gray,
            tag: 3,
            isEnabled: settingDefault.timeElapsed.timeElapsed ? isEnabled(tag: 3) : false)
        return pickerView
    }()
    
    private lazy var stackViewPickerViews: UIStackView = {
        let stackView = setStackViewPickerViews(pickerViewFirst: pickerViewOneQuestion,
                                                pickerViewSecond: pickerViewAllQuestions)
        return stackView
    }()
    
    var settingDefault: Setting!
    var delegate: SettingViewControllerDelegate!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupSubviewsOnView()
        setupSubviewsOnContentView()
        setupSubviewsOnScrollView()
        setupConstraints()
    }
    // MARK: - Private methods
    private func setupDesign() {
        view.backgroundColor = UIColor.backgroundBlueLight
        setupPickerViewNumberQuestions()
        setupPickerViewOneQuestion()
    }
    
    private func setupPickerViewNumberQuestions() {
        let countQuestions = settingDefault.countQuestions
        let currentRowCountQuestions = countQuestions - 10
        pickerViewNumberQuestion.selectRow(currentRowCountQuestions, inComponent: 0, animated: false)
        setupPickerViewAllQuestions(countQuestions: countQuestions)
    }
    
    private func setupPickerViewOneQuestion() {
        let currentRowOneQuestion = settingDefault.timeElapsed.questionSelect.questionTime.oneQuestionTime - 6
        pickerViewOneQuestion.selectRow(currentRowOneQuestion, inComponent: 0, animated: false)
    }
    
    private func setupPickerViewAllQuestions(countQuestions: Int) {
        let currentTimeAllQuestions = settingDefault.timeElapsed.questionSelect.questionTime.allQuestionsTime
        let currentRowAllQuestions = currentTimeAllQuestions - (4 * countQuestions)
        pickerViewAllQuestions.selectRow(currentRowAllQuestions, inComponent: 0, animated: false)
    }
    
    private func setupSubviewsOnView() {
        setupSubviews(subviews: viewPanel, buttonBackMenu, buttonDefaultSetting,
                      contentView)
    }
    
    private func setupSubviewsOnContentView() {
        setupSubviewsOnContentView(subviews: scrollView)
    }
    
    private func setupSubviewsOnScrollView() {
        setupSubviewsOnScrollView(subviews: stackViewNumberQuestion,
                                  pickerViewNumberQuestion,
                                  stackViewAllCountries,
                                  stackViewAmericaContinent,
                                  stackViewEuropeContinent,
                                  stackViewAfricaContinent,
                                  stackViewAsiaContinent,
                                  stackViewOceaniaContinent,
                                  stackViewTimeElapsed,
                                  stackViewLabelTimeElapsed,
                                  segmentedControl,
                                  stackViewPickerViews)
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupSubviewsOnContentView(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func setupSubviewsOnScrollView(subviews: UIView...) {
        subviews.forEach { subview in
            scrollView.addSubview(subview)
        }
    }
    // MARK: - Activating buttons
    @objc private func backToMenu() {
        delegate.sendDataOfSetting(setting: settingDefault)
        dismiss(animated: true)
    }
    
    @objc private func defaultSetting() {
        showAlert(setting: settingDefault)
    }
    
    private func buttonIsEnabled(isEnabled: Bool, titleColor: UIColor,
                                 backgroundColor: UIColor, shadowColor: CGColor) {
        buttonDefaultSetting.isEnabled = isEnabled
        buttonDefaultSetting.setTitleColor(titleColor, for: .normal)
        buttonDefaultSetting.backgroundColor = backgroundColor
        buttonDefaultSetting.layer.shadowColor = shadowColor
    }
    
    private func conditions() -> Bool {
        !settingDefault.allCountries && settingDefault.countQuestions > 50
    }
    // MARK: - Setting label of number questions
    private func setLabelNumberQuestions() -> String {
        let text: String
        if pickerViewOneQuestion.isUserInteractionEnabled {
            text = "\(settingDefault.timeElapsed.questionSelect.questionTime.oneQuestionTime)"
        } else {
            text = "\(settingDefault.timeElapsed.questionSelect.questionTime.allQuestionsTime)"
        }
        return text
    }
    // MARK: - Setting of toggles
    @objc private func buttonCheckmark(sender: UIButton) {
        switch sender {
        case buttonAllCountries:
            checkmarkOnAllCountries()
            settingOnAllCountries()
        case buttonAmericaContinent:
            settingDefault.americaContinent.toggle()
            checkmarkContinents(button: sender, isOn: settingDefault.americaContinent)
        case buttonEuropeContinent:
            settingDefault.europeContinent.toggle()
            checkmarkContinents(button: sender, isOn: settingDefault.europeContinent)
        case buttonAfricaContinent:
            settingDefault.africaContinent.toggle()
            checkmarkContinents(button: sender, isOn: settingDefault.africaContinent)
        case buttonAsiaContinent:
            settingDefault.asiaContinent.toggle()
            checkmarkContinents(button: sender, isOn: settingDefault.asiaContinent)
        case buttonOceaniaContinent:
            settingDefault.oceaniaContinent.toggle()
            checkmarkContinents(button: sender, isOn: settingDefault.oceaniaContinent)
        default:
            checkmarkTimeElapsed(button: sender)
        }
    }
    
    private func checkmarkOnAllCountries() {
        checkmarkOnOff(buttons: buttonAllCountries, image: "checkmark.circle.fill")
        checkmarkOnOff(buttons: buttonAmericaContinent, buttonEuropeContinent,
                       buttonAfricaContinent, buttonAsiaContinent,
                       buttonOceaniaContinent, image: "circle")
    }
    
    private func settingOnAllCountries() {
        checkmarkSettingOnOff(buttons: buttonAllCountries, bool: true)
        checkmarkSettingOnOff(buttons: buttonAmericaContinent, buttonEuropeContinent,
                              buttonAfricaContinent, buttonAsiaContinent,
                              buttonOceaniaContinent, bool: false)
    }
    
    private func checkmarkOnOff(buttons: UIButton..., image: String) {
        buttons.forEach { button in
            let configuration = UIImage.SymbolConfiguration(pointSize: 25)
            let image = UIImage(systemName: image, withConfiguration: configuration)
            button.configuration?.image = image
        }
    }
    
    private func checkmarkSettingOnOff(buttons: UIButton..., bool: Bool) {
        buttons.forEach { button in
            switch button.tag {
            case 1: settingDefault.allCountries = bool
            case 2: settingDefault.americaContinent = bool
            case 3: settingDefault.europeContinent = bool
            case 4: settingDefault.africaContinent = bool
            case 5: settingDefault.asiaContinent = bool
            default: settingDefault.oceaniaContinent = bool
            }
        }
    }
    
    private func checkmarkContinents(button: UIButton, isOn: Bool) {
        if settingDefault.americaContinent, settingDefault.europeContinent,
           settingDefault.africaContinent, settingDefault.asiaContinent,
           settingDefault.oceaniaContinent {
            checkmarkOnAllCountries()
            settingOnAllCountries()
        } else if !settingDefault.allCountries, !settingDefault.americaContinent,
                  !settingDefault.europeContinent, !settingDefault.africaContinent,
                  !settingDefault.asiaContinent, !settingDefault.oceaniaContinent {
            checkmarkOnAllCountries()
            settingOnAllCountries()
        } else {
            checkmarkOnOff(buttons: buttonAllCountries, image: "circle")
            checkmarkOnOff(buttons: button, image: isOn ? "checkmark.circle.fill" : "circle")
            checkmarkSettingOnOff(buttons: buttonAllCountries, bool: false)
        }
    }
    
    private func checkmarkTimeElapsed(button: UIButton) {
        settingDefault.timeElapsed.timeElapsed.toggle()
        let isOn = settingDefault.timeElapsed.timeElapsed
        checkmarkOnOff(buttons: button,
                       image: isOn ? "checkmark.circle.fill" : "circle")
        checkmarkColors(isOn: isOn)
    }
    
    private func checkmarkColors(isOn: Bool) {
        let blue = UIColor.blueLight
        let gray = UIColor.grayLight
        checkmarkLabels(blue: blue, gray: gray, isOn: isOn)
        checkmarkSegmentedControl(blue: blue, gray: gray, isOn: isOn)
        checkmarkPickerViews(isOn: isOn)
    }
    
    private func checkmarkLabels(blue: UIColor, gray: UIColor, isOn: Bool) {
        labelTimeElapsedQuestion.textColor = isOn ? blue : gray
        labelTimeElapsedNumber.textColor = isOn ? blue : gray
    }
    
    private func checkmarkSegmentedControl(blue: UIColor, gray: UIColor, isOn: Bool) {
        let lightBlue = UIColor.skyCyanLight
        let lightGray = UIColor.skyGrayLight
        segmentedControl.isUserInteractionEnabled = isOn ? true : false
        segmentedControl.backgroundColor = isOn ? lightBlue : lightGray
        segmentedControl.selectedSegmentTintColor = isOn ? blue : gray
        segmentedControl.layer.borderColor = isOn ? lightBlue.cgColor : lightGray.cgColor
        segmentSelectColors(blue: blue, gray: gray, lightBlue: lightBlue,
                            lightGray: lightGray, isOn: isOn)
    }
    
    private func segmentSelectColors(blue: UIColor, gray: UIColor, lightBlue: UIColor,
                                     lightGray: UIColor, isOn: Bool) {
        let font = UIFont(name: "mr_fontick", size: 26)
        let titleSelectedColor: UIColor = isOn ? lightBlue : lightGray
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key
                .font: font ?? "",
                .foregroundColor: titleSelectedColor
        ], for: .selected)
        
        let titleNormalColor: UIColor = isOn ? blue : gray
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key
                .font: font ?? "",
                .foregroundColor: titleNormalColor
        ], for: .normal)
    }
    
    private func checkmarkPickerViews(isOn: Bool) {
        let lightGray = UIColor.skyGrayLight
        pickerViewOneQuestion.isUserInteractionEnabled = isOn ? isEnabled(tag: 2) : false
        pickerViewOneQuestion.backgroundColor = isOn ? isEnabledColor(tag: 2) : lightGray
        pickerViewOneQuestion.reloadAllComponents()
        pickerViewAllQuestions.isUserInteractionEnabled = isOn ? isEnabled(tag: 3) : false
        pickerViewAllQuestions.backgroundColor = isOn ? isEnabledColor(tag: 3) : lightGray
        pickerViewAllQuestions.reloadAllComponents()
    }
    /*
    @objc private func toggleAction(target: UISwitch) {
        switch target {
            
        case toggleAllCountries:
            
            if !toggleAmericaContinent.isOn, !toggleEuropeContinent.isOn, !toggleAfricaContinent.isOn,
               !toggleAsiaContinent.isOn, !toggleOceaniaContinent.isOn {
                toggleOn(toggles: toggleAllCountries)
            } else {
                toggleOff(toggles: toggleAmericaContinent, toggleEuropeContinent,
                          toggleAfricaContinent, toggleAsiaContinent, toggleOceaniaContinent)
            }
            
        case toggleAmericaContinent, toggleEuropeContinent, toggleAfricaContinent,
            toggleAsiaContinent, toggleOceaniaContinent:
            
            if toggleAmericaContinent.isOn, toggleEuropeContinent.isOn, toggleAfricaContinent.isOn,
               toggleAsiaContinent.isOn, toggleOceaniaContinent.isOn {
                toggleOff(toggles: toggleAmericaContinent, toggleEuropeContinent,
                          toggleAfricaContinent, toggleAsiaContinent, toggleOceaniaContinent)
                toggleOn(toggles: toggleAllCountries)
            } else if !toggleAllCountries.isOn, !toggleAmericaContinent.isOn, !toggleEuropeContinent.isOn,
                      !toggleAfricaContinent.isOn, !toggleAsiaContinent.isOn, !toggleOceaniaContinent.isOn {
                toggleOn(toggles: toggleAllCountries)
            } else {
                toggleOff(toggles: toggleAllCountries)
            }
            
        default:
            
            settingDefault.timeElapsed.timeElapsed = target.isOn ? true : false
            StorageManager.shared.rewriteSetting(setting: settingDefault)
            
            let lightBlue = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1)
            let blue = UIColor(red: 54/255, green: 55/255, blue: 215/255, alpha: 1)
            let lightGray = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
            let gray = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            let font = UIFont(name: "mr_fontick", size: 26)
            
            labelTimeElapsedQuestion.textColor = target.isOn ? lightBlue : lightGray
            labelTimeElapsedQuestion.layer.shadowColor = target.isOn ? blue.cgColor : gray.cgColor
            labelTimeElapsedNumber.textColor = target.isOn ? lightBlue : lightGray
            labelTimeElapsedNumber.layer.shadowColor = target.isOn ? blue.cgColor : gray.cgColor
            
            segmentedControl.isUserInteractionEnabled = target.isOn ? true : false
            segmentedControl.backgroundColor = target.isOn ? lightBlue : lightGray
            segmentedControl.selectedSegmentTintColor = target.isOn ? blue : gray
            
            let titleSelectedColor: UIColor = target.isOn ? lightBlue : lightGray
            segmentedControl.setTitleTextAttributes([
                NSAttributedString.Key
                    .font: font ?? "",
                    .foregroundColor: titleSelectedColor
            ], for: .selected)
            let titleNormalColor: UIColor = target.isOn ? blue : gray
            segmentedControl.setTitleTextAttributes([
                NSAttributedString.Key
                    .font: font ?? "",
                    .foregroundColor: titleNormalColor
            ], for: .normal)
            
            pickerViewOneQuestion.isUserInteractionEnabled = target.isOn ? isEnabled(tag: 2) : false
            pickerViewOneQuestion.backgroundColor = target.isOn ? isEnabledColor(tag: 2) : lightGray
            pickerViewOneQuestion.reloadAllComponents()
            pickerViewAllQuestions.isUserInteractionEnabled = target.isOn ? isEnabled(tag: 3) : false
            pickerViewAllQuestions.backgroundColor = target.isOn ? isEnabledColor(tag: 3) : lightGray
            pickerViewAllQuestions.reloadAllComponents()
            
        }
        
        toggleRewrite(allCountries: toggleAllCountries.isOn, americaContinent: toggleAmericaContinent.isOn,
                      europeContinent: toggleEuropeContinent.isOn, africaContinent: toggleAfricaContinent.isOn,
                      asiaContinent: toggleAsiaContinent.isOn, oceaniaContinent: toggleOceaniaContinent.isOn)
        setupRowsPickerView(allCountries: toggleAllCountries.isOn, americaContinent: toggleAmericaContinent.isOn,
                            europeContinent: toggleEuropeContinent.isOn, africaContinent: toggleAfricaContinent.isOn,
                            asiaContinent: toggleAsiaContinent.isOn, oceaniaContinent: toggleOceaniaContinent.isOn)
        
        let lightBlue = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1)
        let blue = UIColor(red: 54/255, green: 55/255, blue: 215/255, alpha: 1)
        let lightGray = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        let gray = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        conditions() ?
        buttonIsEnabled(
            isEnabled: true,
            titleColor: blue,
            backgroundColor: lightBlue,
            shadowColor: blue.cgColor) :
        buttonIsEnabled(
            isEnabled: false,
            titleColor: gray,
            backgroundColor: lightGray,
            shadowColor: gray.cgColor)
    }
    
    private func toggleOff(toggles: UISwitch...) {
        toggles.forEach { toggle in
            toggle.setOn(false, animated: true)
        }
    }
    
    private func toggleOn(toggles: UISwitch...) {
        toggles.forEach { toggle in
            toggle.setOn(true, animated: true)
        }
    }
    */
    private func checkmark(isOn: Bool) -> String {
        isOn ? "checkmark.circle.fill" : "circle"
    }
    
    private func toggleRewrite(allCountries: Bool,
                               americaContinent: Bool,
                               europeContinent: Bool,
                               africaContinent: Bool,
                               asiaContinent: Bool,
                               oceaniaContinent: Bool) {
        settingDefault.allCountries = allCountries
        settingDefault.americaContinent = americaContinent
        settingDefault.europeContinent = europeContinent
        settingDefault.africaContinent = africaContinent
        settingDefault.asiaContinent = asiaContinent
        settingDefault.oceaniaContinent = oceaniaContinent
        StorageManager.shared.rewriteSetting(setting: settingDefault)
    }
    
    private func setupRowsPickerView(allCountries: Bool,
                                     americaContinent: Bool,
                                     europeContinent: Bool,
                                     africaContinent: Bool,
                                     asiaContinent: Bool,
                                     oceaniaContinent: Bool) {
        var countRows = checkAllCountries(toggle: allCountries) +
        checkAmericaContinent(toggle: americaContinent) +
        checkEuropeContinent(toggle: europeContinent) +
        checkAfricaContinent(toggle: africaContinent) +
        checkAsiaContinent(toggle: asiaContinent) +
        checkOceaniaContinent(toggle: oceaniaContinent) - 9
        
        if countRows > DefaultSetting.countRows.rawValue {
            countRows = DefaultSetting.countRows.rawValue
        }
        
        if countRows < settingDefault.countRows {
            let countQuestions = countRows + 9
            
            settingDefault.countRows = countRows
            pickerViewNumberQuestion.reloadAllComponents()
            pickerViewNumberQuestion.selectRow(countRows, inComponent: 0, animated: false)
            
            if countQuestions < settingDefault.countQuestions {
                let averageQuestionTime = 5 * countQuestions
                let currentRow = averageQuestionTime - (4 * countQuestions)
                
                setupDataFromPickerView(countQuestion: countQuestions,
                                        averageTime: averageQuestionTime,
                                        currentRow: currentRow)
                
            }
        } else {
            settingDefault.countRows = countRows
            pickerViewNumberQuestion.reloadAllComponents()
        }
        
        StorageManager.shared.rewriteSetting(setting: settingDefault)
    }
    
    private func checkAllCountries(toggle: Bool) -> Int {
        toggle ? FlagsOfCountries.shared.countries.count : 0
    }
    
    private func checkAmericaContinent(toggle: Bool) -> Int {
        toggle ? FlagsOfCountries.shared.countriesOfAmericanContinent.count : 0
    }
    
    private func checkEuropeContinent(toggle: Bool) -> Int {
        toggle ? FlagsOfCountries.shared.countriesOfEuropeanContinent.count : 0
    }
    
    private func checkAfricaContinent(toggle: Bool) -> Int {
        toggle ? FlagsOfCountries.shared.countriesOfAfricanContinent.count : 0
    }
    
    private func checkAsiaContinent(toggle: Bool) -> Int {
        toggle ? FlagsOfCountries.shared.countriesOfAsianContinent.count : 0
    }
    
    private func checkOceaniaContinent(toggle: Bool) -> Int {
        toggle ? FlagsOfCountries.shared.countriesOfOceanContinent.count : 0
    }
    // MARK: - Setting of segmented control
    @objc private func segmentedControlAction() {
        let lightBlue = UIColor.skyCyanLight
        let lightGray = UIColor.skyGrayLight
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let countQuestion = settingDefault.countQuestions
            let currentTime = settingDefault.timeElapsed.questionSelect.questionTime.allQuestionsTime
            let currentRow = currentTime - (4 * countQuestion)
            
            segmentAction(pickerView: pickerViewOneQuestion, isEnabled: true, backgroundColor: lightBlue)
            segmentAction(pickerView: pickerViewAllQuestions, isEnabled: false, backgroundColor: lightGray)
            
            setupDataFromSegmentedControl(
                currentRow: currentRow,
                pickerView: pickerViewAllQuestions,
                oneQuestion: true,
                timeElapsedQuestion: "Время одного вопроса:",
                timeElapsedNumber: "\(settingDefault.timeElapsed.questionSelect.questionTime.oneQuestionTime)")
        } else {
            let currentTime = settingDefault.timeElapsed.questionSelect.questionTime.oneQuestionTime
            let currentRow = currentTime - 6
            
            segmentAction(pickerView: pickerViewOneQuestion, isEnabled: false, backgroundColor: lightGray)
            segmentAction(pickerView: pickerViewAllQuestions, isEnabled: true, backgroundColor: lightBlue)
            
            setupDataFromSegmentedControl(
                currentRow: currentRow,
                pickerView: pickerViewOneQuestion,
                oneQuestion: false,
                timeElapsedQuestion: "Время всех вопросов:",
                timeElapsedNumber: "\(settingDefault.timeElapsed.questionSelect.questionTime.allQuestionsTime)")
        }
    }
    
    private func segmentAction(pickerView: UIPickerView,
                               isEnabled: Bool,
                               backgroundColor: UIColor) {
        pickerView.isUserInteractionEnabled = isEnabled
        pickerView.backgroundColor = backgroundColor
        pickerView.reloadAllComponents()
    }
    
    private func setupDataFromSegmentedControl(currentRow: Int,
                                               pickerView: UIPickerView,
                                               oneQuestion: Bool,
                                               timeElapsedQuestion: String,
                                               timeElapsedNumber: String) {
        pickerView.selectRow(currentRow, inComponent: 0, animated: false)
        
        settingDefault.timeElapsed.questionSelect.oneQuestion = oneQuestion
        
        labelTimeElapsedQuestion.text = timeElapsedQuestion
        labelTimeElapsedNumber.text = timeElapsedNumber
        
        StorageManager.shared.rewriteSetting(setting: settingDefault)
    }
    // MARK: - Enabled or disabled picker view and color and label
    private func isEnabled(tag: Int) -> Bool {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if tag == 2 {
                return true
            } else {
                return false
            }
        default:
            if tag == 2 {
                return false
            } else {
                return true
            }
        }
    }
    
    private func isEnabledColor(tag: Int) -> UIColor {
        let lightBlue = UIColor.skyCyanLight
        let lightGray = UIColor.skyGrayLight
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if tag == 2 {
                return lightBlue
            } else {
                return lightGray
            }
        default:
            if tag == 2 {
                return lightGray
            } else {
                return lightBlue
            }
        }
    }
    
    private func isEnabledTextColor(tag: Int) -> UIColor {
        let blue = UIColor.blueLight
        let gray = UIColor.grayLight
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if tag == 2 {
                return blue
            } else {
                return gray
            }
        default:
            if tag == 2 {
                return gray
            } else {
                return blue
            }
        }
    }
    
    private func isEnabledText() -> String {
        let text: String
        if segmentedControl.selectedSegmentIndex == 0 {
            text = "Время одного вопроса:"
        } else {
            text = "Время всех вопросов:"
        }
        return text
    }
    // MARK: - Reset setting default
    private func resetSetting() {
        settingDefault = Setting.getSettingDefault()
        
        let currentRowCountQuestion = settingDefault.countQuestions - 10
        let averageQuestionTime = 5 * settingDefault.countQuestions
        let currentRowTimeElapsedOneQuestion = settingDefault.timeElapsed.questionSelect.questionTime.oneQuestionTime - 6
        let currentRowTimeElapsedAllQuestions = averageQuestionTime - (4 * settingDefault.countQuestions)
        
        labelNumber.text = "\(settingDefault.countQuestions)"
        labelTimeElapsedNumber.text = "\(settingDefault.timeElapsed.questionSelect.questionTime.oneQuestionTime)"
        /*
        toggleOn(toggles: toggleAllCountries, toggleTimeElapsed)
        toggleOff(toggles: toggleAmericaContinent, toggleEuropeContinent,
                  toggleAfricaContinent, toggleAsiaContinent, toggleOceaniaContinent)
        */
        segmentedControl.selectedSegmentIndex = 0
        
        pickerViewNumberQuestion.reloadAllComponents()
        pickerViewNumberQuestion.selectRow(currentRowCountQuestion, inComponent: 0, animated: false)
        pickerViewOneQuestion.reloadAllComponents()
        pickerViewOneQuestion.selectRow(currentRowTimeElapsedOneQuestion, inComponent: 0, animated: false)
        pickerViewAllQuestions.reloadAllComponents()
        pickerViewAllQuestions.selectRow(currentRowTimeElapsedAllQuestions, inComponent: 0, animated: false)
        
        let lightGray = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        let gray = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        buttonIsEnabled(
            isEnabled: false,
            titleColor: gray,
            backgroundColor: lightGray,
            shadowColor: gray.cgColor)
        
        StorageManager.shared.rewriteSetting(setting: settingDefault)
    }
}
// MARK: - Setup view
extension SettingViewController {
    private func setView(color: UIColor? = nil, radiusCorner: CGFloat? = nil,
                         addButton: UIButton? = nil) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if let color = color {
            view.backgroundColor = color
            view.layer.cornerRadius = radiusCorner ?? 0
            if let button = addButton {
                view.addSubview(button)
            }
        } else {
            setGradient(content: view)
        }
        return view
    }
}
// MARK: - Gradient
extension SettingViewController {
    private func setGradient(content: UIView) {
        let gradientLayer = CAGradientLayer()
        let colorGrayOne = UIColor.colorGradientOneLight
        let colorGrayTwo = UIColor.colorGradientTwoLight
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [colorGrayOne.cgColor, colorGrayTwo.cgColor, colorGrayOne.cgColor]
        content.layer.addSublayer(gradientLayer)
    }
}
// MARK: - Setup button
extension SettingViewController {
    private func setButton(title: String, style: String? = nil, size: CGFloat,
                           colorTitle: UIColor? = nil, colorBackgroud: UIColor? = nil,
                           radiusCorner: CGFloat? = nil, borderWidth: CGFloat? = nil,
                           borderColor: CGColor? = nil, shadowColor: CGColor? = nil,
                           radiusShadow: CGFloat? = nil, shadowOffsetWidth: CGFloat? = nil,
                           shadowOffsetHeight: CGFloat? = nil,
                           isEnabled: Bool? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(colorTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: style ?? "", size: size)
        button.backgroundColor = colorBackgroud
        button.layer.cornerRadius = radiusCorner ?? 0
        button.layer.borderWidth = borderWidth ?? 0
        button.layer.borderColor = borderColor
        button.layer.shadowColor = shadowColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = radiusShadow ?? 0
        button.layer.shadowOffset = CGSize(width: shadowOffsetWidth ?? 0,
                                           height: shadowOffsetHeight ?? 0)
        button.isEnabled = isEnabled ?? true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func setButtonCheckmark(image: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: image, withConfiguration: configuration)
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.baseBackgroundColor = .clear
        button.configuration?.baseForegroundColor = UIColor.blueLight
        button.configuration?.image = image
        button.tag = tag
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonCheckmark), for: .touchUpInside)
        return button
    }
}
// MARK: - Setup label
extension SettingViewController {
    private func setLabel(title: String, size: CGFloat, style: String, color: UIColor,
                          colorOfShadow: CGColor? = nil, radiusOfShadow: CGFloat? = nil,
                          shadowOffsetWidth: CGFloat? = nil, shadowOffsetHeight: CGFloat? = nil,
                          numberOfLines: Int? = nil,
                          textAlignment: NSTextAlignment? = nil) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: style, size: size)
        label.textColor = color
        label.layer.shadowColor = colorOfShadow
        label.layer.shadowRadius = radiusOfShadow ?? 0
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: shadowOffsetWidth ?? 0,
                                          height: shadowOffsetHeight ?? 0)
        label.numberOfLines = numberOfLines ?? 0
        label.textAlignment = textAlignment ?? .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
// MARK: - Setup picker view
extension SettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return settingDefault.countRows
        case 2:
            return 10
        default:
            return (6 * settingDefault.countQuestions) - (4 * settingDefault.countQuestions) + 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        var title = ""
        var attributed = NSAttributedString()
        
        switch pickerView.tag {
        case 1:
            title = "\(row + 10)"
            attributed = attributedString(title: title)
        case 2:
            title = "\(row + 6)"
            attributed = attributedStringTimeElapsed(title: title, tag: 2)
        default:
            let allQuestionTime = 4 * settingDefault.countQuestions
            title = "\(row + allQuestionTime)"
            attributed = attributedStringTimeElapsed(title: title, tag: 3)
        }
        
        label.textAlignment = .center
        label.attributedText = attributed
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            
            let countQuestion = row + 10
            let averageQuestionTime = 5 * countQuestion
            let currentRow = averageQuestionTime - (4 * countQuestion)
            
            setupDataFromPickerView(countQuestion: countQuestion,
                                    averageTime: averageQuestionTime,
                                    currentRow: currentRow)
            
            let lightBlue = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1)
            let blue = UIColor(red: 54/255, green: 55/255, blue: 215/255, alpha: 1)
            let lightGray = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
            let gray = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            conditions() ?
            buttonIsEnabled(
                isEnabled: true,
                titleColor: blue,
                backgroundColor: lightBlue,
                shadowColor: blue.cgColor) :
            buttonIsEnabled(
                isEnabled: false,
                titleColor: gray,
                backgroundColor: lightGray,
                shadowColor: gray.cgColor)
            
            StorageManager.shared.rewriteSetting(setting: settingDefault)
            
        case 2:
            
            let oneQuestionTime = row + 6
            labelTimeElapsedNumber.text = "\(oneQuestionTime)"
            settingDefault.timeElapsed.questionSelect.questionTime.oneQuestionTime = oneQuestionTime
            StorageManager.shared.rewriteSetting(setting: settingDefault)
            
        default:
            
            let allQuestionTime = row + (4 * settingDefault.countQuestions)
            labelTimeElapsedNumber.text = "\(allQuestionTime)"
            settingDefault.timeElapsed.questionSelect.questionTime.allQuestionsTime = allQuestionTime
            StorageManager.shared.rewriteSetting(setting: settingDefault)
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch pickerView.tag {
        case 1:
            return pickerView.frame.width
        case 2:
            return 150
        default:
            return 150
        }
    }
    
    private func setPickerView(backgroundColor: UIColor,
                               tag: Int,
                               isEnabled: Bool) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = backgroundColor
        pickerView.layer.cornerRadius = 13
        pickerView.tag = tag
        pickerView.isUserInteractionEnabled = isEnabled
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }
    
    private func attributedString(title: String) -> NSAttributedString {
        NSAttributedString(string: title, attributes: [
            .font: UIFont(name: "mr_fontick", size: 26) ?? "",
            .foregroundColor:
                UIColor(
                    red: 54/255,
                    green: 55/255,
                    blue: 252/255,
                    alpha: 1)
        ])
    }
    
    private func attributedStringTimeElapsed(title: String, tag: Int) -> NSAttributedString {
        let gray = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        let currentColor: UIColor = settingDefault.timeElapsed.timeElapsed ? isEnabledTextColor(tag: tag) : gray
        return NSAttributedString(string: title, attributes: [
            .font: UIFont(name: "mr_fontick", size: 26) ?? "",
            .foregroundColor: currentColor
        ])
    }
    
    private func checkPickerViewEnabled(time: Int) -> String {
        let text = "\(settingDefault.timeElapsed.questionSelect.questionTime.oneQuestionTime)"
        guard pickerViewAllQuestions.isUserInteractionEnabled else { return text }
        return "\(time)"
    }
    
    private func setupDataFromPickerView(countQuestion: Int, averageTime: Int, currentRow: Int) {
        labelNumber.text = "\(countQuestion)"
        labelTimeElapsedNumber.text = checkPickerViewEnabled(time: averageTime)
        
        settingDefault.countQuestions = countQuestion
        settingDefault.timeElapsed.questionSelect.questionTime.allQuestionsTime = averageTime
        
        pickerViewAllQuestions.reloadAllComponents()
        pickerViewAllQuestions.selectRow(currentRow, inComponent: 0, animated: false)
    }
}
// MARK: - Setup toggle
extension SettingViewController {
    private func setToggle(toggleColor: UIColor, onColor: UIColor, isOn: Bool,
                           shadowColor: CGColor? = nil, shadowRadius: CGFloat? = nil,
                           shadowOffsetWidth: CGFloat? = nil,
                           shadowOffsetHeight: CGFloat? = nil) -> UISwitch {
        let toggle = UISwitch()
        toggle.thumbTintColor = toggleColor
        toggle.onTintColor = onColor
        toggle.layer.shadowColor = shadowColor
        toggle.layer.shadowRadius = shadowRadius ?? 0
        toggle.layer.shadowOpacity = 1
        toggle.layer.shadowOffset = CGSize(width: shadowOffsetWidth ?? 0,
                                           height: shadowOffsetHeight ?? 0)
        toggle.isOn = isOn
//        toggle.addTarget(self, action: #selector(toggleAction), for: .valueChanged)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }
}
// MARK: - Setup stack view
extension SettingViewController {
    private func setStackViewLabels(labelFirst: UILabel, labelSecond: UILabel,
                                    spacing: CGFloat? = nil,
                                    axis: NSLayoutConstraint.Axis? = nil,
                                    distribution: UIStackView.Distribution? = nil,
                                    alignment: UIStackView.Alignment? = nil) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [labelFirst, labelSecond])
        stackView.spacing = spacing ?? 0
        stackView.axis = axis ?? .horizontal
        stackView.distribution = distribution ?? .fill
        stackView.alignment = alignment ?? .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setStackView(label: UILabel, toggle: UISwitch) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, toggle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }
    
    private func setStackViewCheckmark(view: UIView, stackView: UIStackView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [view, stackView])
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setStackViewCheckmark(view: UIView, label: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [view, label])
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setStackViewPickerViews(pickerViewFirst: UIPickerView,
                                         pickerViewSecond: UIPickerView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [pickerViewFirst, pickerViewSecond])
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
// MARK: - Setup segmented control
extension SettingViewController {
    private func setSegmentedControl(background: UIColor, segmentColor: UIColor,
                                     elements: [Any], titleSelectedColor: UIColor,
                                     titleNormalColor: UIColor, setIndex: Int,
                                     isEnabled: Bool, borderColor: UIColor) -> UISegmentedControl {
        let segment = UISegmentedControl(items: elements)
        let font = UIFont(name: "mr_fontick", size: 26)
        segment.backgroundColor = background
        segment.selectedSegmentTintColor = segmentColor
        segment.setTitleTextAttributes([
            NSAttributedString.Key
                .font: font ?? "",
                .foregroundColor: titleSelectedColor
        ], for: .selected)
        segment.setTitleTextAttributes([
            NSAttributedString.Key
                .font: font ?? "",
                .foregroundColor: titleNormalColor
        ], for: .normal)
        segment.selectedSegmentIndex = setIndex
        segment.isUserInteractionEnabled = isEnabled
        segment.layer.borderWidth = 5
        segment.layer.borderColor = borderColor.cgColor
        segment.addTarget(self, action: #selector(segmentedControlAction), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }
}
// MARK: - Setup constraints
extension SettingViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewPanel.topAnchor.constraint(equalTo: view.topAnchor),
            viewPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewPanel.heightAnchor.constraint(equalToConstant: fixConstraintsForViewPanelBySizeIphone())
        ])
        
        NSLayoutConstraint.activate([
            buttonBackMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: fixConstraintsForButtonBySizeIphone()),
            buttonBackMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonBackMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -245)
        ])
        
        NSLayoutConstraint.activate([
            buttonDefaultSetting.topAnchor.constraint(equalTo: view.topAnchor, constant: fixConstraintsForButtonBySizeIphone()),
            buttonDefaultSetting.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 245),
            buttonDefaultSetting.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: viewPanel.bottomAnchor, constant: 1),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackViewNumberQuestion.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 14),
            stackViewNumberQuestion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 8),
            stackViewNumberQuestion.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        setupStartConstraints(subviewFirst: pickerViewNumberQuestion,
                              to: stackViewNumberQuestion,
                              leadingConstant: 20, constant: 12)
        NSLayoutConstraint.activate([
            pickerViewNumberQuestion.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        setupStartConstraints(subviewFirst: stackViewAllCountries,
                              to: pickerViewNumberQuestion,
                              leadingConstant: 20, constant: 15)
        setupSquareOfView(subview: viewAllCountries, size: 60)
        setupConstraintsCentersOnView(button: buttonAllCountries, on: viewAllCountries)
        setupSquareOfView(subview: buttonAllCountries, size: 50)
        
        setupStartConstraints(subviewFirst: stackViewAmericaContinent,
                              to: stackViewAllCountries,
                              leadingConstant: 20, constant: 15)
        setupSquareOfView(subview: viewAmericaContinent, size: 60)
        setupConstraintsCentersOnView(button: buttonAmericaContinent, on: viewAmericaContinent)
        setupSquareOfView(subview: buttonAmericaContinent, size: 50)
        
        setupStartConstraints(subviewFirst: stackViewEuropeContinent,
                              to: stackViewAmericaContinent,
                              leadingConstant: 20, constant: 15)
        setupSquareOfView(subview: viewEuropeContinent, size: 60)
        setupConstraintsCentersOnView(button: buttonEuropeContinent, on: viewEuropeContinent)
        setupSquareOfView(subview: buttonEuropeContinent, size: 50)
        
        setupStartConstraints(subviewFirst: stackViewAfricaContinent,
                              to: stackViewEuropeContinent,
                              leadingConstant: 20, constant: 15)
        setupSquareOfView(subview: viewAfricaContinent, size: 60)
        setupConstraintsCentersOnView(button: buttonAfricaContinent, on: viewAfricaContinent)
        setupSquareOfView(subview: buttonAfricaContinent, size: 50)
        
        setupStartConstraints(subviewFirst: stackViewAsiaContinent,
                              to: stackViewAfricaContinent,
                              leadingConstant: 20, constant: 15)
        setupSquareOfView(subview: viewAsiaContinent, size: 60)
        setupConstraintsCentersOnView(button: buttonAsiaContinent, on: viewAsiaContinent)
        setupSquareOfView(subview: buttonAsiaContinent, size: 50)
        
        setupStartConstraints(subviewFirst: stackViewOceaniaContinent,
                              to: stackViewAsiaContinent,
                              leadingConstant: 20, constant: 15)
        setupSquareOfView(subview: viewOceaniaContinent, size: 60)
        setupConstraintsCentersOnView(button: buttonOceaniaContinent, on: viewOceaniaContinent)
        setupSquareOfView(subview: buttonOceaniaContinent, size: 50)
        
        setupStartConstraints(subviewFirst: stackViewTimeElapsed,
                              to: stackViewOceaniaContinent,
                              leadingConstant: 20, constant: 15)
        setupSquareOfView(subview: viewTimeElapsed, size: 60)
        setupConstraintsCentersOnView(button: buttonTimeElapsed, on: viewTimeElapsed)
        setupSquareOfView(subview: buttonTimeElapsed, size: 50)
        
        setupStartConstraints(subviewFirst: stackViewLabelTimeElapsed,
                              to: stackViewTimeElapsed,
                              leadingConstant: view.frame.width / 8, constant: 15)
        
        setupStartConstraints(subviewFirst: segmentedControl,
                              to: stackViewLabelTimeElapsed,
                              leadingConstant: 20, constant: 15)
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        setupStartConstraints(subviewFirst: stackViewPickerViews,
                              to: segmentedControl,
                              leadingConstant: 20, constant: 15)
        NSLayoutConstraint.activate([
            stackViewPickerViews.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func setupStartConstraints(subviewFirst: UIView, to subviewSecond: UIView,
                                       leadingConstant: CGFloat, constant: CGFloat) {
        NSLayoutConstraint.activate([
            subviewFirst.topAnchor.constraint(equalTo: subviewSecond.bottomAnchor, constant: constant),
            subviewFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant),
            subviewFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSquareOfView(subview: UIView, size: CGFloat) {
        NSLayoutConstraint.activate([
            subview.heightAnchor.constraint(equalToConstant: size),
            subview.widthAnchor.constraint(equalToConstant: size)
        ])
    }
    
    private func setupConstraintsCentersOnView(button: UIButton, on view: UIView) {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fixConstraintsForViewPanelBySizeIphone() -> CGFloat {
        view.frame.height > 736 ? 110 : 70
    }
    
    private func fixSizeForContentViewBySizeIphone() -> CGFloat {
        view.frame.height > 736 ? 180 : 320
        
    }
    
    private func fixConstraintsForButtonBySizeIphone() -> CGFloat {
        view.frame.height > 736 ? 60 : 30
    }
}
// MARK: - Alert controller
extension SettingViewController {
    private func showAlert(setting: Setting) {
        let title = "Сбросить настройки"
        
        let alert = AlertController(
            title: title,
            message: "Вы действительно хотите скинуть все настройки до заводских?",
            preferredStyle: .alert)
        
        alert.action(setting: setting) {
            self.resetSetting()
        }
        
        present(alert, animated: true)
    }
}

//
//  ContinentsViewModel.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 10.10.2024.
//

import UIKit

protocol ContinentsViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var allCountries: Bool { get }
    var americaContinent: Bool { get }
    var europeContinent: Bool { get }
    var africaContinent: Bool { get }
    var asiaContinent: Bool { get }
    var oceaniaContinent: Bool { get }
    var delegate: SettingViewControllerInput! { get set }
    var mode: Setting { get }
    
    init(mode: Setting)
    
    func setBarButton(button: UIButton, navigationItem: UINavigationItem)
    func setSubviews(subviews: UIView..., on subviewOther: UIView)
    func setLabel(text: String, font: String, size: CGFloat) -> UILabel
    func text(tag: Int) -> String
    func attributedText(text: String, tag: Int) -> NSMutableAttributedString
    func isSelect(isOn: Bool) -> UIColor
    func setButtonsContinent(button: UIButton)
    func counterContinents()
    
    func setContinents(sender: UIButton)
    func setSquare(subview: UIView, sizes: CGFloat)
}

class ContinentsViewModel: ContinentsViewModelProtocol {
    var title = "Continents.title".localized
    var description = "Continents.description".localized
    var allCountries: Bool {
        mode.allCountries
    }
    var americaContinent: Bool {
        mode.americaContinent
    }
    var europeContinent: Bool {
        mode.europaContinent
    }
    var africaContinent: Bool {
        mode.africaContinent
    }
    var asiaContinent: Bool {
        mode.asiaContinent
    }
    var oceaniaContinent: Bool {
        mode.oceaniaContinent
    }
    var delegate: SettingViewControllerInput!
    
    var mode: Setting
    
    private var countContinents = 0
    private var background: UIColor = .blueMiddlePersian
    private var titleAllCountries = "Continents.all_countries.title".localized
    private var titleAmericaContinent = "Continents.american_continent.title".localized
    private var titleEuropeContinent = "Continents.european_continent.title".localized
    private var titleAfricaContinent = "Continents.african_continent.title".localized
    private var titleAsiaContinent = "Continents.asian_continent.title".localized
    private var titleOceaniaContinent = "Continents.oceanian_continent.title".localized
    private var titleNumberOfCountries = "Continents.number_of_countries.title".localized
    
    private var buttonAllCountries: UIButton!
    private var buttonAmerica: UIButton!
    private var buttonEurope: UIButton!
    private var buttonAfrica: UIButton!
    private var buttonAsia: UIButton!
    private var buttonOcean: UIButton!
    
    required init(mode: Setting) {
        self.mode = mode
    }
    
    func setBarButton(button: UIButton, navigationItem: UINavigationItem) {
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    func setSubviews(subviews: UIView..., on subviewOther: UIView) {
        subviews.forEach { subview in
            subviewOther.addSubview(subview)
        }
    }
    
    func setLabel(text: String, font: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: font, size: size)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func text(tag: Int) -> String {
        """
        \(continent(tag: tag))
        \(count(tag: tag))
        """
    }
    
    func attributedText(text: String, tag: Int) -> NSMutableAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        let font = NSAttributedString.Key.font
        let key = UIFont(name: "GillSans", size: 19)
        let range = setRange(subString: count(tag: tag), fromString: text)
        attributed.addAttributes([font: key ?? ""], range: range)
        return attributed
    }
    
    func isSelect(isOn: Bool) -> UIColor {
        isOn ? .blueMiddlePersian : .white
    }
    
    func setButtonsContinent(button: UIButton) {
        switch button.tag {
        case 0: buttonAllCountries = button
        case 1: buttonAmerica = button
        case 2: buttonEurope = button
        case 3: buttonAfrica = button
        case 4: buttonAsia = button
        default: buttonOcean = button
        }
    }
    
    func counterContinents() {
        counterContinents(continents: americaContinent, europeContinent,
                          africaContinent, asiaContinent, oceaniaContinent)
    }
    
    func setContinents(sender: UIButton) {
        sender.tag > 0 ? setContinent(sender) : setAllCountries(sender)
    }
    
    func setSquare(subview: UIView, sizes: CGFloat) {
        NSLayoutConstraint.activate([
            subview.widthAnchor.constraint(equalToConstant: sizes),
            subview.heightAnchor.constraint(equalToConstant: sizes)
        ])
    }
}
// MARK: - Constants
extension ContinentsViewModel {
    private func setRange(subString: String, fromString: String) -> NSRange {
        let linkRange = fromString.range(of: subString)!
        let start = fromString.distance(from: fromString.startIndex, to: linkRange.lowerBound)
        let end = fromString.distance(from: fromString.startIndex, to: linkRange.upperBound)
        let range = NSMakeRange(start, end - start)
        return range
    }
    
    private func continent(tag: Int) -> String {
        switch tag {
        case 0: titleAllCountries
        case 1: titleAmericaContinent
        case 2: titleEuropeContinent
        case 3: titleAfricaContinent
        case 4: titleAsiaContinent
        default: titleOceaniaContinent
        }
    }
    
    private func count(tag: Int) -> String {
        "\(titleNumberOfCountries) \(countCountries(tag: tag))"
    }
    
    private func countCountries(tag: Int) -> Int {
        switch tag {
        case 0: FlagsOfCountries.shared.countries.count
        case 1: FlagsOfCountries.shared.countriesOfAmericanContinent.count
        case 2: FlagsOfCountries.shared.countriesOfEuropeanContinent.count
        case 3: FlagsOfCountries.shared.countriesOfAfricanContinent.count
        case 4: FlagsOfCountries.shared.countriesOfAsianContinent.count
        default: FlagsOfCountries.shared.countriesOfOceanContinent.count
        }
    }
}
// MARK: - Set data
extension ContinentsViewModel {
    private func setCountContinents(_ count: Int) {
        if count == 0 {
            countContinents = 0
        } else {
            countContinents += count
        }
    }
    
    private func counterContinents(continents: Bool...) {
        continents.forEach { continent in
            if continent {
                setCountContinents(1)
            }
        }
    }
    
    private func setContinent(_ sender: UIButton) {
        setCountContinents(sender.backgroundColor == .white ? -1 : 1)
        switch countContinents {
        case 0, 5: setAllCountries(buttonAllCountries)
        default: setButtonOnOff(sender)
        }
    }
    
    private func setAllCountries(_ sender: UIButton) {
        guard sender.backgroundColor == background else { return }
        setCountContinents(0)
        turnOffButtons(buttons: buttonAmerica, buttonEurope, buttonAfrica, buttonAsia, buttonOcean)
        buttonAllCountries(sender, isOn: true)
        setConstants()
    }
    
    private func buttonAllCountries(_ sender: UIButton, isOn: Bool) {
        let backgroundColor: UIColor = isOn ? .white : .blueMiddlePersian
        let textColor: UIColor = isOn ? .blueMiddlePersian : .white
        changeData(sender: sender, backgroundColor, textColor: textColor, and: isOn)
    }
    
    private func setButtonOnOff(_ sender: UIButton) {
        let backgroundColor = sender.backgroundColor == background ? .white : background
        let textColor = sender.backgroundColor == background ? background : .white
        let isOn = sender.backgroundColor == background ? true : false
        if allCountries {
            buttonAllCountries(buttonAllCountries, isOn: false)
        }
        changeData(sender: sender, backgroundColor, textColor: textColor, and: isOn)
        setConstants()
    }
    
    private func condition(_ sender: UIButton) {
        countContinents == 0 ? setAllCountries(buttonAllCountries) : setContinent(sender)
    }
    
    private func changeData(sender: UIButton, _ backgroundColor: UIColor,
                            textColor: UIColor, and isOn: Bool) {
        setColor(button: sender, backgroundColor: backgroundColor, textColor: textColor)
        continentToggle(sender, isOn: isOn)
    }
    
    private func setConstants() {
        setCountRows()
        setCountQuestions()
        setTimeAllQuestions()
    }
    
    private func setColor(button: UIButton, backgroundColor: UIColor,
                          textColor: UIColor) {
        UIView.animate(withDuration: 0.3) {
            button.backgroundColor = backgroundColor
            button.setTitleColor(textColor, for: .normal)
        }
    }
    
    private func turnOffButtons(buttons: UIButton...) {
        buttons.forEach { button in
            setColor(button: button, backgroundColor: .blueMiddlePersian, textColor: .white)
            continentToggle(button, isOn: false)
        }
    }
    
    private func continentToggle(_ sender: UIButton, isOn: Bool) {
        switch sender.tag {
        case 0: mode.allCountries = isOn
        case 1: mode.americaContinent = isOn
        case 2: mode.europaContinent = isOn
        case 3: mode.africaContinent = isOn
        case 4: mode.asiaContinent = isOn
        default: mode.oceaniaContinent = isOn
        }
    }
    
    private func setCountRows() {
        let countCountries = countCountries(
            continents: allCountries, americaContinent, europeContinent,
            africaContinent, asiaContinent, oceaniaContinent)
        let countRows = limitCountRows(countRows: countCountries - 9)
        mode.countRows = countRows
    }
    
    private func countCountries(continents: Bool...) -> Int {
        var countRows = 0
        var counter = 0
        continents.forEach { continent in
            if continent {
                countRows += countCountries(tag: counter)
            }
            counter += 1
        }
        return countRows
    }
    
    private func limitCountRows(countRows: Int) -> Int {
        let limitCountRows = DefaultSetting.countRows.rawValue
        return countRows > limitCountRows ? limitCountRows : countRows
    }
    
    private func setCountQuestions() {
        let countQuestions = mode.countQuestions
        let countRows = mode.countRows + 9
        let count = countRows < countQuestions ? countRows : countQuestions
        mode.countQuestions = count
    }
    
    private func setTimeAllQuestions() {
        let time = 5 * mode.countQuestions
        mode.timeElapsed.questionSelect.questionTime.allQuestionsTime = time
    }
}

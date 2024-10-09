//
//  CountQuestionsViewModel.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 09.10.2024.
//
import UIKit

protocol CountQuestionsViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var numberOfComponents: Int { get }
    var numberOfRows: Int { get }
    var heightOfRows: CGFloat { get }
    var mode: Setting { get }
    
    init(mode: Setting)
    
    func setBarButton(button: UIButton, navigationItem: UINavigationItem)
    func setSubviews(subviews: UIView..., on subviewOther: UIView)
    func setLabel(text: String, font: String, size: CGFloat) -> UILabel
    func setTitles(pickerView: UIPickerView, and row: Int) -> UIView
    
    func setSquare(subview: UIView, sizes: CGFloat)
}

class CountQuestionsViewModel: CountQuestionsViewModelProtocol {
    var title = "Количество вопросов"
    var description = """
    Установите определенное количество вопросов, на которые вы будете отвечать в игре. Минимальное значение - 10, а максимальное - 100.
    """
    var numberOfComponents = 1
    var numberOfRows: Int {
        mode.countRows
    }
    var heightOfRows: CGFloat = 35
    
    let mode: Setting
    
    required init(mode: Setting) {
        self.mode = mode
    }
    // MARK: - Subviews
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
    
    func setTitles(pickerView: UIPickerView, and row: Int) -> UIView {
        let title = "\(row + 10)"
        let attributed = setAttributed(title: title)
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = attributed
        return label
    }
    // MARK: - Constraints
    func setSquare(subview: UIView, sizes: CGFloat) {
        NSLayoutConstraint.activate([
            subview.widthAnchor.constraint(equalToConstant: sizes),
            subview.heightAnchor.constraint(equalToConstant: sizes)
        ])
    }
}

extension CountQuestionsViewModel {
    private func setAttributed(title: String) -> NSAttributedString {
        let font = UIFont(name: "mr_fontick", size: 32)
        let color = UIColor.blueMiddlePersian
        return NSAttributedString(string: title, attributes: [
            .font: font ?? "",
            .foregroundColor: color
        ])
    }
}

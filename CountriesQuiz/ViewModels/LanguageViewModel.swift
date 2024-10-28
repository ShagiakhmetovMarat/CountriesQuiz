//
//  LanguageViewModel.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 28.10.2024.
//

import UIKit

protocol LanguageViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var cell: AnyClass { get }
    var numberOfRows: Int { get }
    var heightOfRows: CGFloat { get }
    var mode: Setting { get }
    
    init(mode: Setting)
    
    func setBarButtonItem(button: UIButton, navigationItem: UINavigationItem)
    func setSubviews(subviews: UIView..., on subviewOther: UIView)
    func setLabel(text: String, font: String, size: CGFloat) -> UILabel
    func customCell(cell: LanguageCell, indexPath: IndexPath)
    
    func changeLanguage(_ indexPath: IndexPath)
    func reloadCells(_ indexPath: IndexPath, and tableView: UITableView)
    func setSquare(subview: UIView, sizes: CGFloat)
}

class LanguageViewModel: LanguageViewModelProtocol {
    var title = "Язык"
    var description = "Выберите нужный вам язык для интерфейса."
    var cell: AnyClass = LanguageCell.self
    var numberOfRows = 2
    var heightOfRows: CGFloat = 60
    var mode: Setting
    
    private var dialects: Dialect {
        mode.language
    }
    
    required init(mode: Setting) {
        self.mode = mode
    }
    
    func setBarButtonItem(button: UIButton, navigationItem: UINavigationItem) {
        let leftBarButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = leftBarButton
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
    
    func customCell(cell: LanguageCell, indexPath: IndexPath) {
        cell.title.text = textTitle(indexPath.row)
        cell.additional.text = textAdditional(indexPath.row)
        cell.accessoryType = checkmark(indexPath.row)
        cell.tintColor = .blueBlackSea
    }
    
    func changeLanguage(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: setLanguage(language: .russian)
        default: setLanguage(language: .english)
        }
    }
    
    func reloadCells(_ indexPath: IndexPath, and tableView: UITableView) {
        for row in 0..<Dialect.allCases.count {
            if row == indexPath.row {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            } else {
                tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            }
        }
    }
    
    func setSquare(subview: UIView, sizes: CGFloat) {
        NSLayoutConstraint.activate([
            subview.widthAnchor.constraint(equalToConstant: sizes),
            subview.heightAnchor.constraint(equalToConstant: sizes)
        ])
    }
}

extension LanguageViewModel {
    private func textTitle(_ row: Int) -> String {
        switch row {
        case 0: return "Russian"
        default: return "English"
        }
    }
    
    private func textAdditional(_ row: Int) -> String {
        switch row {
        case 0: return "Русский"
        default: return "English"
        }
    }
    
    private func checkmark(_ row: Int) -> UITableViewCell.AccessoryType {
        switch row {
        case 0: dialects == .russian ? .checkmark : .none
        default: dialects == .english ? .checkmark : .none
        }
    }
    
    private func setLanguage(language: Dialect) {
        mode.language = language
    }
}

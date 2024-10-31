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
    
    func selectRow(_ tableView: UITableView, and indexPath: IndexPath)
    func setSquare(subview: UIView, sizes: CGFloat)
}

class LanguageViewModel: LanguageViewModelProtocol {
    var title: String {
        switch dialects {
        case .russian: "Язык"
        default: "Language"
        }
    }
    var description: String {
        switch dialects {
        case .russian: "Выберите нужный вам язык для интерфейса."
        default: "Select the language you need for the interface."
        }
    }
    var cell: AnyClass = LanguageCell.self
    var numberOfRows = Dialect.allCases.count
    var heightOfRows: CGFloat = 60
    var mode: Setting
    
    private var dialects: Dialect {
        mode.language
    }
    private var timer = Timer()
    
    private var labelTitle: UILabel!
    private var labelDescription: UILabel!
    
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
        if label.text == title {
            labelTitle = label
        } else {
            labelDescription = label
        }
        return label
    }
    
    func customCell(cell: LanguageCell, indexPath: IndexPath) {
        cell.title.text = textTitle(indexPath.row)
        cell.additional.text = textAdditional(indexPath.row)
        cell.accessoryType = checkmark(indexPath.row)
        cell.tintColor = .blueBlackSea
    }
    
    func selectRow(_ tableView: UITableView, and indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LanguageCell else { return }
        checkTimer()
        cleanData(cell, tableView, and: indexPath)
        timer = Timer.scheduledTimer(withTimeInterval: 1.6, repeats: false, block: { [self] _ in
            reloadData(cell, tableView, and: indexPath)
        })
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
    
    private func checkTimer() {
        guard timer.isValid else { return }
        timer.invalidate()
    }
    
    private func changeLanguage(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: setLanguage(language: .russian)
        default: setLanguage(language: .english)
        }
    }
    
    private func cleanData(_ cell: LanguageCell, _ tableView: UITableView,
                           and indexPath: IndexPath) {
        changeLanguage(indexPath)
        cleanCells(tableView, and: indexPath)
        cell.indicator.startAnimating()
    }
    
    private func reloadData(_ cell: LanguageCell, _ tableView: UITableView,
                            and indexPath: IndexPath) {
        timer.invalidate()
        cell.indicator.stopAnimating()
        reloadCells(tableView, and: indexPath)
        reloadTitles()
    }
    
    private func reloadCells(_ tableView: UITableView, and indexPath: IndexPath) {
        for row in 0..<Dialect.allCases.count {
            if row == indexPath.row {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            } else {
                tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            }
        }
    }
    
    private func cleanCells(_ tableView: UITableView, and indexPath: IndexPath) {
        for row in 0..<Dialect.allCases.count {
            if row == indexPath.row {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            }
        }
    }
    
    private func reloadTitles() {
        labelTitle.text = title
        labelDescription.text = description
    }
}

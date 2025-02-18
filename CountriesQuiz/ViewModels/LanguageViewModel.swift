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
    var delegate: SettingViewControllerInput! { get set }
    var mode: Setting { get }
    
    init(mode: Setting)
    
    func setBarButtonItem(button: UIButton, navigationItem: UINavigationItem)
    func setSubviews(subviews: UIView..., on subviewOther: UIView)
    func setLabel(text: String, font: String, size: CGFloat) -> UILabel
    func customCell(cell: LanguageCell, indexPath: IndexPath)
    
    func selectRow(_ tableView: UITableView, and indexPath: IndexPath)
    func checkTimer()
    func setSquare(subview: UIView, sizes: CGFloat)
}

class LanguageViewModel: LanguageViewModelProtocol {
    var title = "Language.title".localized
    var description = "Language.description".localized
    var cell: AnyClass = LanguageCell.self
    var numberOfRows = Dialect.allCases.count
    var heightOfRows: CGFloat = 60
    var mode: Setting
    var delegate: SettingViewControllerInput!
    
    private var dialects: Dialect {
        mode.language
    }
    private var language: String {
        StorageManager.shared.fetchLanguage()
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
            timer.invalidate()
            changeLanguage(indexPath)
            reloadData(cell, tableView, and: indexPath)
        })
    }
    
    func checkTimer() {
        guard timer.isValid else { return }
        timer.invalidate()
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
        case 0: language == "ru" ? .checkmark : .none
        default: language == "en" ? .checkmark : .none
        }
    }
    
    private func setLanguage(language: Dialect) {
        mode.language = language
    }
    
    private func setLanguage(language: String) {
        Bundle.setLanguage(language)
        StorageManager.shared.saveLanguage(language: language)
    }
    
    private func reloadApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let currentVC = getTopViewController(from: window.rootViewController)
        let rootViewController = MenuViewController()
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        
        if let currentVC = currentVC {
            navigationVC.pushViewController(currentVC, animated: false)
        }
        
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
    }
    
    func getTopViewController(from rootViewController: UIViewController?) -> UIViewController? {
        if let navigaitonVC = rootViewController as? UINavigationController {
            return navigaitonVC.visibleViewController
        } else if let tabBarController = rootViewController as? UITabBarController,
                  let selectedController = tabBarController.selectedViewController {
            return getTopViewController(from: selectedController)
        } else if let presented = rootViewController?.presentedViewController {
            return getTopViewController(from: presented)
        }
        return rootViewController
    }
    
    private func changeLanguage(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            setLanguage(language: "ru")
//            setLanguage(language: .russian)
        default:
            setLanguage(language: "en")
//            setLanguage(language: .english)
        }
    }
    
    private func cleanData(_ cell: LanguageCell, _ tableView: UITableView,
                           and indexPath: IndexPath) {
        cleanCells(tableView, and: indexPath)
        cell.indicator.startAnimating()
    }
    
    private func reloadData(_ cell: LanguageCell, _ tableView: UITableView,
                            and indexPath: IndexPath) {
        cell.indicator.stopAnimating()
        reloadCells(tableView, and: indexPath)
        reloadApp()
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

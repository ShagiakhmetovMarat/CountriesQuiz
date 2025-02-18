//
//  FavoritesViewController.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 15.08.2024.
//

import UIKit

protocol FavoritesViewControllerDelegate {
    func dataToFavorites(favorites: [Favorites])
}

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoritesViewControllerDelegate {
    private lazy var buttonClose: UIButton = {
        setButton(image: "multiply", action: #selector(exitToGameType), isBarButton: true)
    }()
    
    private lazy var buttonDelete: UIButton = {
        setButton(image: "trash", action: #selector(deleteFavorite))
    }()
    
    private lazy var visualEffectBlur: UIVisualEffectView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeDetails))
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var labelTitle: UILabel = {
        viewModel.setLabel(title: viewModel.title, font: "GillSans-Bold", size: 28, color: .white)
    }()
    
    private lazy var imageTitle: UIImageView = {
        let size = UIImage.SymbolConfiguration(pointSize: 28)
        let image = UIImage(systemName: "star.fill", withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelTitle, imageTitle])
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(viewModel.cell, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = viewModel.backgroundLight
        tableView.separatorColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var viewDetails: UIView = {
        let view = viewModel.setView(color: viewModel.backgroundDark, radius: 15)
        let close = setButton(image: "multiply", action: #selector(closeDetails))
        let label = viewModel.setLabel(title: viewModel.titleError, font: "GillSans", size: 22, color: .white)
        let moreInfo = setButton()
        viewModel.setSubviews(subviews: close, label, moreInfo, on: view)
        viewModel.setConstraints(close, label, moreInfo, on: view)
        return view
    }()
    
    var viewModel: FavoritesViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        setBarButton()
        setSubviews()
        setConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        viewModel.customCell(cell: cell as! FavoritesCell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightOfRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setDetails(viewDetails, view, and: indexPath)
        viewModel.setSubviews(subviews: viewDetails, buttonDelete, on: view)
        viewModel.setConstraints(indexPath, viewDetails, and: buttonDelete, on: view)
        viewModel.buttonOnOff(button: buttonClose, isOn: false)
        viewModel.showAnimationView(viewDetails, buttonDelete, and: visualEffectBlur)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func dataToFavorites(favorites: [Favorites]) {
        viewModel.setFavorites(newFavorites: favorites)
        tableView.reloadData()
        guard viewModel.favorites.isEmpty else { return }
        exitToGameType()
        viewModel.delegate.disableFavoriteButton()
    }
    
    private func setDesign() {
        view.backgroundColor = viewModel.backgroundMedium
        navigationItem.hidesBackButton = true
    }
    
    private func setBarButton() {
        viewModel.setBarButton(buttonClose, navigationItem)
    }
    
    private func setSubviews() {
        viewModel.setSubviews(subviews: stackView, tableView, visualEffectBlur,
                              on: view)
    }
    
    @objc private func exitToGameType() {
        dismiss(animated: true)
        viewModel.delegate.favoritesToGameType(favorites: viewModel.favorites)
    }
    
    @objc private func closeDetails() {
        viewModel.buttonOnOff(button: buttonClose, isOn: true)
        viewModel.hideAnimationView(viewDetails, buttonDelete, and: visualEffectBlur)
    }
    
    @objc private func deleteFavorite() {
        closeDetails()
        viewModel.deleteRow(tableView: tableView)
        guard viewModel.favorites.isEmpty else { return }
        exitToGameType()
        viewModel.delegate.disableFavoriteButton()
    }
    
    @objc private func moreInfo() {
        let detailsViewModel = viewModel.detailsViewController()
        let detailsVC = DetailsViewController()
        detailsVC.viewModel = detailsViewModel
        detailsVC.viewModel.delegate = self
        navigationController?.pushViewController(detailsVC, animated: true)
        viewModel.buttonOnOff(button: buttonClose, isOn: true)
        viewModel.hideAnimationView(viewDetails, buttonDelete, and: visualEffectBlur)
    }
}

extension FavoritesViewController {
    private func setConstraints() {
        viewModel.setSquare(button: buttonClose, sizes: 40)
        
        NSLayoutConstraint.activate([
            visualEffectBlur.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectBlur.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectBlur.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectBlur.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoritesViewController {
    private func setButton(image: String, action: Selector,
                           isBarButton: Bool? = nil) -> UIButton {
        let pointSize: CGFloat = isBarButton ?? false ? 20 : 26
        let size = UIImage.SymbolConfiguration(pointSize: pointSize)
        let image = UIImage(systemName: image, withConfiguration: size)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = isBarButton ?? false ? 1.5 : 0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func setButton() -> UIButton {
        let label = viewModel.setLabel(title: viewModel.titleDetails, font: "GillSans-SemiBold", size: 23, color: .white)
        let image = viewModel.setImage(image: "chevron.right", color: .white, size: 21)
        let button = Button(type: .custom)
        button.backgroundColor = viewModel.backgroundLight
        button.layer.cornerRadius = 15
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(moreInfo), for: .touchUpInside)
        viewModel.setSubviews(subviews: label, image, on: button)
        viewModel.setConstraints(label, and: image, on: button)
        return button
    }
}

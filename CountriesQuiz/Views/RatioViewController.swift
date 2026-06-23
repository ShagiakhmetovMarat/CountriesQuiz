//
//  RatioViewController.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 04.07.2024.
//

import UIKit

class RatioViewController: UIViewController {
    private lazy var buttonClose: UIButton = {
        let size = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "multiply", withConfiguration: size)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelStatistic: UILabel = {
        viewModel.setLabel(
            text: viewModel.title,
            color: .black, size: 26,
            font: "GillSans-SemiBold",
            alignment: .center)
    }()
    
    private lazy var imageCircleCorrect: UIImageView = {
        viewModel.setImage(
            image: "seal.fill",
            size: 50,
            color: .greenEmerald.withAlphaComponent(0.3),
            addImage: imageCorrect)
    }()
    
    private lazy var imageCorrect: UIImageView = {
        viewModel.setImage(image: "checkmark", size: 25, color: .greenEmerald)
    }()
    
    private lazy var labelCorrect: UILabel = {
        viewModel.setLabel(
            text: viewModel.titleCorrect,
            color: .greenEmerald,
            size: 19.5,
            font: "GillSans",
            alignment: .left)
    }()
    
    private lazy var labelCorrectCount: UILabel = {
        viewModel.setLabel(
            text: viewModel.dataCorrect,
            color: .greenEmerald,
            size: 20,
            font: "GillSans-SemiBold",
            alignment: .right)
    }()
    
    private lazy var progressViewCorrect: UIProgressView = {
        viewModel.setProgressView(color: .greenEmerald, value: viewModel.progressCorrect)
    }()
    
    private lazy var imageCircleIncorrect: UIImageView = {
        viewModel.setImage(
            image: "seal.fill",
            size: 50,
            color: .bismarkFuriozo.withAlphaComponent(0.3),
            addImage: imageIncorrect)
    }()
    
    private lazy var imageIncorrect: UIImageView = {
        viewModel.setImage(image: "multiply", size: 25, color: .bismarkFuriozo)
    }()
    
    private lazy var labelIncorrect: UILabel = {
        viewModel.setLabel(
            text: viewModel.titleIncorrect,
            color: .bismarkFuriozo,
            size: 19.5,
            font: "GillSans",
            alignment: .left)
    }()
    
    private lazy var labelIncorrectCount: UILabel = {
        viewModel.setLabel(
            text: viewModel.dataIncorrect,
            color: .bismarkFuriozo,
            size: 20,
            font: "GillSans-SemiBold",
            alignment: .right)
    }()
    
    private lazy var progressViewIncorrect: UIProgressView = {
        viewModel.setProgressView(color: .bismarkFuriozo, value: viewModel.progressIncorrect)
    }()
    
    private lazy var imageCircleTimeSpend: UIImageView = {
        viewModel.setImage(
            image: "seal.fill",
            size: 50,
            color: .blueMiddlePersian.withAlphaComponent(0.3),
            addImage: imageTimeSpend)
    }()
    
    private lazy var imageTimeSpend: UIImageView = {
        viewModel.setImage(image: viewModel.imageTimeSpend, size: 25, color: .blueMiddlePersian)
    }()
    
    private lazy var labelTimeSpend: UILabel = {
        viewModel.setLabel(
            text: viewModel.titleTimeSpend,
            color: .blueMiddlePersian,
            size: 19.5,
            font: "GillSans",
            alignment: .left)
    }()
    
    private lazy var labelTimeSpendCount: UILabel = {
        viewModel.setLabel(
            text: viewModel.dataTimeSpend,
            color: .blueMiddlePersian,
            size: 20,
            font: "GillSans-SemiBold",
            alignment: .right)
    }()
    
    private lazy var progressViewTimeSpend: UIProgressView = {
        viewModel.setProgressView(color: .blueMiddlePersian, value: viewModel.progressTimeSpend)
    }()
    
    private lazy var imageCircleAnswered: UIImageView = {
        viewModel.setImage(
            image: "seal.fill",
            size: 50,
            color: .gummigut.withAlphaComponent(0.3),
            addImage: imageAnswered)
    }()
    
    private lazy var imageAnswered: UIImageView = {
        viewModel.setImage(image: "questionmark.bubble", size: 25, color: .gummigut)
    }()
    
    private lazy var labelAnswered: UILabel = {
        viewModel.setLabel(
            text: viewModel.titleAnswered,
            color: .gummigut,
            size: 19.5,
            font: "GillSans",
            alignment: .left)
    }()
    
    private lazy var labelAnsweredCount: UILabel = {
        viewModel.setLabel(
            text: viewModel.dataAnswered,
            color: .gummigut,
            size: 20,
            font: "GillSans-SemiBold",
            alignment: .right)
    }()
    
    private lazy var progressViewAnswered: UIProgressView = {
        viewModel.setProgressView(color: .gummigut, value: viewModel.progressAnswered)
    }()
    
    private lazy var imageInfinity: UIImageView = {
        viewModel.setImage(image: "infinity", size: 20, color: .blueMiddlePersian)
    }()
    
    private lazy var buttonDone: UIButton = {
        let button = Button(type: .system)
        button.setTitle(viewModel.titleDone, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans-SemiBold", size: 25)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 0, height: 6)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    var viewModel: RatioViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        setSubviews()
        setBarButton()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        viewModel.setCircles(labelStatistic, view)
        viewModel.setProgressCircles(labelStatistic, view)
    }
    
    private func setDesign() {
        view.backgroundColor = .white
        imageInfinity.isHidden = viewModel.isTime ? true : false
    }
    
    private func setSubviews() {
        viewModel.setSubviews(subviews: labelStatistic, imageCircleCorrect,
                                labelCorrect, labelCorrectCount, progressViewCorrect,
                                imageCircleIncorrect, labelIncorrect, labelIncorrectCount,
                                progressViewIncorrect, imageCircleTimeSpend,
                                labelTimeSpend, labelTimeSpendCount,
                                progressViewTimeSpend, imageCircleAnswered, labelAnswered,
                                labelAnsweredCount, progressViewAnswered, 
                                buttonDone, imageInfinity, on: view)
    }
    
    private func setBarButton() {
        viewModel.setBarButton(buttonClose, navigationItem)
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
}
// MARK: - Set constraints
extension RatioViewController {
    private func setConstraints() {
        viewModel.setSquare(subview: buttonClose, sizes: 40)
        
        NSLayoutConstraint.activate([
            labelStatistic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            labelStatistic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelStatistic.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        viewModel.setupCenterSubview(imageCorrect, on: imageCircleCorrect)
        viewModel.constraints(image: imageCircleCorrect, layout: labelStatistic.bottomAnchor,
                              constant: 260, title: labelCorrect, count: labelCorrectCount,
                              progressView: progressViewCorrect, view: view)
        viewModel.setupCenterSubview(imageIncorrect, on: imageCircleIncorrect)
        viewModel.constraints(image: imageCircleIncorrect, layout: imageCircleCorrect.bottomAnchor,
                              constant: 12.5, title: labelIncorrect, count: labelIncorrectCount,
                              progressView: progressViewIncorrect, view: view)
        viewModel.setupCenterSubview(imageTimeSpend, on: imageCircleTimeSpend)
        viewModel.constraints(image: imageCircleTimeSpend, layout: imageCircleIncorrect.bottomAnchor,
                              constant: 12.5, title: labelTimeSpend, count: labelTimeSpendCount,
                              progressView: progressViewTimeSpend, view: view)
        viewModel.setupCenterSubview(imageAnswered, on: imageCircleAnswered)
        viewModel.constraints(image: imageCircleAnswered, layout: imageCircleTimeSpend.bottomAnchor,
                              constant: 12.5, title: labelAnswered, count: labelAnsweredCount,
                              progressView: progressViewAnswered, view: view)
        
        viewModel.setInsteadSubview(imageInfinity, on: labelTimeSpendCount)
        
        NSLayoutConstraint.activate([
            buttonDone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonDone.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            buttonDone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonDone.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

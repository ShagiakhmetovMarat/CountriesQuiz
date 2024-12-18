//
//  TimeViewController.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 16.10.2024.
//

import UIKit

class TimeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private lazy var buttonBack: UIButton = {
        let size = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "arrow.left", withConfiguration: size)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backToSetting), for: .touchUpInside)
        return button
    }()
    
    private lazy var image: UIImageView = {
        let size = UIImage.SymbolConfiguration(pointSize: 55)
        let image = UIImage(systemName: "timer", withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelTitle: UILabel = {
        viewModel.setLabel(text: viewModel.title, color: .white, font: "GillSans-Bold", size: 21)
    }()
    
    private lazy var labelDescription: UILabel = {
        viewModel.setLabel(text: viewModel.description, color: .white, font: "GillSans", size: 20)
    }()
    
    private lazy var labelTurnOnOff: UILabel = {
        viewModel.setLabel(text: viewModel.titleTimer, color: .blueMiddlePersian, font: "GillSans", size: 24)
    }()
    
    private lazy var switchToggle: UISwitch = {
        let switchOn = UISwitch()
        switchOn.isOn = viewModel.isOn
        switchOn.onTintColor = .blueMiddlePersian
        switchOn.tintColor = .grayLight
        switchOn.layer.cornerRadius = switchOn.frame.height / 2
        switchOn.backgroundColor = .grayLight
        switchOn.clipsToBounds = true
        switchOn.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        switchOn.translatesAutoresizingMaskIntoConstraints = false
        return switchOn
    }()
    
    private lazy var viewToggle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        viewModel.setSubviews(subviews: labelTurnOnOff, switchToggle, on: view)
        viewModel.setConstraints(labelTurnOnOff, switchToggle, on: view)
        return view
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: viewModel.items)
        segment.backgroundColor = viewModel.colorSelected
        segment.selectedSegmentTintColor = viewModel.colorNormal
        segment.setTitleTextAttributes([
            NSAttributedString.Key
                .font: viewModel.font ?? "",
            .foregroundColor: viewModel.colorSelected
        ], for: .selected)
        segment.setTitleTextAttributes([
            NSAttributedString.Key
                .font: viewModel.font ?? "",
            .foregroundColor: viewModel.colorNormal
        ], for: .normal)
        segment.selectedSegmentIndex = viewModel.segmentIndex
        segment.isUserInteractionEnabled = viewModel.isTime
        segment.layer.borderWidth = 5
        segment.layer.borderColor = viewModel.colorSelected.cgColor
        segment.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private lazy var pickerViewOne: UIPickerView = {
        setPickerView(tag: 1)
    }()
    
    private lazy var pickerViewTwo: UIPickerView = {
        setPickerView(tag: 2)
    }()
    
    private lazy var stackViewPickerViews: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pickerViewOne, pickerViewTwo])
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [segmentedControl, stackViewPickerViews])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var viewModel: TimeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        setBarButton()
        setSubviews()
        setConstraints()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfRows(pickerView)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        viewModel.setTitles(pickerView: pickerView, row, and: segmentedControl)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        viewModel.heightOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.setTimeFromRow(pickerView: pickerView, and: row)
    }
    
    private func setDesign() {
        view.backgroundColor = .blueMiddlePersian
        navigationItem.hidesBackButton = true
    }
    
    private func setBarButton() {
        viewModel.setBarButton(button: buttonBack, navigationItem: navigationItem)
    }
    
    private func setSubviews() {
        viewModel.setSubviews(subviews: image, labelTitle, labelDescription,
                              viewToggle, stackView, on: view)
    }
    
    @objc private func backToSetting() {
        viewModel.delegate.dataToSetting(mode: viewModel.mode)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func switchAction() {
        viewModel.switchToggle(segment: segmentedControl)
    }
    
    @objc private func segmentAction() {
        viewModel.segmentSelect(segment: segmentedControl)
    }
}

extension TimeViewController {
    private func setPickerView(tag: Int) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = viewModel.backgroundColor(tag)
        pickerView.layer.cornerRadius = 13
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.tag = tag
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isUserInteractionEnabled = viewModel.isEnabled(tag)
        pickerView.selectRow(viewModel.setRow(tag), inComponent: 0, animated: false)
        viewModel.setPickerView(pickerView)
        return pickerView
    }
}

extension TimeViewController {
    private func setConstraints() {
        viewModel.setSquare(subview: buttonBack, sizes: 40)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            viewToggle.heightAnchor.constraint(equalToConstant: 50),
            viewToggle.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 20),
            viewToggle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: viewToggle.bottomAnchor, constant: 15),
            stackView.heightAnchor.constraint(equalToConstant: 270),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

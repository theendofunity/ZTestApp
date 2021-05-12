//
//  EmployeeViewController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 11.05.2021.
//

import UIKit

class EmployeeViewController: UIViewController {

    // MARK: - Properties

    let type: DetailedViewType
    let viewModel: EmployeeDetailedViewViewModelType?

//    let employeeType = UISegmentedControl()
//    let name = UILabel()
//    let sallary = UILabel()
    let timeBegin = UIDatePicker()
    let timeEnd = UIDatePicker()
//    let name = UILabel()
//    let name = UILabel()

    // MARK: - Initializers

    init(viewModel: EmployeeDetailedViewViewModelType?, type: DetailedViewType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
        setupToolBar()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Live cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - UI setup

    private func setupToolBar() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveButton
    }

    private func setupLayout() {
        view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])

        let employeeType = UISegmentedControl()
        for (num, employeeTitle) in EmployeeType.allCases.enumerated() {
            employeeType.insertSegment(withTitle: "\(employeeTitle)", at: num, animated: true)
        }
        employeeType.selectedSegmentIndex = 0
        employeeType.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(employeeType)

        let name = UITextField()
        name.placeholder = "Name"
        stackView.addArrangedSubview(name)

        let sallary = UITextField()
        sallary.placeholder = "Sallary"
        stackView.addArrangedSubview(sallary)

        stackView.addArrangedSubview(timeBegin)
        stackView.addArrangedSubview(timeEnd)

        let workspaceNumber = UITextField()
        workspaceNumber.placeholder = "Workspace number"
        stackView.addArrangedSubview(workspaceNumber)

        let bookkepingType = UISegmentedControl(items: ["first", "second"])
        stackView.addArrangedSubview(bookkepingType)
    }

    // MARK: - Private functions

    @objc private func save() {

    }
}

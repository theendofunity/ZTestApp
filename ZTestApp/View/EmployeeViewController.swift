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

    let employeeType = UISegmentedControl()
    let name = UITextField()
    let sallary = UITextField()
    let beginLabel = UILabel()
    let timeBegin = UIDatePicker()
    let endLabel = UILabel()
    let timeEnd = UIDatePicker()
    let workspaceNumber = UITextField()
    let bookkepingType = UISegmentedControl()
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
        setTitle()

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
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 10

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])

        for (num, employeeTitle) in EmployeeType.allCases.enumerated() {
            employeeType.insertSegment(withTitle: "\(employeeTitle)", at: num, animated: true)
        }
        employeeType.selectedSegmentIndex = 0
        employeeType.translatesAutoresizingMaskIntoConstraints = false
        employeeType.addTarget(self, action: #selector(changeView), for: .valueChanged)
        stackView.addArrangedSubview(employeeType)

        name.placeholder = "Name"
        stackView.addArrangedSubview(name)

        sallary.placeholder = "Sallary"
        stackView.addArrangedSubview(sallary)

        beginLabel.text = "Begin"
        stackView.addArrangedSubview(beginLabel)
        stackView.addArrangedSubview(timeBegin)
        endLabel.text = "End"
        stackView.addArrangedSubview(endLabel)
        stackView.addArrangedSubview(timeEnd)

        workspaceNumber.placeholder = "Workspace number"
        stackView.addArrangedSubview(workspaceNumber)

        for (num, bookkeepingTitle) in BookkeepingType.allCases.enumerated() {
            bookkepingType.insertSegment(withTitle: "\(bookkeepingTitle)", at: num, animated: true)
        }
        stackView.addArrangedSubview(bookkepingType)

        changeView()
    }

    // MARK: - Private functions

    @objc private func save() {

    }

    @objc private func changeView() {
        switch employeeType.selectedSegmentIndex {
        case EmployeeType.leader.rawValue:
            beginLabel.text = "Work time"
            workspaceNumber.isHidden = true
            bookkepingType.isHidden = true
        case EmployeeType.bookKeeping.rawValue:
            workspaceNumber.isHidden = false
            bookkepingType.isHidden = false
            beginLabel.text = "Dinner time"
        case EmployeeType.employee.rawValue:
            workspaceNumber.isHidden = false
            bookkepingType.isHidden = true
            beginLabel.text = "Dinner time"
        default:
            return
        }
    }

    private func setTitle() {
        if type == .adding {
            title = "Add new"
        } else {
            title = "Change"
        }
    }
}

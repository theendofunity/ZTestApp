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
    let timeTitle = UILabel()
    let timeStack = UIStackView()
    let timeBegin = UIDatePicker()
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
    }

    // MARK: - UI setup

    private func setupToolBar() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveButton
    }

    private func setupLayout() {    // Разбить на методы!!!!!
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
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        NSLayoutConstraint(item: stackView,
                           attribute: .bottom,
                           relatedBy: .lessThanOrEqual,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: -200).isActive = true
        
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

        stackView.addArrangedSubview(timeTitle)

        timeBegin.datePickerMode = .time
        timeEnd.datePickerMode = .time

        timeStack.axis = .horizontal
        timeStack.addArrangedSubview(timeBegin)
        timeStack.addArrangedSubview(timeEnd)
        stackView.addArrangedSubview(timeStack)

        workspaceNumber.placeholder = "Workspace number"
        stackView.addArrangedSubview(workspaceNumber)

        for (num, bookkeepingTitle) in BookkeepingType.allCases.enumerated() {
            bookkepingType.insertSegment(withTitle: "\(bookkeepingTitle)", at: num, animated: true)
        }
        stackView.addArrangedSubview(bookkepingType)

        for element in stackView.arrangedSubviews {
            element.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }

        changeView()
    }

    // MARK: - Private functions

    @objc private func save() {

    }

    @objc private func changeView() {
        switch employeeType.selectedSegmentIndex {
        case EmployeeType.leader.rawValue:
            timeTitle.text = "Work time"
            workspaceNumber.isHidden = true
            bookkepingType.isHidden = true
        case EmployeeType.bookKeeping.rawValue:
            workspaceNumber.isHidden = false
            bookkepingType.isHidden = false
            timeTitle.text = "Dinner time"
        case EmployeeType.employee.rawValue:
            workspaceNumber.isHidden = false
            bookkepingType.isHidden = true
            timeTitle.text = "Dinner time"
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

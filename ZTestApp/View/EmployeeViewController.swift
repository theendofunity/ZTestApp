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
    let viewModel: DetailedViewViewModel?

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

    init(viewModel: DetailedViewViewModel?, type: DetailedViewType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)

        setupToolBar()
        setupLayout()
        fillView()
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

    private func setupLayout() {
        view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        view.addSubview(stackView)

        setupUiElements()

        stackView.addArrangedSubview(employeeType)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(sallary)
        stackView.addArrangedSubview(timeTitle)

        timeStack.axis = .horizontal
        timeStack.addArrangedSubview(timeBegin)
        timeStack.addArrangedSubview(timeEnd)
        stackView.addArrangedSubview(timeStack)
        stackView.addArrangedSubview(workspaceNumber)
        stackView.addArrangedSubview(bookkepingType)
        setupStackViewConstraints(for: stackView)

        changeView()
    }

    private func setupUiElements() {
        for (num, employeeTitle) in EmployeeType.allCases.enumerated() {
            employeeType.insertSegment(withTitle: "\(employeeTitle)", at: num, animated: true)
        }
        employeeType.selectedSegmentIndex = viewModel?.employeeType.rawValue ?? 0

        employeeType.addTarget(self, action: #selector(changeView), for: .valueChanged)

        for (num, bookkeepingTitle) in BookkeepingType.allCases.enumerated() {
            bookkepingType.insertSegment(withTitle: "\(bookkeepingTitle)", at: num, animated: true)
        }

        bookkepingType.selectedSegmentIndex = 0

        name.placeholder = "Name"
        sallary.placeholder = "Sallary"
        workspaceNumber.placeholder = "Workspace number"

        timeBegin.datePickerMode = .time
        timeEnd.datePickerMode = .time
    }

    private func setupStackViewConstraints(for stackView: UIStackView) {
        for element in stackView.arrangedSubviews {
            element.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        NSLayoutConstraint(item: stackView,
                           attribute: .bottom,
                           relatedBy: .lessThanOrEqual,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -50).isActive = true

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

    private func fillView() {
        guard let viewModel = viewModel else { return }

        switch viewModel.employeeType {
        case .leader:
            guard let leader = viewModel.employeeData as? Leader else { return }
            name.text = leader.name
            sallary.text = "\(leader.sallary)"
            timeBegin.date = leader.businessHours?.begin ?? Date()
            timeEnd.date = leader.businessHours?.end ?? Date()
        case .bookKeeping:
            guard let bookkeeping = viewModel.employeeData as? Bookkeeping else { return }
            name.text = bookkeeping.name
            sallary.text = "\(bookkeeping.sallary)"
            timeBegin.date = bookkeeping.employeeInfo?.dinnerTime?.begin ?? Date()
            timeEnd.date = bookkeeping.employeeInfo?.dinnerTime?.end ?? Date()
            workspaceNumber.text = "\(String(describing: bookkeeping.employeeInfo?.workplaceNumber))"
            bookkepingType.selectedSegmentIndex = Int(bookkeeping.type)
        case .employee:
            guard let employee = viewModel.employeeData as? Employee else { return }
            name.text = employee.name
            sallary.text = "\(employee.sallary)"
            timeBegin.date = employee.employeeInfo?.dinnerTime?.begin ?? Date()
            timeEnd.date = employee.employeeInfo?.dinnerTime?.end ?? Date()
            workspaceNumber.text = "\(String(describing: employee.employeeInfo?.workplaceNumber))"
        }
    }
}

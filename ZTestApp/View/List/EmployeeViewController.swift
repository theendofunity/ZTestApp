//
//  EmployeeViewController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 11.05.2021.
//

import UIKit

class EmployeeViewController: UIViewController {

    // MARK: - Properties

    let viewType: DetailedViewType
    var viewModel: DetailedViewViewModel?

    let employeeType = UISegmentedControl()
    let name = TextFieldWithTitle()
    let sallary = TextFieldWithTitle()
    let timeTitle = UILabel()
    let timeStack = UIStackView()
    let timeBegin = UIDatePicker()
    let timeEnd = UIDatePicker()
    let workspaceNumber = TextFieldWithTitle()
    let bookkepingType = UISegmentedControl()

    // MARK: - Initializers

    init(viewModel: DetailedViewViewModel?, type: DetailedViewType) {
        self.viewModel = viewModel
        self.viewType = type
        super.init(nibName: nil, bundle: nil)

        setupToolBar()
        setupLayout()
        fillView()
        changeSaveButtonState()
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
        let timeLabel = UILabel()
        timeLabel.text = "-"
        timeLabel.font = timeLabel.font.withSize(20)
        timeStack.addArrangedSubview(timeLabel)
        timeStack.addArrangedSubview(timeEnd)
        timeStack.spacing = 5
        stackView.addArrangedSubview(timeStack)
        stackView.addArrangedSubview(workspaceNumber)
        stackView.addArrangedSubview(bookkepingType)
        setupStackViewConstraints(for: stackView)

        changeView()
    }

    private func setupUiElements() {
        for (num, employeeTitle) in EmployeeType.allCases.enumerated() {
            let title = "\(employeeTitle)".capitalizingFirstLetter()
            let localizedTitle = NSLocalizedString(title, comment: "")
            employeeType.insertSegment(withTitle: localizedTitle, at: num, animated: true)
        }
        employeeType.selectedSegmentIndex = viewModel?.employeeType.rawValue ?? 0

        employeeType.addTarget(self, action: #selector(changeView), for: .valueChanged)

        for (num, bookkeepingTitle) in BookkeepingType.allCases.enumerated() {
            let title = "\(bookkeepingTitle)".capitalizingFirstLetter()
            let localizedTitle = NSLocalizedString(title, comment: "")
            bookkepingType.insertSegment(withTitle: localizedTitle, at: num, animated: true)
        }

        bookkepingType.selectedSegmentIndex = 0

        name.title = "Name"
        name.textField.addTarget(self, action: #selector(changeSaveButtonState), for: .editingDidBegin)
        sallary.title = "Sallary"
        sallary.textField.addTarget(self, action: #selector(changeSaveButtonState), for: .editingDidBegin)
        workspaceNumber.title = "Workplace number"
        workspaceNumber.textField.addTarget(self, action: #selector(changeSaveButtonState), for: .editingDidBegin)

        timeBegin.datePickerMode = .time
        timeEnd.datePickerMode = .time
    }

    private func setupStackViewConstraints(for stackView: UIStackView) {
        for element in stackView.arrangedSubviews {
            element.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        guard let viewModel = viewModel else { return }

        guard let type = EmployeeType(rawValue: employeeType.selectedSegmentIndex) else { return }

        if viewType == .adding {
            viewModel.createObject(employeeType: type)
        } else if viewType == .changing {
            if type != viewModel.employeeType {
                viewModel.changeType(type: type)
            }
        }

        viewModel.setName(name: name.text)
        viewModel.setSallary(sallary: sallary.text)
        viewModel.setTime(begin: timeBegin.date, end: timeEnd.date)

        if type == .bookkeepings {
            viewModel.setBookkeeperType(type: bookkepingType.selectedSegmentIndex)
        }
        if type == .bookkeepings || type == .employees {
            viewModel.setWorkplaceNumber(number: workspaceNumber.text)
        }

        viewModel.update()
        navigationController?.popViewController(animated: true)
    }

    @objc private func changeView() {
        switch employeeType.selectedSegmentIndex {
        case EmployeeType.leaders.rawValue:
            timeTitle.text = NSLocalizedString("Work time", comment: "")
            workspaceNumber.isHidden = true
            bookkepingType.isHidden = true
        case EmployeeType.bookkeepings.rawValue:
            workspaceNumber.isHidden = false
            bookkepingType.isHidden = false
            timeTitle.text = NSLocalizedString("Dinner time", comment: "")
        case EmployeeType.employees.rawValue:
            workspaceNumber.isHidden = false
            bookkepingType.isHidden = true
            timeTitle.text = NSLocalizedString("Dinner time", comment: "")
        default:
            return
        }
    }

    @objc private func changeSaveButtonState() {
        navigationItem.rightBarButtonItem?.isEnabled = false

        guard let type = EmployeeType(rawValue: employeeType.selectedSegmentIndex) else { return }

        if name.isEmpty() || sallary.isEmpty() {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else if type == .bookkeepings || type == .employees {
            if !workspaceNumber.isEmpty() {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

private func setTitle() {
    if viewType == .adding {
        title = NSLocalizedString("Add new", comment: "")
    } else {
        title = NSLocalizedString("Change", comment: "")
    }
}

private func fillView() {
    guard let viewModel = viewModel else { return }

    if viewModel.employeeData != nil {
        name.text = viewModel.name()
        sallary.text = viewModel.sallary()
        workspaceNumber.text = viewModel.workplaceNumber()
        bookkepingType.selectedSegmentIndex = viewModel.bookkeepingType() ?? 0
        let time = viewModel.time()
        timeBegin.date = time.0 ?? Date()
        timeEnd.date = time.1 ?? Date()
    }
}
}

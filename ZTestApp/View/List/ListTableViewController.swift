//
//  ListTableViewController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit

class ListTableViewController: UITableViewController {

    // MARK: - Properties
    var viewModel: ListViewModel

    // MARK: - Initialisers

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
        loadViewIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

        setupNavigationBar()

        tableView.register(LeadersTableViewCell.self, forCellReuseIdentifier: LeadersTableViewCell.cellIdentifier)
        tableView.register(BookkeepingTableViewCell.self,
                           forCellReuseIdentifier: BookkeepingTableViewCell.cellIdentifier)
        tableView.register(EmployeesTableViewCell.self, forCellReuseIdentifier: EmployeesTableViewCell.cellIdentifier)
    }

    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numbersOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRowsInSection(section: section)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModel(for: indexPath)

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LeadersTableViewCell.cellIdentifier,
                                                           for: indexPath) as? LeadersTableViewCell else {
                fatalError()
            }
            cell.viewModel = (cellViewModel as? LeaderCellViewModel)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookkeepingTableViewCell.cellIdentifier,
                                                           for: indexPath) as? BookkeepingTableViewCell else {
                fatalError()
            }
            cell.viewModel = (cellViewModel as? BookkeepingCellViewModel)
            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.cellIdentifier,
                                                           for: indexPath) as? EmployeesTableViewCell else {
                fatalError()
            }
            cell.viewModel = (cellViewModel as? EmployeeCellViewModel)
            return cell

        default:
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCell(for: indexPath)

        let detailedViewModel = viewModel.detailedViewViewModel() as? DetailedViewViewModel
        detailedViewModel?.savingCompletion = { [weak self] (object, type, isDataCreated) in
            if isDataCreated {
                self?.viewModel.save(object: object, type: type)
            }
            self?.tableView.reloadData()
        }
        let detailedView = EmployeeViewController(viewModel: detailedViewModel, type: .changing)
        navigationController?.pushViewController(detailedView, animated: true)
    }

// MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
                            -> UISwipeActionsConfiguration? {
        let deleteTitle = NSLocalizedString("Delete", comment: "")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteTitle) { _, _, _ in
            self.viewModel.remove(from: indexPath)
            self.tableView.reloadData()
        }
        let action = UISwipeActionsConfiguration(actions: [deleteAction])
        return action
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        viewModel.move(from: sourceIndexPath, to: destinationIndexPath)
    }

    override func tableView(_ tableView: UITableView,
                            targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                            toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return sourceIndexPath.section  == proposedDestinationIndexPath.section
            ? proposedDestinationIndexPath
            : sourceIndexPath
    }

// MARK: - UI configuration

    private func setupNavigationBar() {
        title = NSLocalizedString("List", comment: "")

        let sortButton = UIBarButtonItem(image: #imageLiteral(resourceName: "sort"), style: .plain, target: self, action: #selector(sort))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEmployee))

        navigationItem.rightBarButtonItems = [addButton, sortButton]
        navigationItem.leftBarButtonItem = editButtonItem
    }

    @objc private func addEmployee() {
        let detailedViewModel = DetailedViewViewModel(employeeType: .leaders, data: nil)
        detailedViewModel?.savingCompletion = { [weak self] object, type, isDataCreated in
            print(isDataCreated)
            if isDataCreated {
                self?.viewModel.save(object: object, type: type)
            }
            self?.tableView.reloadData()
        }
        let detailedView = EmployeeViewController(viewModel: detailedViewModel, type: .adding)
        navigationController?.pushViewController(detailedView, animated: true)
    }

    @objc private func sort() {
        viewModel.sort()
        tableView.reloadData()
        if viewModel.sorting == .byName {
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
}

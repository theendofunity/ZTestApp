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

        navigationController?.title = "List"

        tableView.register(LeadersTableViewCell.self, forCellReuseIdentifier: LeadersTableViewCell.cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numbersOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRowsInSection(section: section)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section: section)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModel(for: indexPath)

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LeadersTableViewCell.cellIdentifier,
                                                           for: indexPath) as? LeadersTableViewCell else {
                fatalError()
            }
            cell.viewModel = cellViewModel

        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }

    // MARK: - UI configuration
}

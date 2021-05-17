//
//  ServiceViewController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit

class ServiceViewController: UITableViewController {

    // MARK: - Properties
    var viewModel: ServiceViewViewModel

    // MARK: - Initialisers

    init(viewModel: ServiceViewViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
        loadViewIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: ServiceTableViewCell.cellIdentifier)

        viewModel.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.cellIdentifier,
                                                       for: indexPath) as? ServiceTableViewCell
        else {
            return UITableViewCell()
        }

        cell.viewModel = cellViewModel
        return cell
    }
}

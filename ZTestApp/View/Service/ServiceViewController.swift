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
    let activityIndicator = UIActivityIndicatorView()

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

        setupActivityIndicator()

    }

    override func viewDidAppear(_ animated: Bool) {
        if viewModel.quotes.count == 0 {
            viewModel.fetchData {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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

    private func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        activityIndicator.startAnimating()
    }
}

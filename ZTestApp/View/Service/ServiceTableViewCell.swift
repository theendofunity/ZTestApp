//
//  ServiceTableViewCell.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 17.05.2021.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

// MARK: - Properties
    static let cellIdentifier = "ServiceCellIdentifier"

    let idLabel = UILabel()

    var viewModel: ServiceCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            idLabel.text = viewModel.quoteId()
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - UI setup
    private func setupLayout() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(idLabel)

        NSLayoutConstraint.activate([
            idLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            idLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            idLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

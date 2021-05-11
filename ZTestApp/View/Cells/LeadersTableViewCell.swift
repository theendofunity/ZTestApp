//
//  LeadersTableViewCell.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import UIKit

class LeadersTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let cellIdentifier = "LeadersTableViewCell"

    var viewModel: ListCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                print("nil model")
                return
            }
            guard let leader = viewModel.data() as? Leader else { return }
            nameLabel.text = leader.name
        }
    }

    let nameLabel = UILabel()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Ui setup

    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            nameLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func update() {
        guard let leader = viewModel?.data() as? Leader else { return }
        nameLabel.text = leader.name
    }
}

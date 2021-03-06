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
    let timeLabel = UILabel()
    let ratingLabel = UILabel()
    let descriptionLabel = UILabel()

    var viewModel: ServiceCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            idLabel.text = "ID: \(viewModel.quoteId())"
            let time = NSLocalizedString("Time", comment: "")
            timeLabel.text = time + ": " + "\(viewModel.time())"
            let rating = NSLocalizedString("Rating", comment: "")
            ratingLabel.text = rating + ": " + "\(viewModel.rating())"

            descriptionLabel.attributedText = htmlAttributeString(from: viewModel.description())
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
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor

        let stackView = UIStackView(arrangedSubviews: [idLabel, ratingLabel, timeLabel, descriptionLabel])
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5

        idLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0

        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        NSLayoutConstraint(item: stackView,
                           attribute: .bottom,
                           relatedBy: .lessThanOrEqual,
                           toItem: contentView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -8).isActive = true
    }
}

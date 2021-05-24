//
//  EmployeeBaseTableViewCell.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 13.05.2021.
//

import UIKit

class EmployeeBaseTableViewCell: UITableViewCell {

// MARK: - Properties

    let mainStack = UIStackView()

    let photo =  UIImageView()
    let name = UILabel()
    let sallary = UILabel()
    let timeTitle = UILabel()
    let time = UILabel()

// MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI setup

     func setupLayout() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        mainStack.axis = .vertical
        mainStack.spacing = 5
        mainStack.distribution = .fillEqually

        photo.image = UIImage(named: "person")
        let titleStack = UIStackView(arrangedSubviews: [photo, name])
        titleStack.axis = .horizontal
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 30).isActive = true
        mainStack.addArrangedSubview(titleStack)

        let timeStack = UIStackView(arrangedSubviews: [timeTitle, time])
        timeStack.axis = .horizontal
        timeStack.spacing = 5
        mainStack.addArrangedSubview(timeStack)

        setupConstraits()
    }

    private func setupConstraits() {
        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }

}

//
//  LeadersTableViewCell.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import UIKit

class LeadersTableViewCell: EmployeeBaseTableViewCell {

    // MARK: - Properties
    static let cellIdentifier = "LeadersTableViewCell"

    var viewModel: LeaderCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            name.text = viewModel.name()
            let sallaryTitle = NSLocalizedString("Sallary", comment: "")
            sallary.text = sallaryTitle + ": " + (viewModel.sallary() ?? "")
            time.text = NSLocalizedString("Work time", comment: "") + ": " + "\(viewModel.workTime() ?? "")"
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Ui setup
}

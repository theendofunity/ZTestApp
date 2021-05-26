//
//  EmployeesTableViewCell.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import UIKit

class EmployeesTableViewCell: EmployeeBaseTableViewCell {
    // MARK: - Properties
    static let cellIdentifier = "EmployeeTableViewCell"

    var viewModel: EmployeeCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            name.text = viewModel.name()
            let sallaryTitle = NSLocalizedString("Sallary", comment: "")
            sallary.text = sallaryTitle + ": " + "\(viewModel.sallary() ?? "")"
            time.text = NSLocalizedString("Dinner time", comment: "") + ": " + "\(viewModel.dinnerTime() ?? "")"
            time.text = viewModel.dinnerTime()
            let workplaceTitle = NSLocalizedString("Workplace number", comment: "")
            workSpaceNumber.text = workplaceTitle + ": " + "\(viewModel.workplaceNumber() ?? "")"
        }
    }
    let workSpaceNumber = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - UI setup
    override func setupLayout() {
        super.setupLayout()

        super.mainStack.addArrangedSubview(workSpaceNumber)
    }
}

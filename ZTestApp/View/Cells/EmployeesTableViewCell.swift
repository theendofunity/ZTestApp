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

        let emptyLabel = UILabel()
        emptyLabel.text = ""
        let employeeInfoStack = UIStackView(arrangedSubviews: [workSpaceNumber, emptyLabel])
        workSpaceNumber.text = "28"
        super.mainStack.addArrangedSubview(employeeInfoStack)
    }
}

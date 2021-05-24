//
//  BookkeepingTableViewCell.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import UIKit

class BookkeepingTableViewCell: EmployeeBaseTableViewCell {

    // MARK: - Properties
    static let cellIdentifier = "BookkeepingTableViewCell"

    var viewModel: BookkeepingCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            name.text = viewModel.name()
            sallary.text = "Sallary \(viewModel.sallary() ?? "")"
            timeTitle.text = "Dinner time"
            time.text = viewModel.dinnerTime()
            workSpaceNumber.text = "Workplace number: \(viewModel.workplaceNumber() ?? "")"
            bookkeepingType.text = "Type: \(viewModel.type() ?? "")"
        }
    }

    let workSpaceNumber = UILabel()
    let bookkeepingType = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - UI setup
    override func setupLayout() {
        super.setupLayout()

        super.mainStack.addArrangedSubview(workSpaceNumber)
        super.mainStack.addArrangedSubview(bookkeepingType)
    }
}

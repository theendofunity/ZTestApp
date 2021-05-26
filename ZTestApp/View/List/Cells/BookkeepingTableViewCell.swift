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
            let sallaryTitle = NSLocalizedString("Sallary", comment: "")
            sallary.text = sallaryTitle + ": " + "\(viewModel.sallary() ?? "")"
            time.text = NSLocalizedString("Dinner time", comment: "") + ": " + "\(viewModel.dinnerTime() ?? "")"
            let workplaceTitle = NSLocalizedString("Workplace number", comment: "")
            workSpaceNumber.text = workplaceTitle + ": " + "\(viewModel.workplaceNumber() ?? "")"
            let typeTitle = NSLocalizedString("Type", comment: "")
            let typeValue = NSLocalizedString(viewModel.type() ?? "", comment: "")
            bookkeepingType.text = typeTitle + ": " + typeValue
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

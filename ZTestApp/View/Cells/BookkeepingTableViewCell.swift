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

    var viewModel: ListCellViewModel? {
        willSet(viewModel) {
//            guard let viewModel = viewModel else { return }
//            guard let leader = viewModel.data() as? Leader else { return }
//            name.text = leader.name
//            sallary.text = "\(leader.sallary)"
//            timeTitle.text = "Work time"
//
//            let dateFormater = DateFormatter()
//            dateFormater.dateFormat = .none
//            dateFormater.timeStyle = .short
//            let beginTime = dateFormater.string(from: (leader.businessHours?.begin) ?? Date())
//            let endTime = dateFormater.string(from: (leader.businessHours?.end) ?? Date())
//
//            time.text = beginTime + " - " + endTime
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

        let bookkeepingInfoStack = UIStackView(arrangedSubviews: [workSpaceNumber, bookkeepingType])
        bookkeepingInfoStack.axis = .vertical
        bookkeepingInfoStack.spacing = 5
        workSpaceNumber.text = "45"
        bookkeepingType.text = "payroll"
        super.mainStack.addArrangedSubview(bookkeepingInfoStack)
    }
}

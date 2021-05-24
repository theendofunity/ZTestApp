//
//  ListViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import UIKit
import RealmSwift

class ListViewModel {

    // MARK: - Properties

    var company = Company()

    var selectedCell: IndexPath?

    // MARK: - Initializers

    init() {
        company = RealmManager.load()
    }

    // MARK: - Table view controller data

    func numbersOfRowsInSection(section: Int) -> Int {
        var numberOfRows = 0

        switch section {
        case 0:
            numberOfRows = company.leaders.count
        case 1:
            numberOfRows = company.bookkeepings.count
        case 2:
            numberOfRows = company.employees.count
        default:
            return 0
        }

        return numberOfRows
    }

    func numbersOfSections() -> Int {
        return 3
    }

    func titleForSection(section: Int) -> String? {
        switch section {
        case 0:
            return "Leaders"
        case 1:
            return "Bookkeepings"
        case 2:
            return "Employees"
        default:
            return nil
        }
    }

    func cellViewModel(for indexPath: IndexPath) -> ListCellViewModelType? {

        switch indexPath.section {
        case 0:
            let leader = company.leaders[indexPath.row]
            return LeaderCellViewModel(leader: leader)
        case 1:
            let bookkeeping = company.bookkeepings[indexPath.row]
            return BookkeepingCellViewModel(bookkeeping: bookkeeping)
        case 2:
            let employee = company.employees[indexPath.row]
            return EmployeeCellViewModel(employee: employee)
        default:
            return nil
        }
    }

    func selectCell(for indexPath: IndexPath) {
        selectedCell = indexPath
    }

    func detailedViewViewModel() -> DetailedViewViewModelType? {
        guard let indexPath = selectedCell else { return nil }

        guard let object = company.object(for: indexPath) else { return nil }
        guard let type = EmployeeType(rawValue: indexPath.section) else { return nil }

        let detailedViewModel = DetailedViewViewModel(employeeType: type, data: object)

        return detailedViewModel
    }

    func remove(from indexPath: IndexPath) {
        guard let object = company.object(for: indexPath) else { return }
        RealmManager.deleteObject(object: object)
    }
}

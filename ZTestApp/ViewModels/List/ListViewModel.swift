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

    var company: Company?

    var selectedCell: IndexPath?

    // MARK: - Initializers

    init() {
        let loadedData = RealmManager.load()
        if loadedData != nil {
            self.company = loadedData!
        } else {
            self.company = Company()
        }
    }

    // MARK: - Table view controller data

    func numbersOfRowsInSection(section: Int) -> Int {
        var numberOfRows = 0

        guard let company = company else { return 0 }

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
            return NSLocalizedString("Leaders", comment: "")
        case 1:
            return NSLocalizedString("Bookkeepings", comment: "")
        case 2:
            return NSLocalizedString("Employees", comment: "")
        default:
            return nil
        }
    }

    func cellViewModel(for indexPath: IndexPath) -> ListCellViewModelType? {

        guard let company = company else { return nil }

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
        guard let company = company else { return nil }
        guard let indexPath = selectedCell else { return nil }

        guard let object = company.object(for: indexPath) else { return nil }
        guard let type = EmployeeType(rawValue: indexPath.section) else { return nil }

        let detailedViewModel = DetailedViewViewModel(employeeType: type, data: object)

        return detailedViewModel
    }

// MARK: - Data base

    func remove(from indexPath: IndexPath) {
        guard let company = company else { return }

        guard let object = company.object(for: indexPath) else { return }
        RealmManager.deleteObject(object: object)
    }

    func save(object: Object?, type: EmployeeType) {
        RealmManager.write {
            switch type {
            case .leaders:
                guard let leader = object as? Leader else { return }
                company?.leaders.append(leader)
            case .bookkeepings:
                guard let bookkeeper = object as? Bookkeeper else { return }
                company?.bookkeepings.append(bookkeeper)
            case .employees:
                guard let employee = object as? Employee else { return }
                company?.employees.append(employee)

            }
        }
    }

    func sort() {
//        company.leaders = company.leaders.sorted(byKeyPath: "baseInfo.name")
//        company.bookkeepings = company.bookkeepings.sorted(byKeyPath: "baseInfo.name")
//        company.employees = company.employees.sorted(byKeyPath: "baseInfo.name")
    }
}

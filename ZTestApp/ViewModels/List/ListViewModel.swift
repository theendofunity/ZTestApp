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
    var sorting = SortTypes.none
    var selectedCell: IndexPath?

    // MARK: - Initializers

    init() {
        guard let data = RealmManager.load() else {
            return }
        self.company = data
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
        let object = company.object(for: indexPath, sorting: sorting)

        switch indexPath.section {
        case 0:
            guard let leader = object as? Leader else { return nil }
            return LeaderCellViewModel(leader: leader)
        case 1:
            guard let bookkeeper = object as? Bookkeeper else { return nil }
            return BookkeepingCellViewModel(bookkeeping: bookkeeper)
        case 2:
            guard let employee = object as? Employee else { return nil }
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

        guard let object = company.object(for: indexPath, sorting: sorting) else { return nil }
        guard let type = EmployeeType(rawValue: indexPath.section) else { return nil }

        let detailedViewModel = DetailedViewViewModel(employeeType: type, data: object)

        return detailedViewModel
    }

// MARK: - Data base

    func remove(from indexPath: IndexPath) {
        guard let object = company.object(for: indexPath, sorting: sorting) else { return }
        RealmManager.deleteObject(object: object)
    }

    func save(object: Object?, type: EmployeeType) {
        RealmManager.write {
            switch type {
            case .leaders:
                guard let leader = object as? Leader else { return }
                company.leaders.append(leader)
            case .bookkeepings:
                guard let bookkeeper = object as? Bookkeeper else { return }
                company.bookkeepings.append(bookkeeper)
            case .employees:
                guard let employee = object as? Employee else { return }
                company.employees.append(employee)
            }
        }
        RealmManager.saveObject(object: company)

    }

    func sort() {
        if sorting == .byName {
            sorting = .none
        } else {
            sorting = .byName
        }
    }

    func move(from source: IndexPath, to destination: IndexPath) {
        switch source.section {
        case 0:
            RealmManager.write {
                company.leaders.move(from: source.row, to: destination.row)
            }
        case 1:
            RealmManager.write {
                company.bookkeepings.move(from: source.row, to: destination.row)
            }
        case 2:
            RealmManager.write {
                company.bookkeepings.move(from: source.row, to: destination.row)
            }
        default:
            return
        }
    }
}

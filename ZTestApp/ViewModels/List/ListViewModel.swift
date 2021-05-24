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

        var detailedViewModel: DetailedViewViewModel?

        switch selectedCell?.section {
        case 0:
            let data = company.leaders[indexPath.row]
            detailedViewModel = DetailedViewViewModel(employeeType: .leader, data: data)
        case 1:
            let data = company.bookkeepings[indexPath.row]
            detailedViewModel = DetailedViewViewModel(employeeType: .bookKeeping, data: data)
        case 2:
            let data = company.employees[indexPath.row]
            detailedViewModel = DetailedViewViewModel(employeeType: .employee, data: data)
        default:
            detailedViewModel = nil
        }

        return detailedViewModel
    }

    func save(data: Object?, type: EmployeeType) {
//        switch type {
//        case .leader:
//            guard let leader = data as? Leader else { return }
//            company.leaders. append(leader)
//        case .bookKeeping:
//            guard let bookkeeper = data as? Bookkeeper else { return }
//            company.bookkeepings.append(bookkeeper)
//        case .employee:
//            guard let employee = data as? Employee else { return }
//            company.employees.append(employee)
//        }
        guard let data = data else { return }
        RealmManager.saveObject(object: data)
    }

    func update(data: Object?, type: EmployeeType, indexPath: IndexPath?) {
//        guard let indexPath = indexPath else { return }
//
//        remove(from: indexPath)
//
//        switch type {
//        case .leader:
//            guard let leader = data as? Leader else { return }
//            if indexPath.row >= company.leaders.count {
//                company.leaders.append(leader)
//            } else {
//                company.leaders.insert(leader, at: indexPath.row)
//            }
//        case .bookKeeping:
//            guard let bookkeeper = data as? Bookkeeper else { return }
//            if indexPath.row >= company.bookkeepings.count {
//                company.bookkeepings.append(bookkeeper)
//            } else {
//                company.bookkeepings.insert(bookkeeper, at: indexPath.row)
//            }
//        case .employee:
//            guard let employee = data as? Employee else { return }
//            if indexPath.row >= company.employees.count {
//                company.employees.append(employee)
//            } else {
//                company.employees.insert(employee, at: indexPath.row)
//            }
//        }
    }

    private func remove(from indexPath: IndexPath) {
//        switch indexPath.section {
//        case 0:
//            company.leaders.remove(at: indexPath.row)
//        case 1:
//            company.bookkeepings.remove(at: indexPath.row)
//        case 2:
//            company.employees.remove(at: indexPath.row)
//        default:
//            return
//        }
    }
}

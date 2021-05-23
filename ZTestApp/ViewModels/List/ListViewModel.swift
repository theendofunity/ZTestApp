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
        company = Company()
//        company = dataManager.load()
    }

// MARK: - Table view controller data

    func numbersOfRowsInSection(section: Int) -> Int {
        var numberOfRows = 0

        guard let company = company else {
            return 0
        }

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
            guard let leader = company?.leaders[indexPath.row] else { return nil }
            return LeaderCellViewModel(leader: leader)
        case 1:
            guard let bookkeeping = company?.bookkeepings[indexPath.row]  else { return nil }
            return BookkeepingCellViewModel(bookkeeping: bookkeeping)
        case 2:
            guard let employee = company?.employees[indexPath.row] else { return nil }
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
            let data = company?.leaders[indexPath.row]
            if let data  = data {
                detailedViewModel = DetailedViewViewModel(employeeType: .leader, data: data)
            }
        case 1:
            let data = company?.bookkeepings[indexPath.row]
            if let data  = data {
                detailedViewModel = DetailedViewViewModel(employeeType: .bookKeeping, data: data)
            }
        case 2:
            let data = company?.employees[indexPath.row]
            if let data  = data {
                detailedViewModel = DetailedViewViewModel(employeeType: .employee, data: data)
            }
        default:
            detailedViewModel = nil
        }

        detailedViewModel?.savingCompletion = { [weak self] (object, type) in
            self?.save(data: object, type: type)
        }
        return detailedViewModel
    }

    func save(data: Object?, type: EmployeeType) {
        switch type {
        case .leader:
            guard let leader = data as? Leader else { return }
            company?.leaders.append(leader)
        case .bookKeeping:
            guard let bookkeeper = data as? Bookkeeper else { return }
            company?.bookkeepings.append(bookkeeper)
        case .employee:
            guard let employee = data as? Employee else { return }
            company?.employees.append(employee)
        }
    }
}

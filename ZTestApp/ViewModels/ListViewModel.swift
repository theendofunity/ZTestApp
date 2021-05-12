//
//  ListViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import UIKit
import CoreData

class ListViewModel {

// MARK: - Properties

    let dataManager = CoreDataManager()

    var company: Company?

    var selectedCell: IndexPath?

// MARK: - Initializers

    init() {
        company = dataManager.load()
    }

// MARK: - Table view controller data

    func numbersOfRowsInSection(section: Int) -> Int {
        var numberOfRows = 0

        guard let company = company else {
            return 0
        }

        switch section {
        case 0:
            numberOfRows = company.leaders?.count ?? 0
        case 1:
            numberOfRows = company.bookkeepings?.count ?? 0
        case 2:
            numberOfRows = company.employees?.count ?? 0
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

    func cellViewModel(for indexPath: IndexPath) -> ListCellViewModel? {
        switch indexPath.section {
        case 0:
            let leader = company?.leaders?.allObjects.first as? NSManagedObject
            let cellViewModel = ListCellViewModel(with: leader)
            return cellViewModel
//        case 1:
//            return "Bookkeepings"
//        case 2:
//            return "Employees"
        default:
            return nil
        }
    }

    func selectCell(for indexPath: IndexPath) {
        selectedCell = indexPath
    }

    func detailedViewViewModel() -> EmployeeDetailedViewViewModelType? {
        guard let indexPath = selectedCell else { return nil }

        switch selectedCell?.section {
        case 0:
            let data = company?.leaders?.allObjects[indexPath.row] as? NSManagedObject
            if let data  = data {
                return EmployeeChangingViewModel(employeeType: .leader, data: data)
            }
        case 1:
                return nil
        case 2:
            return nil
        default:
            return nil
        }
        return nil
    }
}

//
//  ListViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import Foundation

class ListViewModel {

// MARK: - Properties

    var company: Company?

// MARK: - Work with core data

    func save() {

    }

    func load() {

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
}

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

    lazy var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    var company: Company?

// MARK: - Initializers

    init() {
        loadTestData()
    }
// MARK: - Work with core data

    func save() {

    }

    func load() {

    }

    func loadTestData() {
        guard let context = context else {
            return
        }
//        let entity = NSEntityDescription.entity(forEntityName: "Company", in: context)
        let leader = Leader(context: context)
        leader.name = "Leader 1"
        leader.sallary = 1000

        let newCompany = Company(context: context)
        newCompany.leaders = [leader]
        company = newCompany
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
}

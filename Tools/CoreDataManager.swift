//
//  CoreDataManager.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import UIKit
import CoreData

class CoreDataManager {
    // MARK: - Properties

    lazy var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Functions
    func save() {

    }

    func load() -> Company? {
        let company = loadTestData()
        return company
    }

    // MARK: - Private functions

    private func loadTestData() -> Company? {
        guard let context = context else {
            return nil
        }

        let leader = Leader(context: context)
        leader.name = "Leader 1"
        leader.sallary = 1000
        leader.businessHours?.begin = Date()
        leader.businessHours?.end = Date()

        let newCompany = Company(context: context)
        newCompany.leaders = [leader]

        let bookkeeping = Bookkeeping(context: context)
        bookkeeping.sallary = 100
        bookkeeping.name = "Bookkeeping1"
        newCompany.bookkeepings = [bookkeeping]

        let employee = Employee(context: context)
        employee.sallary = 10
        newCompany.employees = [employee]

        return newCompany
    }
}

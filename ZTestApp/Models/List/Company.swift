//
//  Company.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 16.05.2021.
//

import RealmSwift
import UIKit

class Company: Object {
    var leaders = List<Leader>()
    var bookkeepings = List<Bookkeeper>()
    var employees = List<Employee>()

    func object(for indexPath: IndexPath) -> Object? {
        switch indexPath.section {
        case 0:
            return leaders[indexPath.row]
        case 1:
            return bookkeepings[indexPath.row]
        case 2:
            return employees[indexPath.row]
        default:
            return nil
        }
    }

    func sortedLeaders() -> Results<Leader> {
        return leaders.sorted(byKeyPath: SortTypes.byName.rawValue)
    }

    func sortedBookkeepings() -> Results<Bookkeeper> {
        return bookkeepings.sorted(byKeyPath: SortTypes.byName.rawValue)
    }

    func sortedEmployees() -> Results<Employee> {
        return employees.sorted(byKeyPath: SortTypes.byName.rawValue)
    }
}

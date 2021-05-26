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

    func object(for indexPath: IndexPath, sorting: SortTypes) -> Object? {
        switch indexPath.section {
        case 0:
            if sorting == .byName {
                return sortedLeaders()[indexPath.row]
            } else {
                return leaders[indexPath.row]
            }
        case 1:
            if sorting == .byName {
                return sortedBookkeepings()[indexPath.row]
            } else {
                return bookkeepings[indexPath.row]
            }
        case 2:
            if sorting == .byName {
                return sortedEmployees()[indexPath.row]
            } else {
                return employees[indexPath.row]
            }
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

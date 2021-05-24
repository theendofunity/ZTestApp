//
//  RealmManager.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 24.05.2021.
//

import Foundation
import RealmSwift

let realm = try? Realm()

class RealmManager {
    static func save(company: Company) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(company.leaders)
            realm.add(company.employees)
            realm.add(company.leaders)
        }
    }

    static func saveObject<T: Object>(object: T) {
        guard let realm = realm else { return }
        try? realm.write({
            realm.add(object.self)
        })
    }

    static func deleteObject<T: Object>(object: T) {
        guard let realm = realm else { return }
        try? realm.write({
            realm.delete(object)
        })
    }

    static func load() -> Company {
        let company = Company()

        guard let realm = realm else { return company}

        company.leaders = try? realm.objects(Leader.self)
        company.bookkeepings = try? realm.objects(Bookkeeper.self)
        company.employees = try? realm.objects(Employee.self)
        return company
    }
}

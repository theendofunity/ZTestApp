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

    static func write(completion: () -> Void) {
        guard let realm = realm else { return }
        try? realm.write {
            completion()
        }
    }

    static func setName(object: Object, name: String) {
        guard let realm = realm else { return }
        try? realm.write {
            object.setValue(name, forKeyPath: "baseInfo.name")
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

    static func load() -> Company? {
        guard let realm = realm else { return nil}
        let company = try? realm.objects(Company.self)
        return company?.first
    }

    static func loadSorted(sortingType: SortTypes) -> Company? {
        guard let realm = realm else { return nil}
        let company = try? realm.objects(Company.self).sorted(byKeyPath: sortingType.rawValue)
        return company?.first
    }
}

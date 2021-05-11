//
//  ListCellViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 10.05.2021.
//

import Foundation
import CoreData

class ListCellViewModel {
    var object: NSManagedObject?

    init?(with optionalObject: NSManagedObject?) {
        guard let newObject = optionalObject else {
            return
        }
        self.object = newObject
    }

    func data() -> NSManagedObject? {
        return object
    }
}

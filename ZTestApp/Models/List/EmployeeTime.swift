//
//  EmployeeTime.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 22.05.2021.
//

import Foundation
import RealmSwift

class EmployeeTime: Object {
    @objc dynamic var begin = Date()
    @objc dynamic var end = Date()
}

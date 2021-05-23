//
//  Employee.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 22.05.2021.
//

import Foundation
import RealmSwift

class Employee: Object {
    @objc dynamic var baseInfo: BaseInfo!
    @objc dynamic var dinnerTime: EmployeeTime!
    @objc dynamic var workplaceNumber = 0
}

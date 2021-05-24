//
//  Leader.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 22.05.2021.
//

import Foundation
import RealmSwift

class Leader: Object {
    @objc dynamic var baseInfo: BaseInfo!
    @objc dynamic var workTime: EmployeeTime!
}

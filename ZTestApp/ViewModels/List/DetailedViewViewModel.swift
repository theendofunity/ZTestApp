//
//  EmployeeChangingViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 11.05.2021.
//

import Foundation
import CoreData

class DetailedViewViewModel: DetailedViewViewModelType {
    var employeeType: EmployeeType
    var employeeData: NSManagedObject

    init?(employeeType: EmployeeType, data: NSManagedObject) {
        self.employeeType = employeeType
        self.employeeData = data
    }

    func name() -> String? {
        return employeeData.value(forKey: "name") as? String
    }

    func sallary() -> String? {
        guard let sallaryValue = employeeData.value(forKey: "sallary") as? Int64 else { return nil }
        return String(sallaryValue)
    }

    func time() -> (Date?, Date?) {

        var beginTime: Date?
        var endTime: Date?

        switch employeeType {
        case .leader:
            beginTime = employeeData.value(forKeyPath: "businessHours.begin") as? Date
            endTime = employeeData.value(forKeyPath: "businessHours.end") as? Date
        case .bookKeeping, .employee:
            beginTime = employeeData.value(forKeyPath: "employeeInfo.dinnerTime.begin") as? Date
            endTime = employeeData.value(forKeyPath: "employeeInfo.dinnerTime.end") as? Date
        }

       return (beginTime, endTime)
    }

    func workplaceNumber() -> String? {
        if employeeType == .bookKeeping || employeeType == .employee {
            guard let number = employeeData.value(forKeyPath: "employeeInfo.workplaceNumber") as? Int16 else {
                return nil
            }

            return String(number)
        }
        return nil
    }

    func bookkeepingType() -> Int? {
        if employeeType != .bookKeeping {
            return nil
        }

        guard let type = employeeData.value(forKey: "type") as? Int16 else { return nil }

        return Int(type)
    }

    func save() {
        employeeData = NSManagedObject()
    }
}

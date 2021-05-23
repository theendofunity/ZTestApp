//
//  EmployeeChangingViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 11.05.2021.
//

import Foundation
import RealmSwift

class DetailedViewViewModel: DetailedViewViewModelType {
    var employeeType: EmployeeType
    var employeeData: Object?

    var savingCompletion: ((Object?, EmployeeType) -> Void)?

    init?(employeeType: EmployeeType, data: Object?) {
        self.employeeType = employeeType
        self.employeeData = data
    }

    func name() -> String? {
        return employeeData?.value(forKeyPath: "baseInfo.name") as? String
    }

    func sallary() -> String? {
        guard let sallaryValue = employeeData?.value(forKeyPath: "baseInfo.sallary") as? Int else { return nil }
        return String(sallaryValue)
    }

    func time() -> (Date?, Date?) {
        var beginTime: Date?
        var endTime: Date?

        switch employeeType {
        case .leader:
            beginTime = employeeData?.value(forKeyPath: "workTime.begin") as? Date
            endTime = employeeData?.value(forKeyPath: "workTime.end") as? Date
        case .bookKeeping, .employee:
            beginTime = employeeData?.value(forKeyPath: "employeeInfo.dinnerTime.begin") as? Date
            endTime = employeeData?.value(forKeyPath: "employeeInfo.dinnerTime.end") as? Date
        }

       return (beginTime, endTime)
    }

    func workplaceNumber() -> String? {
        if employeeType == .bookKeeping || employeeType == .employee {
            guard let number = employeeData?.value(forKeyPath: "employeeInfo.workplaceNumber") as? Int16 else {
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

        guard let type = employeeData?.value(forKey: "type") as? Int else { return nil }

        return Int(type)
    }

    func setType(employeeType: EmployeeType) {
        self.employeeType = employeeType

        switch employeeType {
        case .leader:
            let data = Leader()
            data.baseInfo = BaseInfo()
            data.workTime = EmployeeTime()
            employeeData = data
        case .bookKeeping:
            let data = Bookkeeper()
            data.baseInfo = BaseInfo()
            data.dinnerTime = EmployeeTime()
            employeeData = data
        case .employee:
            let data = Employee()
            data.baseInfo = BaseInfo()
            data.dinnerTime = EmployeeTime()
            employeeData = data
        }
    }

    func setName(name: String?) {
        employeeData?.setValue(name, forKeyPath: "baseInfo.name")
    }

    func setSallary(sallary: String?) {
        employeeData?.setValue(Int(sallary ?? "0"), forKeyPath: "baseInfo.sallary")
    }

    func setTime(begin: Date?, end: Date?) {
        if employeeType == .leader {
            employeeData?.setValue(begin, forKeyPath: "workTime.begin")
            employeeData?.setValue(end, forKeyPath: "workTime.end")
        } else if employeeType == .bookKeeping || employeeType == .employee {
            employeeData?.setValue(begin, forKeyPath: "dinnerTime.begin")
            employeeData?.setValue(end, forKeyPath: "dinnerTime.end")
        }
    }

    func setWorkplaceNumber(number: String?) {
        if employeeType == .bookKeeping || employeeType == .employee {
            employeeData?.setValue(Int(number ?? "0"), forKeyPath: "workplaceNumber")
        }
    }

    func setBookkeeperType(type: Int?) {
        if employeeType == .bookKeeping {
            employeeData?.setValue(type, forKeyPath: "type")
        }
    }

    func save() {
        savingCompletion?(employeeData, employeeType)
    }
}

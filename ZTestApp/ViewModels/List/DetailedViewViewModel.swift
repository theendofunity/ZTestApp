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
            beginTime = employeeData?.value(forKeyPath: "dinnerTime.begin") as? Date
            endTime = employeeData?.value(forKeyPath: "dinnerTime.end") as? Date
        }

        return (beginTime, endTime)
    }

    func workplaceNumber() -> String? {
        if employeeType == .bookKeeping || employeeType == .employee {
            guard let number = employeeData?.value(forKeyPath: "workplaceNumber") as? Int16 else {
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

    func createObject(employeeType: EmployeeType) {
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

        save()
    }

    func setName(name: String?) {
        RealmManager.write {
            employeeData?.setValue(name, forKeyPath: "baseInfo.name")
        }
    }

    func setSallary(sallary: String?) {
        RealmManager.write {
            employeeData?.setValue(Int(sallary ?? "0"), forKeyPath: "baseInfo.sallary")
        }
    }

    func setTime(begin: Date?, end: Date?) {
        RealmManager.write {
            if employeeType == .leader {
                employeeData?.setValue(begin, forKeyPath: "workTime.begin")
                employeeData?.setValue(end, forKeyPath: "workTime.end")
            } else if employeeType == .bookKeeping || employeeType == .employee {
                employeeData?.setValue(begin, forKeyPath: "dinnerTime.begin")
                employeeData?.setValue(end, forKeyPath: "dinnerTime.end")
            }
        }
    }

    func setWorkplaceNumber(number: String?) {
        RealmManager.write {
            if employeeType == .bookKeeping || employeeType == .employee {
                employeeData?.setValue(Int(number ?? "0"), forKeyPath: "workplaceNumber")
            }
        }
    }

    func setBookkeeperType(type: Int?) {
        RealmManager.write {
            if employeeType == .bookKeeping {
                employeeData?.setValue(type, forKeyPath: "type")
            }
        }
    }

    func changeType(type: EmployeeType) {
        delete()
        employeeData = nil
        employeeType = type
        createObject(employeeType: type)
    }

    func save() {
        guard let data = employeeData else { return }
        RealmManager.saveObject(object: data)
    }

    func update() {
        savingCompletion?(employeeData, employeeType)
    }

    func delete() {
        guard let data = employeeData else { return }
        RealmManager.deleteObject(object: data)
    }
}

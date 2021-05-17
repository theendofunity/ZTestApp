//
//  EmployeeCellViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 16.05.2021.
//

import Foundation

class EmployeeCellViewModel: ListCellViewModelType {
    // MARK: - Properties

    let employee: Employee

    // MARK: - Functions

    init(employee: Employee) {
        self.employee = employee
    }

    func name() -> String? {
        return employee.name
    }

    func sallary() -> String? {
        return "\(employee.sallary)"
    }

    func dinnerTime() -> String? {
        guard let begin = employee.employeeInfo?.dinnerTime?.begin,
              let end = employee.employeeInfo?.dinnerTime?.end
        else { return nil }

        return timeInterval(begin: begin, end: end)
    }

    func workplaceNumber() -> String? {
        guard let number = employee.employeeInfo?.workplaceNumber else { return nil }
        return "\(number)"
    }
}

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
        return employee.baseInfo.name
    }

    func sallary() -> String? {
        return employee.baseInfo.sallary
    }

    func dinnerTime() -> String? {
        let begin = employee.dinnerTime.begin
        let end = employee.dinnerTime.end

        return timeInterval(begin: begin, end: end)
    }

    func workplaceNumber() -> String? {
        return "\(employee.workplaceNumber)"
    }
}

//
//  EmployeeChangingViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 11.05.2021.
//

import Foundation
import CoreData

class EmployeeChangingViewModel: EmployeeDetailedViewViewModelType {
    let employeeType: EmployeeType
    let employeeData: NSManagedObject

    init?(employeeType: EmployeeType, data: NSManagedObject) {
        self.employeeType = employeeType
        self.employeeData = data
    }
}

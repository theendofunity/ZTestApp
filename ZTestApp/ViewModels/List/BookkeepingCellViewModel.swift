//
//  BookkeepingCellViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 16.05.2021.
//

import Foundation

class BookkeepingCellViewModel: ListCellViewModelType {

    // MARK: - Properties

    let bookkeeping: Bookkeeping

    // MARK: - Functions

    init(bookkeeping: Bookkeeping) {
        self.bookkeeping = bookkeeping
    }

    func name() -> String? {
        return bookkeeping.name
    }

    func sallary() -> String? {
        return "\(bookkeeping.sallary)"
    }

    func dinnerTime() -> String? {
        guard let begin = bookkeeping.employeeInfo?.dinnerTime?.begin,
              let end = bookkeeping.employeeInfo?.dinnerTime?.end
        else { return nil }

        return timeInterval(begin: begin, end: end)
    }

    func workplaceNumber() -> String? {
        guard let number = bookkeeping.employeeInfo?.workplaceNumber else { return nil }
        return "\(number)"
    }

    func type() -> String? {
        let bookkeepingType = bookkeeping.type

        for title in BookkeepingType.allCases where title.rawValue == bookkeepingType {
            return "\(title)"
        }

        return nil
    }
}

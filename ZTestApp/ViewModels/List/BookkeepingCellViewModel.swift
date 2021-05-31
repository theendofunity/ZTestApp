//
//  BookkeepingCellViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 16.05.2021.
//

import Foundation

class BookkeepingCellViewModel: ListCellViewModelType {

    // MARK: - Properties

    let bookkeeper: Bookkeeper

    // MARK: - Functions

    init(bookkeeping: Bookkeeper) {
        self.bookkeeper = bookkeeping
    }

    func name() -> String? {
        return bookkeeper.baseInfo.name
    }

    func sallary() -> String? {
        return bookkeeper.baseInfo.sallary
    }

    func dinnerTime() -> String? {
        let begin = bookkeeper.dinnerTime.begin
        let end = bookkeeper.dinnerTime.end

        return timeInterval(begin: begin, end: end)
    }

    func workplaceNumber() -> String? {
        let number = bookkeeper.workplaceNumber
        return "\(number)"
    }

    func type() -> String? {
        let bookkeepingType = bookkeeper.type

        for title in BookkeepingType.allCases where title.rawValue == bookkeepingType {
            return String("\(title)").capitalizingFirstLetter()
        }

        return nil
    }
}

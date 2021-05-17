//
//  LeaderCellViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 16.05.2021.
//

import Foundation

class LeaderCellViewModel: ListCellViewModelType {
// MARK: - Properties

    let leader: Leader

// MARK: - Functions

    init(leader: Leader) {
        self.leader = leader
    }

    func name() -> String? {
        return leader.name
    }

    func sallary() -> String? {
        return "\(leader.sallary)"
    }

    func workTime() -> String? {
        guard let begin = leader.businessHours?.begin,
              let end = leader.businessHours?.end else { return nil }

        return timeInterval(begin: begin, end: end)
    }
}

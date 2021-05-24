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
        return leader.baseInfo.name
    }

    func sallary() -> String? {
        return "\(leader.baseInfo.sallary)"
    }

    func workTime() -> String? {
        let begin = leader.workTime.begin
        let end = leader.workTime.end

        return timeInterval(begin: begin, end: end)
    }
}

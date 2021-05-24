//
//  Formatter.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 16.05.2021.
//

import Foundation

func timeInterval(begin: Date, end: Date) -> String {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = .none
    dateFormater.timeStyle = .short
    let beginTime = dateFormater.string(from: begin)
    let endTime = dateFormater.string(from: end)

    let interval = beginTime + " - " + endTime

    return interval
}

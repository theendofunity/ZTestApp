//
//  ApiData.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 17.05.2021.
//

import Foundation

struct ApiData: Decodable {
    let total: Int
    let last: String
    let quotes: [Quote]
}

struct Quote: Decodable {
    let id: Int
    let description: String
    let time: String
    let rating: Int
}

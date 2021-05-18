//
//  ImagesData.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 18.05.2021.
//

import Foundation

struct ImagesData: Decodable {
    let urls: Urls
}

struct Urls: Decodable {
    let regular: String
}

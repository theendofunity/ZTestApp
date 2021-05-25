//
//  String+CapitalizedFirstLetter.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 25.05.2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

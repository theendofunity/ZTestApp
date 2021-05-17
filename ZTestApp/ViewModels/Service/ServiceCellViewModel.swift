//
//  ServiceCellViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 17.05.2021.
//

import Foundation

class ServiceCellViewModel {
// MARK: - Properties
    let quote: Quote

    init(quote: Quote) {
        self.quote = quote
    }

    func quoteId() -> String {
        return "\(quote.id)"
    }

    func description() -> String {
        return quote.description
    }

    func time() -> String {
        return quote.time
    }

    func rating() -> String {
        return "\(quote.rating)"
    }
}

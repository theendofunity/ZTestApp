//
//  ServiceViewViewModel.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 17.05.2021.
//

import Foundation

class ServiceViewViewModel {
    var quotes = [Quote]()

    func numberOfRows() -> Int {
        return quotes.count
    }

    func fetchData(completion: @escaping (() -> Void)) {
        let apiService = ApiService()

        apiService.fetchData { result in
            switch result {
            case .success(let data):
                self.quotes = data.quotes
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }

    func cellViewModel(for indexPath: IndexPath) -> ServiceCellViewModel {
        let quote = quotes[indexPath.row]
        return ServiceCellViewModel(quote: quote)
    }
}

//
//  ServiceViewController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit

class ServiceViewController: UIViewController {

    // MARK: - Live cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Service"

        let apiService = ApiService()
        apiService.fetchData { [weak self] result in
            switch result {
            case .success(let apiData):
                print(apiData.quotes.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - UI configuration
}

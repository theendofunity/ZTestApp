//
//  ApiService.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 17.05.2021.
//

import Foundation

enum Errors: Error {
    case incorrectUrl
    case emptyData
    case decodeError
}
class ApiService {
    let urlString = "http://quotes.zennex.ru/api/v3/bash/quotes?sort=time"

    func fetchData(completion: @escaping ((Result<ApiData, Error>) -> Void)) {
        guard let url = URL(string: urlString) else {
            completion(.failure(Errors.incorrectUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(error!))
            }

            guard let data = data else {
                completion(.failure(Errors.emptyData))
                return
            }
            if let apiData = try? JSONDecoder().decode(ApiData.self, from: data) {
            completion(.success(apiData))
            } else {
                completion(.failure(Errors.decodeError))
            }

        }

        task.resume()
    }
}

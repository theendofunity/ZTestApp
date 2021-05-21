//
//  ImageDownloader.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 18.05.2021.
//

import UIKit

class ImageUrlsManager {
// MARK: - Properties

    var imageUrls = [String]()
    var currentIndex = 0

// MARK: - urls getters

    func nextUrl() -> URL? {
        currentIndex += 1
        if currentIndex == imageUrls.count {
            currentIndex -= 1
        }
        return currentUrl()
    }
    func previousUrl() -> URL? {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = 0
        }
        return currentUrl()
    }

    func currentUrl() -> URL? {
        let urlString = imageUrls[currentIndex]
        let url = URL(string: urlString)
        return url
    }

    func isFirstUrl() -> Bool {
        return currentIndex == 0
    }

    func isLastUrl() -> Bool {
        return currentIndex == (imageUrls.count - 1)
    }

    func fetchImageUrls(completion: @escaping (() -> Void)) {
        let url = "https://api.unsplash.com/photos/?page=1&per_page=15&client_id=\(imageApiKey)"
        let apiService = ApiService()
        apiService.fetchData(from: url) {(result: Result<[ImagesData], Error>) in
            switch result {
            case .success(let imagesData):
                for data in imagesData {
                    self.imageUrls.append(data.urls.regular)
                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

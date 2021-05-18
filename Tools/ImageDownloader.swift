//
//  ImageDownloader.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 18.05.2021.
//

import UIKit
import Kingfisher

class ImageDownloader {
// MARK: - Properties

    var imageUrls = [String]()
    var currentIndex = 0

// MARK: - Initializer

    init() {
//        self.setupCache()

        if imageUrls.isEmpty {
            self.fetchImageUrls()
        }
    }
// MARK: - Image download

    func nextUrl() -> URL? {
        currentIndex += 1
        return currentUrl()
    }
    func previousUrl() -> URL? {
        currentIndex -= 1
        return currentUrl()
    }

    func currentUrl() -> URL? {
        if currentIndex < imageUrls.count {
            let urlString = imageUrls[currentIndex]
            let url = URL(string: urlString)
            return url
//            let image = KingfisherManager.shared.retrieveImage(with: url, options: nil, completionHandler: nil)
        }
        return nil
    }

    private func fetchImageUrls() {
        let url = "https://api.unsplash.com/photos/?page=1&client_id=6862y-t05CfED7j_Uc-mwsGfRs8noWxH2Qx3Jhyc_pw"
        let apiService = ApiService()
        apiService.fetchData(from: url) {(result: Result<[ImagesData], Error>) in
            switch result {
            case .success(let imagesData):
                for data in imagesData {
                    self.imageUrls.append(data.urls.regular)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

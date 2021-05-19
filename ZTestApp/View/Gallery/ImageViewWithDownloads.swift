//
//  ImageViewWithDownloads.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 19.05.2021.
//

import UIKit
import Kingfisher

class ImageViewWithDownloads: UIImageView {

// MARK: - Properties

    let downloader = ImageUrlsManager()

// MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCache()

        downloader.fetchImageUrls { [weak self] in
            DispatchQueue.main.async {
                self?.setImage()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - image setup

    func setImage() {
        let url = downloader.currentUrl()
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }

    func nextImage() {
        let url = downloader.nextUrl()
        kf.setImage(with: url)
    }

    func previousImage() {
        let url = downloader.previousUrl()
        kf.setImage(with: url)
    }

// MARK: - Private functions

    private func setupCache() {
        let cashe = ImageCache.default
        cashe.memoryStorage.config.countLimit = 3
    }
}

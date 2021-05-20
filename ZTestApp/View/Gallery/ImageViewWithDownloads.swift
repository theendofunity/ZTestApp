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
        self.contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - image setup

    func setCurrentImage(completion: (() -> Void)?) {
        let url = downloader.currentUrl()
        setImage(with: url, completion: completion)
    }

    func nextImage(completion: (() -> Void)?) {
        let url = downloader.nextUrl()
        setImage(with: url, completion: completion)
    }

    func previousImage(completion: (() -> Void)?) {
        let url = downloader.previousUrl()
        setImage(with: url, completion: completion)
    }

// MARK: - Private functions

    private func setImage(with url: URL?, completion: (() -> Void)?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url) { _ in
            if completion != nil {
                completion!()
            }
        }
    }

    private func setupCache() {
        let cashe = ImageCache.default
        cashe.memoryStorage.config.countLimit = 3
    }
}

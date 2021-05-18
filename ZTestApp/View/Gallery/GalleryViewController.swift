//
//  GalleryViewController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit
import Kingfisher

class GalleryViewController: UIViewController {

// MARK: - Properties

    let imageView = UIImageView()
    let downloader = ImageDownloader()

// MARK: - Live cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Gallery"
        setupLayout()
        setupToolBar()
        setupCache()

        let url = downloader.currentUrl()
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }

    // MARK: - UI configuration

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
    }

    @objc private func nextImage() {
        let url = downloader.nextUrl()
        imageView.kf.setImage(with: url)

        let num = ImageCache.default.memoryStorage.config.countLimit
        print(num)
    }

    @objc private func previousImage() {
        let url = downloader.previousUrl()
        imageView.kf.setImage(with: url)
    }

    private func setupToolBar() {
        let nextBtn = UIBarButtonItem(title: "Next",
                                      style: .plain,
                                      target: self,
                                      action: #selector(nextImage))
        navigationItem.rightBarButtonItem = nextBtn

        let previousBtn = UIBarButtonItem(title: "Previous",
                                          style: .plain,
                                          target: self,
                                          action: #selector(previousImage))
        navigationItem.leftBarButtonItem = previousBtn
    }

    private func setupCache() {
        let cashe = ImageCache.default
        cashe.memoryStorage.config.countLimit = 3
    }
}

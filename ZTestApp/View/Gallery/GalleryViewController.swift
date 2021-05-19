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

    var imageView: ImageViewWithDownloads?

    init() {
        super.init(nibName: nil, bundle: nil)

//        imageView = ImageViewWithDownloads(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Live cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = ImageViewWithDownloads(frame: view.bounds)

        title = "Gallery"
        setupLayout()
        setupToolBar()
    }

    // MARK: - UI configuration

    private func setupLayout() {
        guard let imageView = imageView else { return }

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
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

    @objc private func nextImage() {
        imageView?.nextImage()
    }

    @objc private func previousImage() {
        imageView?.previousImage()
    }
}

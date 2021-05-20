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

    var scrollView: ImageScrollView?

    // MARK: - Live cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = ImageScrollView(frame: view.bounds)

        title = "Gallery"
        setupLayout()
        setupToolBar()
    }

    // MARK: - UI configuration

    private func setupLayout() {
        guard let scrollView = scrollView else { return }

        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.contentMode = .scaleAspectFit
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8)
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
        scrollView?.nextImage()
    }

    @objc private func previousImage() {
        scrollView?.previousImage()
    }
}

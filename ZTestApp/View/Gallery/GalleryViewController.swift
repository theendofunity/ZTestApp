//
//  GalleryViewController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit

class GalleryViewController: UIViewController {

// MARK: - Properties

    let imageView = UIImageView()

// MARK: - Live cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Gallery"
        setupLayout()
    }

    // MARK: - UI configuration

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .center
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
    }

}

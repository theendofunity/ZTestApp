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

        title = NSLocalizedString("Gallery", comment: "")
        setupLayout()
        setupToolBar()
    }

    // MARK: - UI configuration

    private func setupLayout() {
        guard let scrollView = scrollView else { return }

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8)
        ])
    }

    private func setupToolBar() {
        let nextBtn = UIBarButtonItem(title: NSLocalizedString("Next", comment: ""),
                                      style: .plain,
                                      target: self,
                                      action: #selector(nextImage))
        navigationItem.rightBarButtonItem = nextBtn

        let previousBtn = UIBarButtonItem(title: NSLocalizedString("Previous", comment: ""),
                                          style: .plain,
                                          target: self,
                                          action: #selector(previousImage))
        navigationItem.leftBarButtonItem = previousBtn

        changeToolbarButtonsState()
    }

    @objc private func nextImage() {
        scrollView?.nextImage()
        changeToolbarButtonsState()
    }

    @objc private func previousImage() {
        scrollView?.previousImage()
        changeToolbarButtonsState()
    }

    private func changeToolbarButtonsState() {
        guard let scrollView = scrollView else { return }

        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true

        if scrollView.isFirstImage() {
            navigationItem.leftBarButtonItem?.isEnabled = false
        }

        if scrollView.isLastImage() {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }

    }
}

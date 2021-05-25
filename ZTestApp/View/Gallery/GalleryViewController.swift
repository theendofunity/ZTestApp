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
        setupGesture()
    }

    // MARK: - UI configuration

    private func setupLayout() {
        guard let scrollView = scrollView else { return }

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8)
        ])
    }

    private func setupToolBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]

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

    // MARK: - Gestures

    private func setupGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(gesture:)))
        swipeRight.direction = .right

        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(gesture:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }

    @objc private func swipeGesture(gesture: UIGestureRecognizer) {
        guard let gesture = gesture as? UISwipeGestureRecognizer else { return }

        switch gesture.direction {
        case .left:
            nextImage()
        case .right:
            previousImage()
        default:
            return
        }
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

//
//  GalleryViewController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    //    MARK: - Live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Gallery"
        setupLayout()
    }
    

    //    MARK: - UI configuration
    
    private func setupLayout() {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.frame.size = CGSize(width: 200, height: 200)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

}

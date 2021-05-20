//
//  ImageScrollView.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 20.05.2021.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {

    var imageView: ImageViewWithDownloads
    lazy var completion: (() -> Void) = { [weak self] in
        DispatchQueue.main.async {
            self?.configurate()
        }
    }

    override init(frame: CGRect) {
        imageView = ImageViewWithDownloads(frame: frame)
        super.init(frame: frame)
        self.delegate = self

        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

        self.addSubview(imageView)

        imageView.downloader.fetchImageUrls { [weak self] in
            DispatchQueue.main.async {
                self?.imageView.setCurrentImage(completion: self?.completion)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configurate() {
        guard let imageSize = imageView.image?.size else { return }
        contentSize = imageSize
        setupZoomScale(for: imageSize)
        self.zoomScale = minimumZoomScale

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        centerImage()
    }

    func setupZoomScale(for imageSize: CGSize) {
        let boundsSize = self.bounds.size

        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)

        var maxScale: CGFloat = 1.0
        if minScale < 0.1 {
            maxScale = 0.3
        }
        if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        }
        if minScale >= 0.5 {
            maxScale = max(1.0, minScale)
        }

        self.minimumZoomScale = minScale
        self.maximumZoomScale = maxScale

        print(boundsSize)
        print(imageSize)
    }

    func centerImage() {
        let boundsSize = self.bounds.size
        var frameToCenter = imageView.frame

        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }

        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }

        imageView.frame = frameToCenter
    }

    func nextImage() {
        imageView.nextImage(completion: completion)
    }

    func previousImage() {
        imageView.previousImage(completion: completion)
    }

// MARK: - UIScrollViewDelegate

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}

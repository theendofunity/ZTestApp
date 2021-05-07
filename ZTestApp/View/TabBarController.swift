//
//  TabBarController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit

class TabBarController: UITabBarController {

    //    MARK: - Properties
    
    let listViewController = ListTableViewController()
    let galleryViewController = GalleryViewController()
    let serviceViewController = ServiceViewController()
    
    //    MARK: - Live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    //    MARK: - UI configuration
    
    private func setupTabBar() {
        let listTabBarItem = UITabBarItem()
        listTabBarItem.title = "List"
        listTabBarItem.image = UIImage(systemName: "list.dash")
        listViewController.tabBarItem = listTabBarItem
        
        let galleryTabBarItem = UITabBarItem()
        galleryTabBarItem.title = "Gallery"
        galleryTabBarItem.image = UIImage(systemName: "photo")
        galleryViewController.tabBarItem = galleryTabBarItem
        
        let serviceTabBarItem = UITabBarItem()
        serviceTabBarItem.title = "Service"
        serviceTabBarItem.image = UIImage(systemName: "questionmark.folder.fill")
        serviceViewController.tabBarItem = serviceTabBarItem
        
        viewControllers = [listViewController, galleryViewController, serviceViewController]
        selectedViewController = listViewController
    }
}

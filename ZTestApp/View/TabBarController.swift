//
//  TabBarController.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Live cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    // MARK: - UI configuration

    private func setupTabBar() {

        let listViewModel = ListViewModel()

        viewControllers = [
            createTabBarItem(title: "List",
                             icon: UIImage(systemName: "list.dash"),
                             viewController: ListTableViewController(viewModel: listViewModel)),
            createTabBarItem(title: "Gallery",
                             icon: UIImage(systemName: "photo"),
                             viewController: GalleryViewController()),
            createTabBarItem(title: "Service",
                             icon: UIImage(systemName: "questionmark.folder.fill"),
                             viewController: ServiceViewController())
        ]

        selectedIndex = 0
    }

    private func createTabBarItem(title: String,
                                  icon: UIImage?,
                                  viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)

        let tabBarItem = UITabBarItem()
        tabBarItem.title = title
        tabBarItem.image = icon
        navigationController.tabBarItem = tabBarItem

        viewController.title = title

        return navigationController
    }
}

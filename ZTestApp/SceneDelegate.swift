//
//  SceneDelegate.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 07.05.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let tabBarController = TabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}

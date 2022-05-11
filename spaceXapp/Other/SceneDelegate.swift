//
//  SceneDelegate.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 01.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        let viewController = ViewController()
//        let navCotroller = UINavigationController(rootViewController: viewController)
//        window.rootViewController = navCotroller
//        self.window = window
//        window.makeKeyAndVisible()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let pageViewController = PageViewController()
        let navController = UINavigationController(rootViewController: pageViewController)
        window.rootViewController = navController
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .dark
        }
        self.window = window
        window.makeKeyAndVisible()
    }
}

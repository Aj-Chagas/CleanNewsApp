//
//  SceneDelegate.swift
//  Main
//
//  Created by Anderson Chagas on 10/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: HomeFactory.makeViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

}


//
//  SceneDelegate.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import UIKit

@available(iOS 13, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate, WindowManaging {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        guard let vc = HomeViewController.create(interactor: DependencyContainer.shared.footballDataInteractor) else {
            return
        }
        self.window = UIWindow(windowScene: scene)
        let nc = UINavigationController(rootViewController: vc)
        setRoot(viewController: nc)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}


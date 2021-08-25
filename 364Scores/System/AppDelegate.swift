//
//  AppDelegate.swift
//  364Scores
//
//  Created by Yohai Reshef on 23/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, WindowManaging {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
            // Any initialization before SceneDelegate
            // From here on out, Scene Delegate will take control
        } else {
            //If less than iOS 13, AppDelegate still manages scenes.
            guard let vc = HomeViewController.create(interactor: DependencyContainer.shared.footballDataInteractor) else {
                return false
            }
            self.window = UIWindow()
            let nc = UINavigationController(rootViewController: vc)
            setRoot(viewController: nc)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


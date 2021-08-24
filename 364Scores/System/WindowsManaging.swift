//
//  WindowsManaging.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import Foundation
import UIKit

protocol WindowManaging: AnyObject {
    var window: UIWindow? { get }
}

extension WindowManaging {
    func setRoot(
        viewController: UIViewController,
        animated: Bool = true) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        if let window = window, animated {
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {},
                completion: nil)
        }
    }
}

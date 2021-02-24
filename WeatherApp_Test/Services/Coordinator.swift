//
//  Coordinator.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import Foundation
import UIKit

class Coordinator: NSObject {
    private(set) var childCoordinators: [Coordinator] = []

    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func showViewController(_ viewController: UIViewController,
                            from: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            if from is UINavigationController {
                let navViewController = from as! UINavigationController
                navViewController.pushViewController(viewController, animated: animated)
            } else {
                from.present(viewController, animated: animated, completion: nil)
            }
        }
    }
}

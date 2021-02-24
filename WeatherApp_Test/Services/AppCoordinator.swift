//
//  AppCoordinator.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow?

    private lazy var apiClient: APIClientType = {
        return APIClient()
    }()

    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {

        guard let window = window else {
            return
        }
        let navigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, apiClient: apiClient)
        addChildCoordinator(homeCoordinator)
        window.rootViewController = navigationController
        homeCoordinator.start()
        window.makeKeyAndVisible()

    }


    override func finish() {
        //Empty implementaion
    }
}

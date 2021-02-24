//
//  CityCoordinator.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 23/02/21.
//

import Foundation
import UIKit

final class CityCoordinator: Coordinator {

    private static let storyboardName = "CityScreen"
    private let apiClient: APIClientType
    private let navigationController: UINavigationController
    private let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
    var selectedCity: BookMarkModel!

    init(navigationController: UINavigationController, apiClient: APIClientType) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }

    private lazy var rootViewController: CityVC = {
        return storyBoard.instantiateInitialViewController() as! CityVC
    }()

    private lazy var viewModel: CityViewModelType = {
        let viewModel = CityViewModel(apiClient: apiClient)
        viewModel.coordinatorDelegate = self
        viewModel.selectedCity = selectedCity
        return viewModel
    }()

    override func start() {
        rootViewController.viewModel = viewModel
        showViewController(rootViewController, from: navigationController, animated: true)
    }
}

extension CityCoordinator: CityCoordinatorType {
    func goToHomeScreen() {
        navigationController.popViewController(animated: true)
    }
}

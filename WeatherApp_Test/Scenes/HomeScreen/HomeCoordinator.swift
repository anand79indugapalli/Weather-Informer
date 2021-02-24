//
//  HomeCoordinator.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {

    private static let storyboardName = "HomeScreen"
    private let apiClient: APIClientType
    private let navigationController: UINavigationController
    private let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)

    init(navigationController: UINavigationController, apiClient: APIClientType) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }

    private lazy var rootViewController: HomeScreenVC = {
        return storyBoard.instantiateInitialViewController() as! HomeScreenVC
    }()

    private lazy var viewModel: HomeViewModelType = {
        let viewModel = HomeViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()

    override func start() {
        rootViewController.viewModel = viewModel
        navigationController.viewControllers = [rootViewController]
    }
}

extension HomeCoordinator: HomeCoordinatorType, HomeToMapViewType {
    func selectedCity(city: BookMarkModel) {
        let cityCoordinator = CityCoordinator(navigationController: navigationController, apiClient: apiClient)
        cityCoordinator.selectedCity = city
        addChildCoordinator(cityCoordinator)
        cityCoordinator.start()
    }
    
    
    func openMapViewToBookMark() {
        let storyboard = UIStoryboard(name: "MapScreen", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? MapScreenVC {
            vc.viewModel = self
            vc.modalPresentationStyle = .fullScreen
            showViewController(vc, from: rootViewController, animated: true)
        }
    }
    
    func selectedPinInfo(info: BookMarkModel) {
        rootViewController.addSelectedCities(city: info)
    }
}

//
//  CityViewModelType.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 23/02/21.
//

import Foundation
protocol CityViewModelType {
    func getCityForecastInfoFromServer(units: String, completionHandler: @escaping ( _ list: CityWeatherForecast?, _ errorMsg: String) -> Void)
    func goToHomeScreen()
}

protocol CityCoordinatorType {
    func goToHomeScreen()
}

protocol CityTableHeaderType {
    func dateSelected(index: Int)
}

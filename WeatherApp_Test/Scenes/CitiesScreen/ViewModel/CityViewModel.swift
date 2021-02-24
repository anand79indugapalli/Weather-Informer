//
//  CityViewModel.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 23/02/21.
//

import Foundation


final class CityViewModel {
    private let apiClient: APIClientType
    var coordinatorDelegate: CityCoordinatorType?
    var selectedCity: BookMarkModel!
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    func getCityForecast(units: String, completionHandler: @escaping ( _ list: CityWeatherForecast?, _ errorMsg: String) -> Void) {
        let url = APIList.city_Temp + "lat=\(selectedCity.coordinates.latitude)&lon=\(selectedCity.coordinates.longitude)&appid=\(Constant.app_ID)&units=\(units)"//metric
        apiClient.get(url: url) { (result: DTO<CityWeatherForecast>) in
            completionHandler(result.payload, result.error ?? "OOPS..! Something went wrong!")
        }

    }
}

extension CityViewModel: CityViewModelType {
    func goToHomeScreen() {
        coordinatorDelegate?.goToHomeScreen()
    }
    
    
    
    func getCityForecastInfoFromServer(units: String, completionHandler: @escaping (CityWeatherForecast?, String) -> Void) {
        getCityForecast(units: units, completionHandler: completionHandler)
    }
    
    
}

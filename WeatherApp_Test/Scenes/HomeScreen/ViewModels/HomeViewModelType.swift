//
//  HomeViewModelType.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import Foundation

protocol HomeViewModelType {
    func openMapViewToBookMark()
    func getSavedCities(cities: [BookMarkModel])
    func getCitiesList(_ completionHandler: @escaping ([BookMarkModel]) -> Void)
    func selectedCity(city: BookMarkModel)
}

protocol HomeCoordinatorType {
    func openMapViewToBookMark()
    func selectedCity(city: BookMarkModel)
}

protocol HomeToMapViewType {
    func selectedPinInfo(info: BookMarkModel)
}

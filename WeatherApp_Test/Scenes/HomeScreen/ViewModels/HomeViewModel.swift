//
//  HomeViewModel.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import Foundation

final class HomeViewModel {
    var coordinatorDelegate: HomeCoordinatorType?
    
    init() {
        
    }
    
    func getSavedCities(cities: [BookMarkModel])  {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(cities)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "places")

        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func savePinnedCities() -> [BookMarkModel] {
        // Read/Get Data
        if let data = UserDefaults.standard.data(forKey: "places") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let cities = try decoder.decode([BookMarkModel].self, from: data)
                return cities
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return []
    }
}

extension HomeViewModel: HomeViewModelType {
    func selectedCity(city: BookMarkModel) {
        coordinatorDelegate?.selectedCity(city: city)
    }
    
    func getCitiesList(_ completionHandler: @escaping ([BookMarkModel]) -> Void) {
        completionHandler(savePinnedCities())
    }
    
    func openMapViewToBookMark() {
        coordinatorDelegate?.openMapViewToBookMark()
    }
    
}

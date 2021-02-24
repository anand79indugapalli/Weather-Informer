//
//  HomeScreenModel.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 23/02/21.
//

import Foundation

struct BookMarkModel: Codable {
    var city: String
    var state: String
    var country: String
    var coordinates: Coordinates
    var pinCode: String?
}

struct Coordinates: Codable {
    
    var latitude: Double
    
    var longitude: Double
}

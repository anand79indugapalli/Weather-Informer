//
//  APIClientType.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import Foundation

enum Result<T> {
    case success([T])
    case error(String)
}
struct DTO<T> {

    let payload: T?
    let error: String?

    init(payload: T?, error: String?) {
        self.payload = payload
        self.error = error
    }
}

protocol APIClientType {

    func get<T: Codable>(url: String, _ completionHandler:@escaping (DTO<T>) -> Void)
    
}

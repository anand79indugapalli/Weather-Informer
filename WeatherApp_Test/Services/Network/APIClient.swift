//
//  APIClient.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import Foundation
import SystemConfiguration

class APIClient {
    private func getRequest<T: Codable>(url: String, completionHandler: @escaping(DTO<T>) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            completionHandler(DTO<T>(payload: nil, error: "Internet Connection not Available!"))
            return
        }
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            let decoder = JSONDecoder()
            if let responseData = data {
                do {
                    let result = try decoder.decode(T.self, from: responseData)
                    completionHandler(DTO<T>(payload: result, error: nil))
                } catch {
                    completionHandler(DTO<T>(payload: nil, error: error.localizedDescription))
                }
            }
            if let err = error {
                completionHandler(DTO<T>(payload: nil, error: err.localizedDescription))
            }
        })

        task.resume()
    }
}

// MARK: APIClientType conformance
extension APIClient: APIClientType {
    func get<T: Codable>(url: String, _ _completionHandler: @escaping (DTO<T>) -> Void) {
        getRequest(url: url, completionHandler: _completionHandler)
    }
}


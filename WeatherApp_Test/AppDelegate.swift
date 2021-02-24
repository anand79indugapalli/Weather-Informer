//
//  AppDelegate.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appCoordinator: AppCoordinator!
    var window: UIWindow?
    var locationManager: CLLocationManager!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //let window = UIWindow.init(frame: UIScreen.main.bounds)
        getUserLocation()
        appCoordinator = AppCoordinator.init(window: window)
        appCoordinator.start()
        //self.window = window
        return true
    }

    ///
    func getUserLocation() {
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            /*locationManager.requestAlwaysAuthorization()*/
            locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        }
    }


}


extension AppDelegate: CLLocationManagerDelegate {
    // MARK: - CLLocationManagerDelegate Methods
    /// locationManager didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        locationManager.stopUpdatingLocation()
        debugPrint("\(userLocation)")
        Constant.currentLocation = userLocation
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
  
}

//
//  MapScreenVC.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import UIKit
import MapKit

class MapScreenVC: UIViewController {

    @IBOutlet weak var mapDescLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var confirmButton: UIButton!
    
    let locationManager = CLLocationManager()
    var viewModel: HomeToMapViewType?
    var bookMarkLocation: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        // requestLocationAccess()
        // mapView.delegate = self
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        if let currentLocation = Constant.currentLocation   {
            getLocation(location: currentLocation.coordinate)
        } else {
            confirmButton.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func longTap(sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            getLocation(location: locationOnMap)
        }
    }

    func getLocation(location: CLLocationCoordinate2D) {
        
        let locationCL = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locationCL, completionHandler:{ placemarks, error -> Void in
            
            // Place details
            guard let placeMark = placemarks?.first else { return }
            self.bookMarkLocation = placeMark
            
            // Location name
            if let locationName = placeMark.location {
                print(locationName)
            }
            // Street address
            if let street = placeMark.thoroughfare {
                print(street)
            }
            // City
            if let city = placeMark.subAdministrativeArea {
                print(city)
            }
            // Zip code
            if let zip = placeMark.isoCountryCode {
                print(zip)
            }
            // Country
            if let country = placeMark.country {
                print(country)
            }
            self.mapDescLbl.text = "Do you want to Bookmark location? \n \(placeMark.name ?? ""), \(placeMark.subAdministrativeArea ?? ""), \(placeMark.country ?? ""), \(placeMark.postalCode ?? "")?"
            let annotation = MKPointAnnotation()
             annotation.title = placeMark.name ?? ""
            annotation.subtitle = "You Pinned at \(placeMark.subAdministrativeArea ?? ""), \(placeMark.country ?? ""), \(placeMark.postalCode ?? "")."
            annotation.coordinate = location
            self.confirmButton.isEnabled = true
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(annotation)
        })
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        let info = BookMarkModel(
            city: bookMarkLocation?.name ?? "",
            state: bookMarkLocation?.subAdministrativeArea ?? "",
            country: bookMarkLocation?.country ?? "",
            coordinates: Coordinates(
                latitude: bookMarkLocation?.location?.coordinate.latitude ?? 0,
                longitude: bookMarkLocation?.location?.coordinate.longitude ?? 0
            ),
            pinCode: bookMarkLocation?.postalCode
        )
        DispatchQueue.main.async {
            self.viewModel?.selectedPinInfo(info: info)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


//
//  Location_VC.swift
//  Myfist_App
//
//  Created by sonu on 11/01/20.
//  Copyright © 2020 sonu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Location_VC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    @IBOutlet var txtaddress: UITextField!
    @IBOutlet var btngetlocation: UIButton!
    @IBOutlet var map: MKMapView!
    
    var locationmanager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
       // locationmanager = CLLocationManager()
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestAlwaysAuthorization()
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
        map.delegate = self
    }

    @IBAction func getlocation(_ sender: Any) {
        getaddress()
        }
    func getaddress () {
    let geocoder = CLGeocoder()
           geocoder.geocodeAddressString(txtaddress.text!) { (placemark, error) in
               guard let placemark = placemark , let location = placemark.first?.location
               else
               {
                   print("No location found")
                   return
               }
               print(location)
            self.mapThis(destinationCord: location.coordinate)
           }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }

    func mapThis(destinationCord : CLLocationCoordinate2D)  {
        let souceCordinate = (locationmanager.location?.coordinate)!
        let soucePlacemark = MKPlacemark(coordinate: souceCordinate)
        let destPlacemark = MKPlacemark(coordinate: destinationCord)
        let sourceItme = MKMapItem(placemark: soucePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let destimationRequest = MKDirections.Request()
        destimationRequest.source = sourceItme
        destimationRequest.destination = destItem
        destimationRequest.transportType = .automobile
        destimationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destimationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Something is woring : (")
                }
                return
            }
            
            let route = response.routes[0]
            self.map.addOverlay(route.polyline)
            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .red
        return render
    }
}

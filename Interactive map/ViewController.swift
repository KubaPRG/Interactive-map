//
//  ViewController.swift
//  Interactive map
//
//  Created by Jakub Kulakowski on 12/7/17.
//  Copyright © 2017 Jakub Kulakowski. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

print("lol")

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String! }
    
    @IBOutlet weak var map: MKMapView!
    
    var grewenHall = CustomPointAnnotation()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        map.showsScale = true
        map.showsPointsOfInterest = true
        map.showsUserLocation = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let sourceCoordinates = locationManager.location?.coordinate
        let destCoordinates = CLLocationCoordinate2DMake(43.05, -76.09)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .any
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            guard let response = response else {
                if error != nil {
                    print("Something went wrong")
                }
                return
            }
            
            let route = response.routes[0]
            self.map.add(route.polyline, level: .aboveLabels) //aboveRoads
            
            let startPoint = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(startPoint), animated: true)
            
        })
        
        let grewenCoordinaes = CLLocationCoordinate2DMake(43.0487734, -76.0875042)
        grewenHall.coordinate = grewenCoordinaes
        grewenHall.title = "Grewen Hall"
        grewenHall.imageName = "phin.png"
        map.addAnnotation(grewenHall)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            print("NOT REGISTERED AS MKPOINTANNOTATION")
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "stationIdentitfier")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "stationIdentitfier")
            annotationView!.canShowCallout = true
        }
            
        else {
            annotationView!.annotation = annotation
        }
        
        let cpa = annotation as! CustomPointAnnotation
        annotationView!.image = UIImage(named: cpa.imageName)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    class customPointAnnotation:MKPointAnnotation {
        var imageName: String!
    }
    @IBOutlet weak var map: MKMapView!
    
    let grewenHall = customPointAnnotation()
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let grewenCoordinates = CLLocationCoordinate2DMake(43.0487734, -76.0875042)
        grewenHall.coordinate = grewenCoordinates
        grewenHall.title = "Grewen Hall"
        grewenHall.imageName = "dolphin.jpg"
        //grewenHall.subtitle = ""
        
        //grewenAnnotation.image = UIImage(named: "dolphin.jpg")
        map.addAnnotation(grewenHall)
        
    }
    
    func map(_ map: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            print("NOT REGISTERED AS MKPOINTANNOTATION")
            return nil
        }
        
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "stationId")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "stationId")
            annotationView!.canShowCallout = true
        }
            
        else {
            annotationView!.annotation = annotation
        }
        
        let cpa = annotation as! customPointAnnotation
        annotationView!.image = UIImage(named: cpa.imageName)
        
        return annotationView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


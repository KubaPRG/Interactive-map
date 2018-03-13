//
//  HomeViewController.swift
//  Interactive map
//
//  Created by Jakub Kulakowski on 12/7/17.
//  Copyright © 2017 Jakub Kulakowski. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var myLocation = CLLocationCoordinate2DMake(43.0487734, -76.0875042)

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String!
    }
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var darkBg: UIView!
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var blockedView: UIView!
    
    
    @IBOutlet weak var blockedViewTopConst: NSLayoutConstraint!
    @IBOutlet weak var blockedViewBottomConst: NSLayoutConstraint!
    
    
    @IBOutlet weak var menuLeadingConst: NSLayoutConstraint!
    @IBOutlet weak var darkBgConst: NSLayoutConstraint!
    var menuShowing = false
    
    @IBOutlet weak var buttonReserveGrewen: UIButton!
    @IBOutlet weak var buttonReserveHarrison: UIButton!
    @IBOutlet weak var buttonReserveDablon: UIButton!
    @IBOutlet weak var buttonReserveMitchell: UIButton!
    @IBOutlet weak var buttonReserveRecCenter: UIButton!
    
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var buttonExitMenu: UIButton!
    
    var grewenHall = CustomPointAnnotation()
    var harrisonHall = CustomPointAnnotation()
    var mitchellHall = CustomPointAnnotation()
    var dablonHall = CustomPointAnnotation()
    var recCenter = CustomPointAnnotation()
    
    let locationManager = CLLocationManager()
    
    let grewenCoordinates = CLLocationCoordinate2DMake(43.0487734, -76.0875042)
    let harrisonCoordinates = CLLocationCoordinate2DMake(43.0467958, -76.0910839)
    let mitchellCoordinates = CLLocationCoordinate2DMake(43.0468909, -76.0858275)
    let dablonCoordinates = CLLocationCoordinate2DMake(43.0498038, -76.0902384)
    let recCenterCoordinates = CLLocationCoordinate2DMake(43.0495897, -76.0853903)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let mySpan:MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        let myActualLocation = self.locationManager.location?.coordinate
        if myActualLocation != nil {
            myLocation = myActualLocation!
        }
        let myRegion:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, mySpan)
        map.setRegion(myRegion, animated: true)
        
        menu.layer.shadowOpacity = 1
        menu.layer.shadowRadius = 8
        
        buttonReserveGrewen.isHidden = true
        buttonReserveHarrison.isHidden = true
        buttonReserveMitchell.isHidden = true
        buttonReserveDablon.isHidden = true
        buttonReserveRecCenter.isHidden = true
        
        buttonMenu.isHidden = false
        buttonExitMenu.isHidden = true
        
        map.delegate = self
        map.showsScale = true
        map.showsPointsOfInterest = true
        map.showsUserLocation = true
        map.showAnnotations(map.annotations, animated: true)
        
        
        grewenHall.coordinate = grewenCoordinates
        grewenHall.title = "Grewen Hall"
        grewenHall.imageName = "phin.png"
        map.addAnnotation(grewenHall)
        
        harrisonHall.coordinate = harrisonCoordinates
        harrisonHall.title = "Harrison Hall"
        harrisonHall.imageName = "phin.png"
        map.addAnnotation(harrisonHall)
        
        mitchellHall.coordinate = mitchellCoordinates
        mitchellHall.title = "Mitchell Hall"
        mitchellHall.imageName = "phin.png"
        map.addAnnotation(mitchellHall)
        
        dablonHall.coordinate = dablonCoordinates
        dablonHall.title = "Dablon Hall"
        dablonHall.imageName = "phin.png"
        map.addAnnotation(dablonHall)
        
        recCenter.coordinate = recCenterCoordinates
        recCenter.title = "Recreational Center"
        recCenter.imageName = "phin.png"
        map.addAnnotation(recCenter)
        
    }
    
    // ANNOTATION IMAGE + BUTTON
    
    func mapView(_ mapView: MKMapView, viewFor picture: MKAnnotation) -> MKAnnotationView?
    {
        if !(picture is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "station"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: picture, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
            
            let infoBtn = UIButton(type:.infoDark) as UIButton
            anView!.rightCalloutAccessoryView = infoBtn
        }
        else {
            anView!.annotation = picture
        }
        
        let cpa = picture as! CustomPointAnnotation
        anView!.image = UIImage(named:cpa.imageName)
        
        return anView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        let pinLocation = view.annotation!.coordinate
        let pinSpan = MKCoordinateSpanMake(0.005, 0.005)
        let pinRegion = MKCoordinateRegion(center: pinLocation, span: pinSpan)
        self.map.setRegion(pinRegion, animated: true)
        
        if(pinLocation.latitude == grewenCoordinates.latitude && pinLocation.longitude == grewenCoordinates.longitude)
        {
            buttonReserveGrewen.isHidden = false
        }
        else {buttonReserveGrewen.isHidden = true}
        
        if(pinLocation.latitude == harrisonCoordinates.latitude && pinLocation.longitude == harrisonCoordinates.longitude)
        {
            buttonReserveHarrison.isHidden = false
        }
        else {buttonReserveHarrison.isHidden = true}
        
        if(pinLocation.latitude == mitchellCoordinates.latitude && pinLocation.longitude == mitchellCoordinates.longitude)
        {
            buttonReserveMitchell.isHidden = false
        }
        else {buttonReserveMitchell.isHidden = true}
        
        if(pinLocation.latitude == dablonCoordinates.latitude && pinLocation.longitude == dablonCoordinates.longitude)
        {
            buttonReserveDablon.isHidden = false
        }
        else {buttonReserveDablon.isHidden = true}
        
        if(pinLocation.latitude == recCenterCoordinates.latitude && pinLocation.longitude == recCenterCoordinates.longitude)
        {
            buttonReserveRecCenter.isHidden = false
        }
        else {buttonReserveRecCenter.isHidden = true}
    }
    
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView)
        {
            buttonReserveGrewen.isHidden = true
            buttonReserveHarrison.isHidden = true
            buttonReserveMitchell.isHidden = true
            buttonReserveDablon.isHidden = true
            buttonReserveRecCenter.isHidden = true
        }
    
    // Button showing My Location
    @IBAction func didTapMyLocationButton(_ sender: Any) {
        if self.locationManager.location?.coordinate != nil {
           centerMyLocation()
        } else {
            print("No location detected")
        }
    }
    
    func centerMyLocation () {
        let myLocationSpan = MKCoordinateSpanMake(0.005, 0.005)
        let myLocationRegion = MKCoordinateRegion(center: (self.locationManager.location?.coordinate)!, span: myLocationSpan)
        self.map.setRegion(myLocationRegion, animated: true)
    }
    
    @IBAction func settingsButton(_ sender: Any) {
            let url = URL(string: UIApplicationOpenSettingsURLString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            blockedViewTopConst.constant = 0
            blockedViewBottomConst.constant = 0
            break
            
        case .notDetermined:
            blockedViewTopConst.constant = 0
            blockedViewBottomConst.constant = 0
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            blockedViewTopConst.constant = -1000
            blockedViewBottomConst.constant = 1000
            break
        }
    }
    
    // SLIDE-IN MENU
    
    // Opens Background when button pressed
    @IBAction func openBg(_ sender: Any) {
        if (!menuShowing){
            darkBgConst.constant = 0
            UIView.animate(withDuration: 0.0, animations: {
                self.view.layoutIfNeeded()})
            buttonMenu.isHidden = true
            buttonExitMenu.isHidden = false
        }
    }
    
    // Opens Menu when button pressed
    @IBAction func openMenu(_ sender: Any) {
    if (!menuShowing){
            menuLeadingConst.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    
    // Closes Menu & Bg when Exit button pressed
    @IBAction func closeMenu(_ sender: Any) {
        hideBoth()
    }
    
    // Closes Menu & Bg when Home pressed
    @IBAction func homeButtonPressed(_ sender: Any) {
        hideBoth()
    }
    
    // Closes Menu & Bg when background tapped
    @IBAction func hideOnBgTap(_ sender: UIGestureRecognizer) {
        hideBoth()
    }
    
    // Closes Menu & Bg through left swipes
    
    @IBAction func bgSwipeLeft(_ sender: Any) {
        hideBoth()
    }
    
    @IBAction func menuSwipeLeft(_ sender: Any) {
        hideBoth()
    }
    
    // Recycled Closing Menu
    
    func hideMenu(){
        menuLeadingConst.constant = -300
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()})
    }
    
    func hideBg(){
        darkBgConst.constant = 1000
        UIView.animate(withDuration: 0.0, animations: {
            self.view.layoutIfNeeded()})
    }
    
    func hideBoth(){
        if (menuShowing) {
            hideBg()
            hideMenu()
            buttonMenu.isHidden = false
            buttonExitMenu.isHidden = true
        }
        menuShowing = !menuShowing
    }
    
    //Sign Out
    @IBAction func didTapSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        print("The user has signed out.")
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()}
}

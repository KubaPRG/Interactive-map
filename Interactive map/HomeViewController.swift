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

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate{
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String!
    }
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var darkBg: UIView!
    @IBOutlet weak var menu: UIView!
    
    @IBOutlet weak var menuLeadingConst: NSLayoutConstraint!
    @IBOutlet weak var darkBgConst: NSLayoutConstraint!
    var menuShowing = false
    
    @IBOutlet weak var buttonReserveGrewen: UIButton!
    @IBOutlet weak var buttonReserveHarrison: UIButton!
    @IBOutlet weak var buttonReserveDablon: UIButton!
    @IBOutlet weak var buttonReserveMitchell: UIButton!
    @IBOutlet weak var buttonReserveRecCenter: UIButton!
    @IBOutlet weak var buttonSignOut: UIButton!
    
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
        
        let mySpan:MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        var myLocation = CLLocationCoordinate2DMake(43.0487734, -76.0875042)
        let myActualLocation = self.locationManager.location?.coordinate
        if myActualLocation != nil {
            myLocation = myActualLocation!
        }
        let myRegion:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, mySpan)
        map.setRegion(myRegion, animated: true)
        
        
        buttonReserveGrewen.isHidden = true
        buttonReserveHarrison.isHidden = true
        buttonReserveMitchell.isHidden = true
        buttonReserveDablon.isHidden = true
        buttonReserveRecCenter.isHidden = true
        
        buttonMenu.isHidden = false
        buttonExitMenu.isHidden = true
        buttonSignOut.isHidden = true
        
        map.delegate = self
        map.showsScale = true
        map.showsPointsOfInterest = true
        map.showsUserLocation = true
        map.showAnnotations(map.annotations, animated: true)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
        
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
    
    //Touch to exit keyboard
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
            
            let grewenBtn = UIButton(type:.infoDark) as UIButton
            anView!.rightCalloutAccessoryView = grewenBtn
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

    
    // SLIDE-IN MENU
    
    // Opens Background when button pressed
    @IBAction func openBg(_ sender: Any) {
        if (!menuShowing){
            darkBgConst.constant = 0
            UIView.animate(withDuration: 0.0, animations: {
                self.view.layoutIfNeeded()})
            buttonMenu.isHidden = true
            buttonExitMenu.isHidden = false
            buttonSignOut.isHidden = false
        }
    }
    
    // Closes Background when button pressed
    @IBAction func closeBg(_ sender: Any) {
        if (menuShowing) {
            darkBgConst.constant = 1000
            buttonExitMenu.isHidden = true
            buttonSignOut.isHidden = true
            buttonMenu.isHidden = false
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
    
    // Closes Menu when button pressed
    @IBAction func closeMenu(_ sender: Any) {
        if (menuShowing) {
            menuLeadingConst.constant = -300
        }
        menuShowing = !menuShowing
    }
    
    // Closes menu when background tapped
    @IBAction func hideOnBgTap(_ sender: UIGestureRecognizer) {
        if (menuShowing) {
            menuLeadingConst.constant = -300
            darkBgConst.constant = 1000
            buttonMenu.isHidden = false
            buttonExitMenu.isHidden = true
            buttonSignOut.isHidden = true
        }
        menuShowing = !menuShowing
        print("background hidden")
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        print("The user has signed out.")
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()}
}

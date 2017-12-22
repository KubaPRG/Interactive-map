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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate{
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
    
    // LOG IN SCREEN
    
    @IBOutlet var _username: MaxLengthTextField?
    @IBOutlet var _password: UITextField?
    @IBOutlet var _login_button: UIButton?
    
    
    // END OF LOG IN SCREEN
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mySpan:MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        let myLocation = self.locationManager.location?.coordinate
        let myRegion:MKCoordinateRegion = MKCoordinateRegionMake(myLocation!, mySpan)
        map.setRegion(myRegion, animated: true)
        
        // LOG IN SCREEN
        
        _password?.delegate = self
        _password?.tag = 1
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
            //self._username.layer.borderWidth = 1
            //self._password.layer.borderWidth = 1
        
        let preferences = UserDefaults.standard
        
        if(preferences.object(forKey: "session") != nil)
        {
            LoginDone()
        }
        else
        {
            LoginToDo()
        }
        
        
        // END OF LOG IN SCREEN
        
        
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
    
    // LOG IN SCREEN
    
    @IBAction func LoginButton(_ sender: Any) {
        if(_login_button?.titleLabel?.text == "Logout")
        {
            let preferences = UserDefaults.standard
            preferences.removeObject(forKey: "session")
            
            LoginToDo()
            return
        }
        
        
        let username = _username?.text
        let password = _password?.text
        
        if(username == "" || password == "")
        {
            return
        }
        
        DoLogin(username!, password!)
    }
    
    func DoLogin(_ user:String, _ psw:String)
    {
        let url = URL(string: "http://www.kaleidosblog.com/tutorial/login/get.txt")
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let paramToSend = "username=" + user + "&password=" + psw
        
        request.httpBody = paramToSend.data(using: String.Encoding.utf8)
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            guard let _:Data = data else
            {
                return
            }
            
            let json:Any?
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
                return
            }
            
            
            guard let server_response = json as? NSDictionary else
            {
                return
            }
            
            
            if let data_block = server_response["data"] as? NSDictionary
            {
                if let session_data = data_block["session"] as? String
                {
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async (
                        execute:self.LoginDone
                    )
                }
            }
            
        })
        
        task.resume()
    }
    
    func LoginToDo()
    {
        _username?.isEnabled = true
        _password?.isEnabled = true
        
        _login_button?.setTitle("Log In", for: .normal)
    }
    
    func LoginDone()
    {
        _username?.isEnabled = false
        _password?.isEnabled = false
        
        _login_button?.setTitle("Logout", for: .normal)
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // END OF LOG IN SCREEN
    
    
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
    
    @IBAction func openBg(_ sender: Any) {
        if (!menuShowing){
            darkBgConst.constant = 0
            UIView.animate(withDuration: 0.0, animations: {
                self.view.layoutIfNeeded()})
            buttonMenu.isHidden = true
            buttonExitMenu.isHidden = false
        }
    }
    // Opens Background when button pressed
    
    @IBAction func closeBg(_ sender: Any) {
        if (menuShowing) {
            darkBgConst.constant = 1000
            buttonExitMenu.isHidden = true
            buttonMenu.isHidden = false
        }
    }
    
    // Closes Background when button pressed
    
    @IBAction func openMenu(_ sender: Any) {
    if (!menuShowing){
            menuLeadingConst.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    // Opens Menu when button pressed
    
    @IBAction func closeMenu(_ sender: Any) {
        if (menuShowing) {
            menuLeadingConst.constant = -300
        }
        menuShowing = !menuShowing
    }
    // Closes Menu when button pressed
    
    @IBAction func hideOnBgTap(_ sender: UIGestureRecognizer) {
        if (menuShowing) {
            menuLeadingConst.constant = -300
            darkBgConst.constant = 1000
            buttonMenu.isHidden = false
            buttonExitMenu.isHidden = true
        }
        menuShowing = !menuShowing
    }
    // Closes menu when background tapped
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()}
}

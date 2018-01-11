//
//  SettingsViewController.swift
//  Interactive map
//
//  Created by Jakub Kulakowski on 1/11/18.
//  Copyright © 2018 Jakub Kulakowski. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var darkBg: UIView!
    @IBOutlet weak var menu: UIView!
    
    @IBOutlet weak var menuLeadingConst: NSLayoutConstraint!
    @IBOutlet weak var darkBgConst: NSLayoutConstraint!
    var menuShowing = false
    
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var buttonExitMenu: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.layer.shadowOpacity = 1
        menu.layer.shadowRadius = 8
        
        buttonMenu.isHidden = false
        buttonExitMenu.isHidden = true
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
    
    // Closes Menu when button pressed
    @IBAction func closeMenu(_ sender: Any) {
        if (menuShowing) {
            hideMenu()
        }
        menuShowing = !menuShowing
    }
    
    // Closes Background when button pressed
    @IBAction func closeBg(_ sender: Any) {
        if (menuShowing) {
            hideBg()
            buttonExitMenu.isHidden = true
            buttonMenu.isHidden = false
        }
    }
    
    // Closes menu & Bg when background tapped
    @IBAction func hideOnBgTap(_ sender: UIGestureRecognizer) {
        if (menuShowing) {
            hideBg()
            hideMenu()
            buttonMenu.isHidden = false
            buttonExitMenu.isHidden = true
        }
        menuShowing = !menuShowing
    }
    
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
    
    //Sign Out
    @IBAction func didTapSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        print("The user has signed out.")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
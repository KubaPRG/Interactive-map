//
//  Tutorial.swift
//  Sign In
//
//  Created by Jakub Kulakowski on 1/9/18.
//  Copyright © 2018 Jakub Kulakowski. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
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
    
    // Closes Menu & Bg when Exit button pressed
    @IBAction func closeMenu(_ sender: Any) {
        hideBoth()
    }
    
    // Closes Menu & Bg when Report Issue pressed
    @IBAction func helpButtonPressed(_ sender: Any) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

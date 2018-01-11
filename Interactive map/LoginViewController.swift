//
//  ViewController.swift
//  Sign In
//
//  Created by Jakub Kulakowski on 1/3/18.
//  Copyright © 2018 Jakub Kulakowski. All rights reserved.
//

import UIKit

var dismissal: UIViewController?

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var myLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        dismissal = self
        
        let labelUnderSignIn = NSMutableAttributedString(string:"By tapping Sign In, I agree to Phins' Bikes' Terms of Service, and Privacy Policy.")
        let termsLink = labelUnderSignIn.setAsLink(textToFind: "Terms of Service", linkURL: "http://google.com")
        if termsLink {
            // adjust more attributedString properties
        }
        let privacyLink = labelUnderSignIn.setAsLink(textToFind: "Privacy Policy", linkURL: "http://youtube.com")
        if privacyLink {
            // adjust more attributedString properties
        }
        
        myLabel.attributedText = labelUnderSignIn
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


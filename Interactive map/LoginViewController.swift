//
//  ViewController.swift
//  Sign In
//
//  Created by Jakub Kulakowski on 1/3/18.
//  Copyright © 2018 Jakub Kulakowski. All rights reserved.
//

import UIKit
import SafariServices



class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var myLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        
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
    
    @IBAction func didTapLMC(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string:"https://www.lemoyne.edu")!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func didTapSGA(_ sender: Any) {
            let svc = SFSafariViewController(url: URL(string:"https://www.lemoyne.edu/Student-Life/Getting-Involved/Student-Government")!)
            self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func didTapLMZ(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string:"http://www.themakerinstitute.org")!)
        self.present(svc, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


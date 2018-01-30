//
//  CreatorsViewController.swift
//  Interactive map
//
//  Created by Jakub Kulakowski on 1/11/18.
//  Copyright © 2018 Jakub Kulakowski. All rights reserved.
//

import UIKit
import SafariServices

class CreatorsViewController: UIViewController {
    
    @IBAction func goBackToPreviousView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

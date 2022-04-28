//
//  ViewController.swift
//  MySdk-poc
//
//  Created by MAC on 4/28/22.
//

import UIKit
import EmtrustSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startReactNative(_ sender: Any) {
        EmtrustSDK.generateSecretPhrase.printBase64();
    }
    
}


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

  
    @IBAction func generateDid(_ sender: Any) {
        EmtrustSDK.generate().secretPhrase(completionHandlerSdk: {(success, data) -> Void in
        // When call api completes,control flow goes here.
        if success {
            // call api success
            EmtrustSDK.generate().did(secretPhrase: data as! String);
           
        } else {
            // call api fail
            print("error")
        }
    });
    }
    @IBAction func decryptFile(_ sender: Any) {
        //EmtrustSDK.file().decrypt();
    }
    @IBAction func startReactNative(_ sender: Any) {
        EmtrustSDK.generate().secretPhrase(completionHandlerSdk: {(success, data) -> Void in
        // When call api completes,control flow goes here.
        if success {
            // call api success
            print("data secret phrases success \n", data)
           
        } else {
            // call api fail
            print("error")
        }
    });
    }
}


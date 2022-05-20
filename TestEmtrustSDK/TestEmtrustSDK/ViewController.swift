//
//  ViewController.swift
//  MySdk-poc
//
//  Created by MAC on 4/28/22.
//

import UIKit
import EmtrustSDK

class ViewController: UIViewController {
    private var didObject: ResponseMessage?
    private var didData: Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func initServer(_ sender: Any) {
        EmtrustSDK.generate().initServer()
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
    
    @IBAction func generateDid(_ sender: Any) {
        EmtrustSDK.generate().secretPhrase(completionHandlerSdk: {(success, data) -> Void in
        // When call api completes,control flow goes here.
        if success {
            // call api success
            EmtrustSDK.generate().did(secretPhrase: data as! String, completionHandlerSdk: {(success, data) -> Void in
                // When call api completes,control flow goes here.
                if success {
                    // call api success
                    let decoder = JSONDecoder()
                    do {
                        let message = try decoder.decode(ResponseMessage.self, from: data as! Data )
                        self.didObject = message
                        self.didData = data as? Data
                        print("identity:", message.message.identity)
                        print("privateKey:", message.message.privateKey)
                        print("publicKey:", message.message.publicKey)
                        print("secret:", message.message.secret)
                    } catch {
                        print(String(describing: error))
                    }
                } else {
                    // call api fail
                    print("error")
                }
            });
        } else {
            // call api fail
            print("error")
        }
    });
    }
    
    @IBAction func generateSignature(_ sender: Any) {
        print(didObject as Any)
        let jsonObject: [String: Any] = [
            "didObject": [
            "identity": didObject?.message.identity as Any,
            "privateKey": didObject?.message.privateKey as Any,
            "publicKey": didObject?.message.publicKey as Any,
            "secret": didObject?.message.secret as Any,
       
            "demographics": [
                "name": didObject?.message.demographics.name,
                "email": didObject?.message.demographics.email,
                "pic": didObject?.message.demographics.pic
                    ],
            "enrollStatus": didObject?.message.enrollStatus as Any
        ]
    ]
        
        let jsonData = (try? JSONSerialization.data(withJSONObject: jsonObject))!
        EmtrustSDK.generate().signature(jsonData: jsonData, completionHandlerSdk: {(success, data) -> Void in
            // When call api completes,control flow goes here.
            if success {
                // call api success
                print("data signature success \n", data)
            } else {
                // call api fail
                print("error")
            }
        });
    }
    
    @IBAction func decryptFile(_ sender: Any) {
        //EmtrustSDK.file().decrypt();
    }
}


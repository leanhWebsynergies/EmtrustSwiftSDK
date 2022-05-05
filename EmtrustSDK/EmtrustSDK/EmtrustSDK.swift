//
//  EmtrustSDK.swift
//  EmtrustSDK
//
//  Created by MAC on 4/28/22.
//

import Foundation
import UIKit
public class generate {
    public typealias CompletionHandlerSDK = (_ success:Bool, _ data: Any) -> Void
    public init() {
        var nodejsThread: Thread? = nil
            nodejsThread = Thread(
                target: self,
                selector: #selector(startNode),
                object: nil)
            // Set 2MB of stack space for the Node.js thread.
            nodejsThread?.stackSize = 2 * 1024 * 1024
            nodejsThread?.start()
    }
    public func secretPhrase( completionHandlerSdk: @escaping CompletionHandlerSDK) {
        var bytes = [Int8](repeating: 0, count: 32)
        // Fill bytes with secure random data
        let status = SecRandomCopyBytes(
            kSecRandomDefault,
            32,
            &bytes
        )
        // A status of errSecSuccess indicates success
        if status == errSecSuccess {
            print("byte", bytes)
            let data = NSData(bytes: bytes, length: bytes.count)
            let base64Data = data.base64EncodedData(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
            let newNSString = NSString(data: base64Data as Data, encoding: String.Encoding.utf8.rawValue)!

            print("new base 64", newNSString)
              
            let parameters: [NSString: Any] = ["msg": newNSString]
            let jsonData = (try? JSONSerialization.data(withJSONObject: parameters))!
            NetworkHandler().httpPostStringResult(jsonData: jsonData, des: "generate-secret", completionHandler: { (success, data) -> Void in
                // When call api completes,control flow goes here.
                if success {
                    let flag = true
                    completionHandlerSdk(flag, data)
                } else {
                    // call api fail
                    print("error")
                }
            })
        }
    }
    
    public func did(secretPhrase: String) {
        let parameters: [NSString: Any] = ["secret": secretPhrase]
        let jsonData = (try? JSONSerialization.data(withJSONObject: parameters))!
        NetworkHandler().httpPostJSONResult(jsonData: jsonData, des: "generate-did",  completionHandler: { (success, data) -> Void in
            // When call api completes,control flow goes here.
            if success {
                // call api success
                print("data did success", data)
            } else {
                // call api fail
                print("error")
            }
        })
    }
    public func signature(jsonData: Data) {
        print("generate-signature")
        NetworkHandler().httpPostStringResult(jsonData: jsonData, des: "generate-signature", completionHandler: { (success, data) -> Void in
            // When call api completes,control flow goes here.
            if success {
                // call api success
                print("data success \n", data)
            } else {
                // call api fail
                print("error")
            }
        })
    }
    @objc func startNode() {
        let srcPath = "/Users/mac/Desktop/demo-test/SDK/EmtrustSwiftSDK/EmtrustSDK/emtrustlib/main.js"
        let nodeArguments = ["node", srcPath]
        //NodeRunner.startEngine(withArguments: nodeArguments as [Any])
        NodeRunner.startEngine(withArguments: nodeArguments)
    }
}
public class file {
    public init() {}
    public func decrypt(jsonData: Data) {
        print("decrypt")
        NetworkHandler().httpPostStringResult(jsonData: jsonData, des: "decrypt-file", completionHandler: { (success, data) -> Void in
            // When call api completes,control flow goes here.
            if success {
                // call api success
                print("data success \n", data)
            } else {
                // call api fail
                print("error")
            }
        })
    }
    
    public func encrypt(jsonData: Data) {
        print("encrypt")
        NetworkHandler().httpPostStringResult(jsonData: jsonData, des: "encrypt-file", completionHandler: { (success, data) -> Void in
            // When call api completes,control flow goes here.
            if success {
                // call api success
                print("data success \n", data)
            } else {
                // call api fail
                print("error")
            }
        })
    }
}


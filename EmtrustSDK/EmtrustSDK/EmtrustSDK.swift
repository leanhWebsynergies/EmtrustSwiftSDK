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
    public init() {}
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


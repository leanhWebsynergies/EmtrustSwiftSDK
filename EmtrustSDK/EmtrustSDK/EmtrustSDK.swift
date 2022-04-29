//
//  EmtrustSDK.swift
//  EmtrustSDK
//
//  Created by MAC on 4/28/22.
//

import Foundation
public class generateSecretPhrase {
    public init() {}
    public class func printBase64() {
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
           
              
              // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid
              
              let parameters: [NSString: Any] = ["msg": newNSString]
              let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
              // create the url with URL
              let url = URL(string: "http://192.168.131.110:3000/crypto/generate-secret")! // change server url accordingly
              
              // create the session object
             
              
              // now create the URLRequest object using the url object
              var request = URLRequest(url: url)
              request.httpMethod = "POST" //set http method as POST
              
            request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                     guard let data = data, error == nil else {
                         print(error?.localizedDescription ?? "No data")
                         return
                     }
//                     let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                     if let responseJSON = responseJSON as? [String: Any] {
//                         print(responseJSON) //Code after Successfull POST Request
//                     }
                    let responseJSON =  String(data: data, encoding: .utf8)!
                    print("new secret phrases: \n", responseJSON) //Code after Successfull POST Request
                 }

                 task.resume()
            
        }
    }
}

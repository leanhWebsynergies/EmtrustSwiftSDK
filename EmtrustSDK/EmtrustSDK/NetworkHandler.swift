//
//  NetworkHandler.swift
//  EmtrustSDK
//
//  Created by MAC on 4/29/22.
//

import Foundation
public class NetworkHandler {
    public init() {}
    
    typealias CompletionHandler = (_ success:Bool, _ data: Any) -> Void
    
    func httpPostStringResult(jsonData: Data, des: String, completionHandler: @escaping CompletionHandler) {
        var responseJSON  = ""
        if !jsonData.isEmpty {
            let url = URL(string: "http://192.168.131.110:3000/crypto/" + des)! // change server url accordingly
              
              // now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST
              
            request.setValue("\(String(describing: jsonData.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                     guard let data = data, error == nil else {
                         print(error?.localizedDescription ?? "No data")
                         return
                     }
                    let flag = true
                    responseJSON.append(String(data: data, encoding: .utf8)!)
                    completionHandler(flag, responseJSON)
                 }
                task.resume()
            }
        }
    func httpPostJSONResult(jsonData: Data, des: String, completionHandler: @escaping CompletionHandler) {
        if !jsonData.isEmpty {
            let url = URL(string: "http://192.168.131.110:3000/crypto/" + des)! // change server url accordingly
              
              // now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST
              
            request.setValue("\(String(describing: jsonData.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                     guard let data = data, error == nil else {
                         print(error?.localizedDescription ?? "No data")
                         return
                     }
                     let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    let flag = true
              
                     if let responseJSON = responseJSON as? [String: Any] {
                        completionHandler(flag, responseJSON)
                     }
                 }
                task.resume()
            }
        }
}

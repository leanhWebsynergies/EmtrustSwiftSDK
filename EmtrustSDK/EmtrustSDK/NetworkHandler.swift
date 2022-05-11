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
        let addr = getWiFiAddress()
        print(addr!)
        if !jsonData.isEmpty {
            let url = URL(string: "http://"+addr!+":3000/crypto/" + des)! // change server url accordingly
              
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
        let addr = getWiFiAddress()
        if !jsonData.isEmpty {
            let url = URL(string: "http://"+addr!+":3000/crypto/" + des)! // change server url accordingly
              
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
             
               // let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                let flag = true
                completionHandler(flag, data)
            }
                task.resume()
            }
        }
    
    func getWiFiAddress() -> String? {
        var address : String?

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
    }
}

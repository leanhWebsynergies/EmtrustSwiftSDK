//
//  ResponseMessage.swift
//  TestEmtrustSDK
//
//  Created by MAC on 5/11/22.
//

import Foundation
struct ResponseMessage: Codable {
    var message: Message
}
struct Message: Codable {
    var demographics: Demographics
    var enrollStatus: Bool
    var identity: String
    var privateKey: String
    var publicKey: String
    var secret: String
}
struct Demographics: Codable {
    var email: String
    var name: String
    var pic: String
}

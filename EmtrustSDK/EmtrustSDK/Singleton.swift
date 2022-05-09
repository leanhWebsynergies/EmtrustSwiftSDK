//
//  Singleton.swift
//  EmtrustSDK
//
//  Created by MAC on 5/9/22.
//

import Foundation
final class Singleton {
    static let shared = Singleton()
    private init(){
        var nodejsThread: Thread? = nil
            nodejsThread = Thread(
                target: self,
                selector: #selector(startNode),
                object: nil)
            // Set 2MB of stack space for the Node.js thread.
            nodejsThread?.stackSize = 2 * 1024 * 1024
            nodejsThread?.start()
    }
    var count = 0
    @objc func startNode() {
        let srcPath = "/Users/mac/Desktop/demo-test/SDK/EmtrustSwiftSDK/EmtrustSDK/emtrustlib/main.js"
        let nodeArguments = ["node", srcPath]
        //NodeRunner.startEngine(withArguments: nodeArguments as [Any])
        NodeRunner.startEngine(withArguments: nodeArguments)
    }
}

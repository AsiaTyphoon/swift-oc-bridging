//
//  River.swift
//  oclib
//
//  Created by dfsx6 on 2021/4/7.
//

import UIKit
import oclibsub

open class River: NSObject {

    public func printBridge() {
        let brige = Bridge.init()
        print("I have a", NSStringFromClass(brige.classForCoder))
        
        BridgePrivate.init().printSelf()
        
    }
}

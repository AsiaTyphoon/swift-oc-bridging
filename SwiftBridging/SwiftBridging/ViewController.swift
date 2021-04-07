//
//  ViewController.swift
//  SwiftBridging
//
//  Created by dfsx6 on 2021/4/6.
//

import UIKit
import oclib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testoc.init().printSelf()
        River.init().printBridge()
        Bridge.init().printSelf()
    }


}


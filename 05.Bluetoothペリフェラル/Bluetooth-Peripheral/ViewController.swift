//
//  ViewController.swift
//  Bluetooth-Peripheral
//
//  Created by OE Hi Loki on 2018/01/01.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DebugInfoDelegate {
    var _peripheral: BTPeripheral? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _peripheral = BTPeripheral(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func show(_ s: String) {
        let text = self.view! as! UITextView
        text.text = text.text + s + "\n"
        print(s)
    }
}



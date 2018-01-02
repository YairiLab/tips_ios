//
//  ViewController.swift
//  Bluetooth-Central
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DebugInfoDelegate {
    var _central: BTCentral!
    @IBOutlet weak var _debugLabel: UITextView!

    @IBAction func scan(_ sender: UIButton) {
        _central.scan()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let date = Date()
        _central.submit(s: "今は\(date.description)です")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        _central = BTCentral(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func show(_ s: String) {
        print(s)
        _debugLabel.text = _debugLabel.text + s + "\n"
    }
    
}

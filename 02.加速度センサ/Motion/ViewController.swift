//
//  ViewController.swift
//  Motion
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let _motionManager = YLMotionManager()
    var _timer: Timer?
    
    @IBOutlet weak var _accLabel: UILabel!
    @IBOutlet weak var _rotLabel: UILabel!
    
    @IBAction func sensorSwitch(_ sender: UISwitch) {
        if sender.isOn {
            _motionManager.start()
            timerStart()
        } else {
            _motionManager.stop()
            _timer?.invalidate()
            _timer = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func timerStart() {
        _timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            let (acc, rot) = self._motionManager.getDataDescriptions()
            self._accLabel.text = acc
            self._rotLabel.text = rot
        })
    }
}


//
//  ViewController.swift
//  Audio
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var synth: YLSpeechSynthesizer! = nil
    var player: YLAudioPlayer! = nil
    
    @IBAction func play(_ sender: UIButton) {
        player.play()
    }
    
    @IBAction func say(_ sender: UIButton) {
        let date = Date()
        synth.speak("今は\(date.description)です")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        synth = YLSpeechSynthesizer()
        player = YLAudioPlayer(resourceName: "cars", type: "m4a")
    }

    
}


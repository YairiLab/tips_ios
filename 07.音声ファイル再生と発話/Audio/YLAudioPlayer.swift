//
//  YLAudioPlayer.swift
//  Audio
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import Foundation
import AVFoundation

class YLAudioPlayer {
    let player: AVAudioPlayer
    
    init(resourceName: String, type: String) {
        let url = Bundle.main.url(forResource: resourceName, withExtension: type)!
        let data = try! Data(contentsOf: url, options: [])
        player = try! AVAudioPlayer(data: data)
        player.volume = 1
    }
    
    func play() {
        let dt = player.duration - player.currentTime
        if !player.isPlaying {
            player.play()
        } else if dt < 0.8 {
            stop()
            player.play()
        }
    }
    
    func stop() {
        player.stop()
        player.currentTime = 0
    }
}

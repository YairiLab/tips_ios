//
//  YLSpeechSynthesizer.swift
//  Audio
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import Foundation
import AVFoundation

class YLSpeechSynthesizer {
    let speaker = AVSpeechSynthesizer()
    
    func speak(_ s: String) {
        if speaker.isSpeaking {
            speaker.stopSpeaking(at: .immediate)
        }
        let ut = AVSpeechUtterance(string: s)
        ut.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        ut.rate = 0.5
        speaker.speak(ut)
    }
}

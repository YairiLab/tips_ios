//
//  ViewController.swift
//  CameraPreview
//
//  Created by OE Hi Loki on 2018/01/03.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var _session = AVCaptureSession()
    
    override func viewDidLoad() {
        let camera = AVCaptureDevice.default(for: .video)
        let input = try! AVCaptureDeviceInput(device: camera!)
        _session.addInput(input)
        
        let viewFrame = view.frame
        let videoLayer = AVCaptureVideoPreviewLayer(session: _session)
        videoLayer.frame = CGRect(x: 20, y: 20,
                                  width: viewFrame.width-40, height: viewFrame.height-40)
        videoLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoLayer)
        
        _session.startRunning()
    }
}

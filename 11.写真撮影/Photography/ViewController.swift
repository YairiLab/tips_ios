//
//  ViewController.swift
//  Photography
//
//  Created by OE Hi Loki on 2018/01/03.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let _photo   = YLPhotoManager()
    let _session = AVCaptureSession()
    let _output  = AVCapturePhotoOutput()
    
    @IBAction func onClick(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings()
        _output.capturePhoto(with: settings, delegate: _photo)
    }
    
    override func viewDidLoad() {
        _photo.ensurePermission()
        
        let camera = AVCaptureDevice.default(for: .video)
        let input = try! AVCaptureDeviceInput(device: camera!)
        _session.addInput(input)
        _session.addOutput(_output)
        
        let viewFrame = view.frame
        let videoLayer = AVCaptureVideoPreviewLayer(session: _session)
        videoLayer.frame = CGRect(x: 20, y: 80,
                                  width: viewFrame.width-40, height: viewFrame.height-100)
        videoLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoLayer)
        
        _session.startRunning()
    }

}

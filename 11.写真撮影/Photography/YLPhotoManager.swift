//
//  YLPhotoManager.swift
//  Photography
//
//  Created by OE Hi Loki on 2018/01/03.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import Foundation
import Photos

class YLPhotoManager: NSObject, AVCapturePhotoCaptureDelegate {
    func ensurePermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ status in
                if status == .authorized {
                    print("許可されました")
                } else {
                    print("許可されませんでした")
                }
            })
        }
    }

    // 写真を撮り終わって、画像処理ができたら呼ばれる
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let data = photo.fileDataRepresentation()
        let image = UIImage(data: data!)
        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
    }

}

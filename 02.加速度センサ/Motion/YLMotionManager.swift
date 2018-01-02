//
//  YLMotionManager.swift
//  Motion
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import Foundation
import CoreMotion

typealias Vector3D = (Double, Double, Double)

class YLMotionManager {
    private let _motion = CMMotionManager()
    
    func start() {
        _motion.startAccelerometerUpdates()
        _motion.startGyroUpdates()
    }
    
    func stop() {
        _motion.stopAccelerometerUpdates()
        _motion.stopGyroUpdates()
    }
    
    func getAcceleration() -> Vector3D? {
        if let data = _motion.accelerometerData {
            let a = data.acceleration
            return (a.x, a.y, a.z)
        } else {
            return nil
        }
    }
    
    func getRotationRate() -> Vector3D? {
        if let data = _motion.gyroData {
            let r = data.rotationRate
            return (r.x, r.y, r.z)
        } else {
            return nil
        }
    }
    
    func getData() -> (Vector3D?, Vector3D?) {
        return (rot: getRotationRate(), acc: getAcceleration())
    }
    
    func getDataDescriptions() -> (String, String) {
        let (acc, rot) = getData()
        let accDesc = acc == nil ? "unavailable" :
            NSString(format: "%10.3f %10.3f %10.3f", acc!.0, acc!.1, acc!.2) as String
        let rotDesc = rot == nil ? "unavailable" :
            NSString(format: "%10.3f %10.3f %10.3f", rot!.0, rot!.1, rot!.2) as String
        return (accDesc, rotDesc)
    }
    
}

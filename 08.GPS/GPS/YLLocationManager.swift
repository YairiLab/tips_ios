//
//  YLLocationManager.swift
//  GPS
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import Foundation
import CoreLocation

class YLLocationManager: NSObject, CLLocationManagerDelegate {
    let _manager = CLLocationManager()
    let _delegate: YLCoordinateDelegate!
    var _coordinate: CLLocationCoordinate2D?
    
    init(delegate: YLCoordinateDelegate) {
        _delegate = delegate
        super.init()
        _manager.delegate = self
    }
    
    func start() {
        _manager.requestWhenInUseAuthorization()
        CLLocationManager.locationServicesEnabled()
        _manager.startUpdatingLocation()
    }
    
    func stop() {
        _manager.stopUpdatingLocation()
    }
    
    // 位置情報を取る許可が変わったら呼ばれる
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            _delegate.alert("位置情報の取得が許可されました")
        case .denied:
            _delegate.alert("位置情報の取得を拒否されました\n設定し直してください")
        default:
            _delegate.alert("位置情報の許可でよくわからない状況")
        }
    }
    // 位置が変化したら呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let l = locations.first {
            _coordinate = l.coordinate
            _delegate.coordinateUpdated(l.coordinate)
        }
    }
    
    func getCoordinate() -> CLLocationCoordinate2D? {
        return _coordinate
    }
}

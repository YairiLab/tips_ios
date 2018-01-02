//
//  ViewController.swift
//  GPS
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, YLCoordinateDelegate {
    var _locationManager: YLLocationManager!
    
    @IBOutlet weak var _coordLabel: UILabel!
    @IBOutlet weak var _map: MKMapView!
    
    @IBAction func locationSwitch(_ sender: UISwitch) {
        if sender.isOn {
            _locationManager.start()
        } else {
            _locationManager.stop()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _locationManager = YLLocationManager(delegate: self)
        _initMap()
    }

    func coordinateUpdated(_ coord: CLLocationCoordinate2D) {
        let s = NSString(format: "%9.4f %9.4f", coord.latitude, coord.longitude) as String
        print(s)
        _coordLabel.text = s
    }
    
    func alert(_ s: String) {
        print(s)
        _coordLabel.text = s
    }
    
    private func _initMap() {
        let userCoord = _map.userLocation.coordinate
        _map.setCenter(userCoord, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: userCoord, span: span)
        _map.setRegion(region, animated: true)
        _map.userTrackingMode = .followWithHeading
    }
}

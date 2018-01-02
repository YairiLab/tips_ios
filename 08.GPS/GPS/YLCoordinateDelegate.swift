//
//  YLCoordinateDelegate.swift
//  GPS
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import Foundation
import CoreLocation

protocol YLCoordinateDelegate {
    func coordinateUpdated(_ coord: CLLocationCoordinate2D)
    func alert(_ s: String)
}

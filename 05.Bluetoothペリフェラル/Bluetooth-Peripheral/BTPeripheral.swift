//
//  BTPeripheral.swift
//  Bluetooth-Peripheral
//
//  Created by OE Hi Loki on 2018/01/01.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import CoreBluetooth

class BTPeripheral: NSObject, CBPeripheralManagerDelegate {
    let _charUuid = CBUUID(string: "EA644349-F3DC-48C9-BD8C-4394434A21C0")
    let _servUuid = CBUUID(string: "47603621-4AE3-4E44-92D9-64688AD8D6FB")
    
    let _manager: CBPeripheralManager!
    let _service: CBMutableService!
    let _characteristic: CBCharacteristic!
    let _debugDelegate: DebugInfoDelegate!
    
    init(delegate: DebugInfoDelegate) {
        _debugDelegate = delegate
        _manager = CBPeripheralManager(delegate: nil, queue: nil, options: nil)
        _characteristic = CBMutableCharacteristic(
            type:        _charUuid,
            properties:  .write,
            value:       nil,
            permissions: .writeable)
        let service = CBMutableService(type: _servUuid, primary: true)
        service.characteristics = [_characteristic]
        _service = service
        super.init()
        _manager.delegate = self
    }
    
    func startAdvertising() {
        let data = [CBAdvertisementDataServiceUUIDsKey: [_servUuid]]
        _manager.startAdvertising(data)
    }
    
    func stopAdvertising() {
        _manager.stopAdvertising()
    }

    // CBPeripheralManagerがインスタンス化され、状態が変わったら呼ばれる。
    // これができていないと、startAdvertising()してもダメ。
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        _manager.add(_service)
        startAdvertising()
    }
    
    // 宣伝を開始したら呼ばれる
    func peripheralManagerDidStartAdvertising(
        _ peripheral: CBPeripheralManager, error: Error?) {
        if let e = error {
            _debugDelegate.show(e.localizedDescription)
        } else {
            _debugDelegate.show("宣伝開始")
        }
    }
    
    // セントラルからデータが書き込まれたら呼ばれる
    func peripheralManager(
        _ peripheral: CBPeripheralManager,
        didReceiveWrite requests: [CBATTRequest]) {
        let req = requests.first!
        let s = NSString(data: req.value!, encoding: String.Encoding.utf8.rawValue)!
        _debugDelegate.show("データ受信: \"\(s)\" (\(req.central.identifier)から)")
        _manager.respond(to: req, withResult: .success)
    }

}

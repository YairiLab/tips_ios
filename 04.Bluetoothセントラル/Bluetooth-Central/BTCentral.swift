//
//  BTCentral.swift
//  Bluetooth-Central
//
//  Created by OE Hi Loki on 2018/01/02.
//  Copyright © 2018 Yairi Lab. All rights reserved.
//

import Foundation
import CoreBluetooth

class BTCentral: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    let _servUuid = CBUUID(string: "47603621-4AE3-4E44-92D9-64688AD8D6FB")
    let _charUuid = CBUUID(string: "EA644349-F3DC-48C9-BD8C-4394434A21C0")
    let _central: CBCentralManager
    var _peripheral: CBPeripheral? = nil
    var _characteristic: CBCharacteristic? = nil
    let _debugDelegate: DebugInfoDelegate

    init(delegate: DebugInfoDelegate) {
        _central = CBCentralManager(delegate: nil, queue: nil)
        _debugDelegate = delegate
        super.init()
        _central.delegate = self
    }
    
    func scan() {
        _central.scanForPeripherals(
            withServices: [_servUuid], options: nil)
    }
    
    func submit(s: String) {
        _peripheral!.writeValue(
            s.data(using: String.Encoding.utf8)!,
            for: _characteristic!,
            type: .withResponse)
    }
    
    // インスタンス化して、ペリフェラルの状態が変わったら呼ばれる
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            _debugDelegate.show("セントラルが準備完了")
        } else {
            _debugDelegate.show("何か異常")
        }
    }
    
    // スキャンでペリフェラルが見つかったら呼ばれる
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi: NSNumber) {
        print("ペリフェラルを発見: \(String(describing: peripheral.name))")
        peripheral.delegate = self
        _peripheral = peripheral
        
        // 続いて接続
        central.connect(peripheral, options: nil)
        print("ペリフェラルに接続中...")
    }
    
    // ペリフェラルと接続に成功したら呼ばれる
    func centralManager(_ central: CBCentralManager,
                        didConnect peripheral: CBPeripheral) {
        _debugDelegate.show("ペリフェラルと接続: \(String(describing: peripheral.name))")
        
        // 続いてサービスの検索
        peripheral.discoverServices([_servUuid])
        _debugDelegate.show("サービスを検索中...")
    }
    
    // ペリフェラルのサービスが見つかったら呼ばれる
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let e = error {
            _debugDelegate.show(e.localizedDescription)
        } else {
            let s = peripheral.services!.first!
            _debugDelegate.show("サービス発見: \(s.uuid)")
            
            // 続いて、サービス特性の検索
            peripheral.discoverCharacteristics([_charUuid], for: s)
            _debugDelegate.show("特性を検索中...")
        }
    }
    
    // サービスの特性が見つかったら呼ばれる
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        if let e = error {
            _debugDelegate.show(e.localizedDescription)
        } else {
            _characteristic = service.characteristics!.first!
            _debugDelegate.show("特性を発見: \(_characteristic!.uuid)")
        }
    }
    
    // サービスに書き込んだ後に呼ばれる
    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        if let e = error {
            _debugDelegate.show(e.localizedDescription)
        } else {
            _debugDelegate.show("書き込み完了")
        }
    }
}

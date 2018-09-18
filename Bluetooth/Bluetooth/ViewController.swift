//
//  ViewController.swift
//  Bluetooth
//
//  Created by 이광용 on 2018. 1. 18..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import CoreBluetooth

//http://www.kevinhoyt.com/2016/05/20/the-12-steps-of-bluetooth-swift/
//https://styleshare.github.io/2015/11/05/estimator.html

struct PeripheralInfo{
    static let name = "HMSoft"
    static let service_UUID =
        CBUUID(string: "FFE0")
    static let scratch_UUID =
        CBUUID(string: "FFE1")
}

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate  {
//MARK -: Property
    //MARK : Device Name, UUID
    //MARK : Bluetooth Manager, Peripheral
    var manager:CBCentralManager!
    var peripheral:CBPeripheral!
    var character: CBCharacteristic?
    
//MARK -: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        self.manager.delegate = self
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        //블루투스 켜기/끄기 등의 상태확인 및 스캔
        switch central.state {
        case .unknown:
            print("The state of the BLE Manager is unknown.")
        case .resetting:
            print("The BLE Manager is resetting; a state update is pending.")
        case .unsupported:
            print("This device does not support Bluetooth Low Energy.")
        case .unauthorized:
            print("This app is not authorized to use Bluetooth Low Energy.")
        case .poweredOff:
            print("Bluetooth on this device is currently powered off.")
        case .poweredOn:
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let device = (advertisementData as NSDictionary).object(forKey: CBAdvertisementDataLocalNameKey) as? NSString
    
        print("Peripheral Name : \(advertisementData[CBAdvertisementDataLocalNameKey])")
        
        
        if device?.contains(PeripheralInfo.name) == true {
            self.manager.stopScan()
            self.peripheral = peripheral
            self.peripheral.delegate = self
            manager.connect(peripheral, options: nil)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print(RSSI)
    }
    
    func peripheralDidUpdateRSSI(_ peripheral: CBPeripheral, error: Error?) {
        print(peripheral.rssi)
        DispatchQueue.global(qos: .background).async {
            var timer = Timer()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.readRSSI), userInfo: nil, repeats: true)
        }
    }

    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)//peripheral의 Service 받기
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            
            let cbservcie = service as CBService
            print(cbservcie.uuid)
            if cbservcie.uuid == PeripheralInfo.service_UUID {
                peripheral.discoverCharacteristics(nil, for: cbservcie)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        //notifiction 설정
        for characteristic in service.characteristics! {
            let cbcharacteristic = characteristic as CBCharacteristic
            print(cbcharacteristic.uuid)
            if cbcharacteristic.uuid == PeripheralInfo.scratch_UUID {
                self.character = cbcharacteristic
                self.peripheral.setNotifyValue(true, for: cbcharacteristic) //주기적인 업데이트
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic.uuid)
//        var count:UInt8 = 1
//        //notification에 설정된 characteristic이 update될 때, 해당 delegate method 실행
//        if characteristic.uuid == PeripheralInfo.scratch_UUID {
//            if let data = characteristic.value {
//                data.copyBytes(to: &count, count: MemoryLayout<UInt8>.size)
//                print(count)
//            }
//        }
        
//        self.peripheral.readRSSI()
    }
    
    @objc func readRSSI() {
        self.peripheral.readRSSI()
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        central.scanForPeripherals(withServices: nil, options: nil)
    }
    
    @IBAction func sendDataAction(_ sender: UIButton) {
        let value: UInt8 = 0x01
        let data = Data(bytes: [value])
        if let character = self.character {
            peripheral.writeValue(data, for: character, type: .withoutResponse)
        }
    }
    
    
}


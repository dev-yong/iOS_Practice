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
    static let name = "Alert Notification"
    static let scratch_UUID =
        CBUUID(string: "a495ff21-c5b1-4b44-b512-1370f02d74de")
    static let service_UUID =
        CBUUID(string: "EA726ED0-8EEF-7E35-5C1F-B22B0DE33B1B")
    //    HMSoft
    //    EBCB2DE3-F4FF-C093-F2BA-E5F05490DAB1
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
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        peripheral.discoverServices(nil)//peripheral의 Service 받기
        peripheral.readRSSI()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print(RSSI)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            let cbservcie = service as CBService
            if cbservcie.uuid == PeripheralInfo.service_UUID {
                peripheral.discoverCharacteristics(nil, for: cbservcie)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        //notifiction 설정
        for characteristic in service.characteristics! {
            let cbcharacteristic = characteristic as CBCharacteristic
            if cbcharacteristic.uuid == PeripheralInfo.scratch_UUID {
                character = cbcharacteristic
                self.peripheral.setNotifyValue(true, for: cbcharacteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        var count:UInt8 = 0
        //notification에 설정된 characteristic이 update될 때, 해당 delegate method 실행
        if characteristic.uuid == PeripheralInfo.scratch_UUID {
            if let data = characteristic.value {
                data.copyBytes(to: &count, count: MemoryLayout<UInt8>.size)
                print(count)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        central.scanForPeripherals(withServices: nil, options: nil)
    }
    @IBAction func sendDataAction(_ sender: UIButton) {
        peripheral.writeValue(Data(), for: character!, type: .withResponse)
    }
    
    
}


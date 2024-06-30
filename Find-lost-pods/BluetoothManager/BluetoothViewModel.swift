//
//  BluetoothViewModel.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 29.06.2024.
//

import UIKit
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    @Published var devices: [BluetoothDevice] = []
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func foundDevices() -> [BluetoothDevice] {
        return devices
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        } else {
            let device1 = BluetoothDevice(name: "MI BAND 6", charge: "70%", coordinates: [37.7749, -122.4194], date: Date())
            let device2 = BluetoothDevice(name: "MI BAND 8", charge: "100%", coordinates: [37.7749, -122.4195], date: Date())
            
            self.devices.append(device1)
            self.devices.append(device2)

        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard !devices.contains(where: { $0.name == peripheral.name }) else {
            return
        }
        
        let device = BluetoothDevice(name: peripheral.name ?? "Unnamed Device",
                                     charge: "70%",
                                     coordinates: [37.7749, -122.4194],
                                     date: Date())
        
        DispatchQueue.main.async {
            self.devices.append(device)
        }
    }
}

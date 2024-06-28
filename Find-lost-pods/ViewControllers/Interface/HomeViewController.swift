import UIKit
import CoreBluetooth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var controlPanelView: UIView!
    @IBOutlet weak var helpCenterLabel: UILabel!
    
    var centralManager: CBCentralManager!
    var peripherals: [CBPeripheral] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlPanelView.layer.cornerRadius = 25
        helpCenterLabel.attributedText = underlineText(helpCenterLabel.text!)
        helpCenterLabel.textColor = .white
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startScanning()
        
    }
    
    func checkBluetoothAuthorization(_ central: CBCentralManager) {
            switch central.state {
            case .unknown:
                print("unknown")
            case .resetting:
                print("resetting")
            case .unsupported:
                print("unsupported")
            case .unauthorized:
                print("unauthorized")
            case .poweredOff:
                print("poweredOff")
                centralManager?.stopScan()
            case .poweredOn:
                print("poweredOn")
                centralManager?.scanForPeripherals(withServices: nil, options: nil)
            }
        }
    
    func startScanning() {
        let serviceUUIDs: [CBUUID]? = nil
        let options = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
        centralManager.scanForPeripherals(withServices: serviceUUIDs, options: options)
    }
    
    private func underlineText(_ text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        return attributedString
    }
}

extension HomeViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        checkBluetoothAuthorization(central)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
            print("Найдено устройство: \(peripheral)")
        }
    }
}

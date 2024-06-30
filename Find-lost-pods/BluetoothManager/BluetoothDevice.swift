//
//  BluetoothData.swift
//  Find-lost-pods
//
//  Created by Danil Dymytrov on 29.06.2024.
//

import Foundation

struct BluetoothDevice: Codable {
    var name: String
    var charge: String
    var coordinates: [Double]?
    var date: Date
}

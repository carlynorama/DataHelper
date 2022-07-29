//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation


func nilCatch(_ value:Double?) -> String {
    value.map { String($0) } ?? "No Value"
}

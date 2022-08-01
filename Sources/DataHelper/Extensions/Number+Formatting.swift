//
//  File.swift
//  
//
//  Created by Labtanza on 8/1/22.
//

import Foundation


extension Number {
    @inlinable
    func frmt() -> String {
        (String(format: "%.4f", self as Double))
    }
}

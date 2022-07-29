//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation

//public typealias DataPoint = (Number, Number)

public protocol DataPoint {
    x:Number { get }
    y:Number { get }
    asPoint:(Number, Number) { get }
}





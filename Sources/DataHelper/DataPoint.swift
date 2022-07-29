//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation

//public typealias DataPoint = (Number, Number)

public protocol DataPoint{
    var x:Number { get }
    var y:Number { get }
    var point:(x:Number, y:Number) { get }
    
    //init(x:Number, y:Number)
}

extension DataPoint {

    static func == (lhs: any DataPoint, rhs: any DataPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    public var description:String {
        String(format: "(%.2f, %.2f)", x, y)
    }

//    func hash(into hasher: inout Hasher) {
//        hasher.combine(x)
//        hasher.combine(y)
//    }
}

public struct Datum:DataPoint {
    
    public let x:Number
    public let y:Number
    
    public init(x: Number, y: Number) {
        self.x = x
        self.y = y
    }
    
    public var point:(x:Number, y:Number) {
        (x,y)
    }
    
}

public extension Datum {
    init(_ x:Number, _ y:Number) {
        self.x = x
        self.y = y
    }
    init(_ pair:(Number, Number)) {
        self.x = pair.0
        self.y = pair.1
    }
}


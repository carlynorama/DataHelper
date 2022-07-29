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

//extension DataPoint {
//    
//    static func == (lhs: any DataPoint, rhs: any DataPoint) -> Bool {
//        return lhs.x == rhs.x && lhs.y == rhs.y
//    }
//    
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(x)
//        hasher.combine(y)
//    }
//}

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


extension Array {
    
    /// Unzip an `Array` of key/value tuples.
    ///
    /// - Returns: A tuple with two arrays, an `Array` of keys and an `Array` of values.
    
    func unzipDataPoints() -> ([Number], [Number]) where Element == DataPoint {
        var inputs = [Number]()
        var results = [Number]()
        
        inputs.reserveCapacity(count)
        results.reserveCapacity(count)
        
        forEach { dp in
            inputs.append(dp.x)
            results.append(dp.y)
        }
        
        return (inputs, results)
    }
}






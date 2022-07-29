//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation

//public typealias DataPoint = (Number, Number)

public protocol DataPoint {
    var x:Number { get }
    var y:Number { get }
    var point:(x:Number, y:Number) { get }
}

public struct Datum:DataPoint {
    let x:Number
    let y:Number
    
    var point:(x:Number, y:Number) {
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

    func unzip<Number, Number>() -> ([Number], [Number]) where Element == DataPoint {
        var inputs = [Number]()
        var results = [Number]()

        inputs.reserveCapacity(count)
        results.reserveCapacity(count)

        forEach { x, y in
            inputs.append(x)
            results.append(y)
        }

        return (inputs, results)
    }
}






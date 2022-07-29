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






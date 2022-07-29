//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation


//https://stackoverflow.com/questions/46043902/opposite-of-swift-zip-split-tuple-into-two-arrays
extension Array {
    
    /// Unzip an `Array` of key/value tuples.
    ///
    /// - Returns: A tuple with two arrays, an `Array` of keys and an `Array` of values.

    func unzip<K, V>() -> ([K], [V]) where Element == (key: K, value: V) {
        var keys = [K]()
        var values = [V]()

        keys.reserveCapacity(count)
        values.reserveCapacity(count)

        forEach { key, value in
            keys.append(key)
            values.append(value)
        }

        return (keys, values)
    }
}

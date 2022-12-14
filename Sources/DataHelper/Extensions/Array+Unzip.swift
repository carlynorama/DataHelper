//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation


////https://stackoverflow.com/questions/46043902/opposite-of-swift-zip-split-tuple-into-two-arrays
extension Array {
    
    /// Unzip an `Array` of key/value tuples.
    ///
    /// - Returns: A tuple with two arrays, an `Array` of keys and an `Array` of values.
    func unzip<T1, T2>() -> ([T1], [T2]) where Element == (T1, T2) {
        var result = ([T1](), [T2]())
        
        result.0.reserveCapacity(self.count)
        result.1.reserveCapacity(self.count)
        
        return reduce(into: result) { acc, pair in
            acc.0.append(pair.0)
            acc.1.append(pair.1)
        }
    }
    
}

//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation



public extension Array where Element == DataPoint {
    
    /// Unzip an `Array` of key/value tuples.
    ///
    /// - Returns: A tuple with two arrays, an `Array` of keys and an `Array` of values.
    
    func unzipDataPoints() -> ([Number], [Number])  {
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
    
    func sortedByX() -> [DataPoint] {
        self.sorted{ $0.x < $1.x }
    }
    
    func sortedByY() -> [DataPoint] {
        self.sorted{ $0.y < $1.y }
    }
    
    func maxXPoint() -> DataPoint? {
        self.max{ $0.x < $1.x }
    }
    
    func maxYPoint() -> DataPoint? {
        self.max{ $0.y < $1.y }
    }
    
    func minXPoint() -> DataPoint? {
        self.min{ $0.x < $1.x }
    }
    
    func minYPoint() -> DataPoint? {
        self.min{ $0.y < $1.y }
    }
    
}






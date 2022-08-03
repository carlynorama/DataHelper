//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation
import Accelerate



public extension Array where Element == DataPoint {
    
    /// Unzip an `Array` of key/value tuples.
    ///
    /// - Returns: A tuple with two arrays, an `Array` of keys and an `Array` of values.
    
    func unzipDataPoints() -> (inputs:[Number], outputs:[Number])  {
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
    
    func findLine() -> (m:Number, b:Number) {
        let result = DataHelper.findLine(for: self)
        return (result.x, result.y)
    }
    
    func findQuadratic() -> (a2:Number, a1:Number, a0:Number) {
        let result = DataHelper.findQuadratic(for: self)
        return (result.x, result.y, result.z)
    }
    
    //TODO: Unit Test
    func findEtoX() -> (C:Number, A:Number) {
        let result = DataHelper.findEtoX(for: self)
        return (result.x, result.y)
    }
    
    func findLnX() -> (m:Number, b:Number) {
        let result = DataHelper.findlnx(for: self)
        return (result.x, result.y)
    }
    
    func findInverse() -> (m:Number, b:Number) {
        let result = DataHelper.findInverse(for: self)
        return (result.x, result.y)
    }
    
    func findInverseSquare() -> (m:Number, b:Number) {
        let result = DataHelper.findInverseSquare(for: self)
        return (result.x, result.y)
    }
    
    
}






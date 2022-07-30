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
    
    func findLine() -> (m:Number, b:Number) {
        let splitData = self.unzipDataPoints()
        
        let cx1_SigmaXk2:Number = 2
        let cy1_SigmaXk:Number = 4
        let cx2_SigmaXk:Number = -4
        let cy2_n:Number = 2
        
        let s1_SigmaXkYk:Number = 2
        let s2_SigmaYk:Number = 14
        
        let result = DataHelper.solveLinearPair(cx1: cx1_SigmaXk2, cy1: cy1_SigmaXk, s1: s1_SigmaXkYk, cx2: cx2_SigmaXk, cy2: cy2_n, s2: s2_SigmaYk)
        
        return (result.x, result.y)
    }
    
}






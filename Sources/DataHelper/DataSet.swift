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
        let splitData = self.unzipDataPoints()
        
        let cx1_SigmaXk2:Number = splitData.inputs.sumOfSquares()
        let cy1_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let cx2_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let cy2_n:Number = Double(self.count) as Number
        
        let xkyk = vDSP.multiply(splitData.inputs, splitData.outputs)
        
        let s1_SigmaXkYk:Number = xkyk.reduce(0, +)
        let s2_SigmaYk:Number = splitData.outputs.reduce(0, +)
        
        let result = DataHelper.solveLinearPair(cx1: cx1_SigmaXk2, cy1: cy1_SigmaXk, s1: s1_SigmaXkYk, cx2: cx2_SigmaXk, cy2: cy2_n, s2: s2_SigmaYk)
        
        return (result.x, result.y)
    }
    
}






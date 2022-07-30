//
//  File.swift
//  
//
//  Created by Labtanza on 7/30/22.
//

import Foundation
import Accelerate

public extension DataHelper {
    
    static func findLine(for data:[DataPoint]) -> SIMD2<Number> {
        let splitData = data.unzipDataPoints()
        let x1_SigmaXk2:Number = splitData.inputs.sumOfSquares()
        let y1_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let x2_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let y2_n:Number = Double(data.count) as Number
        
        let xkyk = vDSP.multiply(splitData.inputs, splitData.outputs)
        
        let r1_SigmaXkYk:Number = xkyk.reduce(0, +)
        let r2_SigmaYk:Number = splitData.outputs.reduce(0, +)
        
        let result = DataHelper.solveLinearPair(x1: x1_SigmaXk2, y1: y1_SigmaXk, r1: r1_SigmaXkYk, x2: x2_SigmaXk, y2: y2_n, r2: r2_SigmaYk)
        
        return result
    }
    
    static func findQuadratic(for data:[DataPoint]) -> SIMD4<Number> {
        let splitData = data.unzipDataPoints()
        let x1_SigmaXk2:Number = splitData.inputs.sumOfSquares()
        let y1_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let x2_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let y2_n:Number = Double(data.count) as Number
        
        let xkyk = vDSP.multiply(splitData.inputs, splitData.outputs)
        
        let r1_SigmaXkYk:Number = xkyk.reduce(0, +)
        let r2_SigmaYk:Number = splitData.outputs.reduce(0, +)
        
        let result = DataHelper.
        
        return result
    }
}

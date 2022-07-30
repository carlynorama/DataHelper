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
        let cx1_SigmaXk2:Number = splitData.inputs.sumOfSquares()
        let cy1_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let cx2_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let cy2_n:Number = Double(data.count) as Number
        
        let xkyk = vDSP.multiply(splitData.inputs, splitData.outputs)
        
        let s1_SigmaXkYk:Number = xkyk.reduce(0, +)
        let s2_SigmaYk:Number = splitData.outputs.reduce(0, +)
        
        let result = DataHelper.solveLinearPair(x1: cx1_SigmaXk2, y1: cy1_SigmaXk, r1: s1_SigmaXkYk, x2: cx2_SigmaXk, y2: cy2_n, r2: s2_SigmaYk)
        
        return result
    }
}

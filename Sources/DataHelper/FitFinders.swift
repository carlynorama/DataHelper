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
        
        let x1 = sigmaXk2:Number = splitData.inputs.sumOfSquares()
        let y1 = sigmaXk:Number = vDSP.sum(splitData.inputs)
        let x2 = sigmaXk
        let y2 = n:Number = Double(data.count) as Number
        
        let xkyk = vDSP.multiply(splitData.inputs, splitData.outputs)
        
        let r1 = sigmaXkYk:Number = vDSP.sum(xkyk)
        let r2 = sigmaYk:Number = vDSP.sum(splitData.outputs)
        
        let result = DataHelper.solveLinearPair(x1: x1, y1: y1, r1: r1,
                                                x2: x2, y2: y2, r2: r2)
        
        return result
    }
    
    static func findQuadratic(for data:[DataPoint]) -> SIMD3<Number> {
        let splitData = data.unzipDataPoints()
        let sigmaXk4:Number = splitData.inputs.map { pow($0, 4) }.reduce(0, +)
        let sigmaXk3:Number = splitData.inputs.map { pow($0, 3) }.reduce(0, +) //can't be vectorized w/ reduce use &+ is associative (overflow addition)
        let sigmaXk2:Number = splitData.inputs.sumOfSquares()  //wrapper around vDSP
        let sigmaXk:Number = splitData.inputs.reduce(0, +)
        let n:Number = Double(data.count) as Number
        
        let xkyk = vDSP.multiply(splitData.inputs, splitData.outputs)
        let sigmaXkYk:Number = xkyk.reduce(0, +)
        
        let xk2yk = vDSP.multiply(xkyk, splitData.inputs)
        let sigmaXk2Yk:Number = xk2yk.reduce(0, +)
        
        let sigmaYk:Number = splitData.outputs.reduce(0, +)
        
        let x1 = sigmaXk4
        let y1 = sigmaXk3
        let z1 = sigmaXk2
        
        let x2 = sigmaXk3
        let y2 = sigmaXk2
        let z2 = sigmaXk
        
        let x3 = sigmaXk2
        let y3 = sigmaXk
        let z3 = n
        
        let r1 = sigmaXk2Yk
        let r2 = sigmaXkYk
        let r3 = sigmaYk
        
        let result = DataHelper.solveQuadratic(eq1: (x1, y1, z1),
                                               eq2: (x2, y2, z2),
                                               eq3: (x3, y3, z3),
                                               resultants: (r1, r2, r3))
        
        return result
    }
    
    static func findEtoX(for data:[DataPoint]) {
        //Y = ln(y)
        //X = x
        //B = lnC
        
        //lny = ln(Ce^(Ax)) -> lnC + ln(e^(Ax)) -> B + Ax = Y
        
        let splitData = data.unzipDataPoints()
        
        let Y_values = splitData.outputs.map { log($0) }
        
        let sigmaXk2:Number = splitData.inputs.sumOfSquares()
        let sigmaXk:Number = vDSP.sum(splitData.inputs)
        
        
        let x1 = sigmaXk2
        let y1 = sigmaXk
        let x2_SigmaXk:Number = splitData.inputs.reduce(0, +)
        let y2_n:Number = Double(data.count) as Number
        
        let xkyk = vDSP.multiply(splitData.inputs, splitData.outputs)
        
        let r1_SigmaXkYk:Number = xkyk.reduce(0, +)
        let r2_SigmaYk:Number = splitData.outputs.reduce(0, +)
        
        let result = DataHelper.solveLinearPair(x1: x1_SigmaXk2, y1: y1_SigmaXk, r1: r1_SigmaXkYk, x2: x2_SigmaXk, y2: y2_n, r2: r2_SigmaYk)
    }
}

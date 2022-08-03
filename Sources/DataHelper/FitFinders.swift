//
//  File.swift
//  
//
//  Created by Labtanza on 8/2/22.
//

import Foundation
import Accelerate


public extension DataHelper {
    
    static func tryFit(for data:[DataPoint], using curve:CurveProfile) -> (description:String, values:Dictionary<String, Number>){
        curve.find(for: data)
    }
    
    static func findLine(for data:[DataPoint]) -> SIMD2<Number> {
        let splitData = data.unzipDataPoints()
        
        let sigmaxk2:Number = splitData.inputs.sumOfSquares()
        let sigmaxk:Number = vDSP.sum(splitData.inputs)
        
        let n:Number = Double(data.count) as Number
        
        let xkyk = vDSP.multiply(splitData.inputs, splitData.outputs)
        
        let sigmaxkyk:Number = vDSP.sum(xkyk)
        let sigmayk:Number = vDSP.sum(splitData.outputs)
        
        let x1 = sigmaxk2
        let y1 = sigmaxk
        let x2 = sigmaxk
        let y2 = n
        
        let r1 = sigmaxkyk
        let r2 = sigmayk
        
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
    
    static func findEtoX(for data:[DataPoint]) -> SIMD2<Number> {
        findNormalizingX(for: data, applying: log, inverse: exp)
    }
    
    static func findlnx(for data:[DataPoint]) -> SIMD2<Number>{
        findUpdatingX(for: data, applying: log)
    }
    
    static func findInverse(for data:[DataPoint]) -> SIMD2<Number> {
        findUpdatingX(for: data, applying: invert)
    }
    
    static func findInverseSquare(for data:[DataPoint]) -> SIMD2<Number> {
        findUpdatingX(for: data, applying: invertSquare)
    }
    
    static func findNormalizingX(for data:[DataPoint], applying function:(Number)->Number, inverse:(Number)->Number) -> SIMD2<Number> {
        
        //Y = f(y)
        //X = f( i(x) ) = x
        //B = f(C)   C = i(B)
        
        //example
        // y = Ce^(Ax)
        //so function = ln() b/c  ln(e^x) = x
        //apply to both sides
        //ln(y) = ln(Ce^(Ax))
        //pull appart terms: ln(x^y) = y * ln(x) https://www.rapidtables.com/math/algebra/Ln.html
        //ln(y) = ln(C) + A * ln(e^(x))
        //Y = B + Ax
        
        let splitData = data.unzipDataPoints()
        
        let Y_values = splitData.outputs.map { function($0) }
        
        let sigmaXk2:Number = splitData.inputs.sumOfSquares()
        let sigmaXk:Number = (splitData.inputs).sum()
        let n = Double(data.count) as Number
        let Xk_Y_k = vDSP.multiply(splitData.inputs, Y_values)
        let sigmaXk_Y_k:Number = Xk_Y_k.sum()
        let sigma_Y_k:Number = Y_values.sum()
        
        
        let x1 = sigmaXk2
        let y1 = sigmaXk
        let x2 = sigmaXk
        let y2 = n
        
        let r1 = sigmaXk_Y_k
        let r2 = sigma_Y_k
        
        let result = DataHelper.solveLinearPair(x1: x1, y1: y1, r1: r1,
                                                x2: x2, y2: y2, r2: r2)
        print(result)
        let A = result.x
        let B = result.y
        
        return SIMD2(x: A, y: inverse(B))
    }
    
    
    static func findUpdatingX(for data:[DataPoint], applying function:(Number)->Number) -> SIMD2<Number>{
        
        //functions of the form m * f(x) + b = y can be solved by applying f to the data array
        
        //y = y
        //X = f(x)
        //b = b
        
        let splitData = data.unzipDataPoints()
        
        let X_values = splitData.inputs.map { function($0) }
        
        let sigma_X_k2:Number = X_values.sumOfSquares()
        let sigma_X_k:Number = vDSP.sum(X_values)
        
        let n:Number = Double(data.count) as Number
        
        let X_kyk = vDSP.multiply(X_values, splitData.outputs)
        
        let sigma_X_kyk:Number = vDSP.sum(X_kyk)
        let sigmayk:Number = vDSP.sum(splitData.outputs)
        
        let x1 = sigma_X_k2
        let y1 = sigma_X_k
        let x2 = sigma_X_k
        let y2 = n
        
        let r1 = sigma_X_kyk
        let r2 = sigmayk
        
        let result = DataHelper.solveLinearPair(x1: x1, y1: y1, r1: r1,
                                                x2: x2, y2: y2, r2: r2)
        print(result)
        let m = result.x
        let b = result.y
        
        return SIMD2(x: m, y: b)
    }
    
    static func simToArray(_ matrix:SIMD2<Number>) -> [Number] {
        [matrix.x, matrix.y]
    }
    static func simToArray(_ matrix:SIMD3<Number>) -> [Number] {
        [matrix.x, matrix.y, matrix.z]
    }
    
}

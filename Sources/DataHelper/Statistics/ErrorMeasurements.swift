//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Accelerate

extension Statistics {
    public struct ErrorMeasurements {
        //E∞(f) = max | f(xₖ) - yₖ |
        static public func maxError(f:(Number) -> Number, data:[DataPoint]) -> (value:Number, atPoint:Number) {
            print(data)
            
            let d_ins, d_outs = data.unzip()
            let f_outs = d_ins.map { value in f(value) }
            
            let delta:[Number] = vDSP.subtract(d_outs, f_outs)
            let maxPair = vDSP.indexOfMaximumMagnitude(delta)
            let dataPoint = data[maxPair.0]
            let value = maxPair.1

            return (value, dataPoint)
        }
    }
}

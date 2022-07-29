//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Accelerate

extension Statistics {
//    public struct ErrorMeasurements {
//        //E∞(f) = max | f(xₖ) - yₖ |
//        static public func maxError(f:(Number) -> Number, data:[DataPoint]) -> (value:Number, atPoint:DataPoint) {
//            print(data)
//
//            let unzipped = data.unzipDataPoints()
//            let f_outs = unzipped.0.map { value in f(value) }
//            
//            let delta:[Number] = vDSP.subtract(unzipped.1, f_outs)
//            let maxPair = vDSP.indexOfMaximumMagnitude(delta)
//            let dataPoint = data[Int(maxPair.0)]
//            let value = maxPair.1
//
//            return (value, dataPoint)
//        }
//        
//        static public func maxError(f:(Double) -> Double, data:[(Double, Double)]) -> (value:Double, atPoint:(Double, Double)) {
//            print(data)
//            
//            let unzipped = data.unzip()
//            let f_outs = unzipped.0.map { value in f(value) }
//            
//            let delta:[Number] = vDSP.subtract(unzipped.1, f_outs)
//            let maxPair = vDSP.indexOfMaximumMagnitude(delta)
//            let dataPoint = data[Int(maxPair.0)]
//            let value = maxPair.1
//
//            return (value, dataPoint)
//        }
//    }
}

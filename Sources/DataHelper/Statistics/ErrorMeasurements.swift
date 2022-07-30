//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Accelerate

extension Statistics {
    public struct ErrorMeasurements {
        
        public struct FitReport {
            public let maxError:Number
            public let maxErrorLocation:DataPoint
            public let meanError:Number
            public let meanErrorMagnitude:Number
            public let rmsError:Number
            public let sumOfSquares:Number
            
            public var description:String {
                """
                \(maxErrorDescription),
                \(meanErrorDescription),
                \(meanMagnitudeDescription),
                \(rmsDescription),
                \(sumSquaresDescription)
                """
            }
            
            public var maxErrorDescription:String {
                String(format: "max error of %.2f at location (%.2f, %.2f)", maxError, maxErrorLocation.x, maxErrorLocation.y)
            }
            
            public var meanErrorDescription:String {
                String(format: "mean error of %.2f", meanError)
            }
            
            public var meanMagnitudeDescription:String {
                String(format: "mean error magnitude is %.2f", meanErrorMagnitude)
            }
            
            public var rmsDescription:String {
                String(format: "rms is %.2f", rmsError)
            }
            
            public var sumSquaresDescription:String {
                String(format: "ε is %.2f", sumOfSquares)
            }
        }
        
        
        static public func generateFitReport(f:(Number) -> Number, data:[DataPoint]) -> FitReport{
            let maxResult = maxError(f: f, data: data)
            let meanResult = averageError(f: f, data: data)
            let rmsResult = rmsError(f: f, data: data)
            let sumSq = sumOfSquares(f: f, data: data)
            
            return FitReport(maxError: maxResult.value, maxErrorLocation: maxResult.atPoint, meanError: meanResult.mean, meanErrorMagnitude: meanResult.meanMagnitude, rmsError: rmsResult, sumOfSquares: sumSq)
        }
        
        //Array of differences
        static func delta(f:(Number) -> Number, data:[DataPoint]) -> [Number] {
            let unzipped = data.unzipDataPoints()
            let f_outs = unzipped.0.map { value in f(value) }
            let delta:[Number] = vDSP.subtract(unzipped.1, f_outs)
            
            return delta
        }
        
        //MARK: Max Error
        //E∞(f) = (1<k<n) max | f(xₖ) - yₖ |
        static public func maxError(f:(Number) -> Number, data:[DataPoint]) -> (value:Number, atPoint:DataPoint) {
            print(data)
            let delta = delta(f: f, data: data)
            let maxPair = vDSP.indexOfMaximumMagnitude(delta)
            let dataPoint = data[Int(maxPair.0)]
            let value = maxPair.1

            return (value, dataPoint)
        }

        static public func maxError(f:(Double) -> Double, data:[(Double, Double)]) -> (value:Double, atPoint:(Double, Double)) {
            print(data)

            let unzipped = data.unzip()
            let f_outs = unzipped.0.map { value in f(value) }

            let delta:[Number] = vDSP.subtract(unzipped.1, f_outs)
            let maxPair = vDSP.indexOfMaximumMagnitude(delta)
            let dataPoint = data[Int(maxPair.0)]
            let value = maxPair.1

            return (value, dataPoint)
        }
        
        //MARK: Mean Errors
        //E₁(f) = 1/n (n, k=1)Σ | f(xₖ) - yₖ |
        static public func averageError(f:(Number) -> Number, data:[DataPoint]) -> (mean: Number, meanMagnitude:Number) {
            let deltas = delta(f: f, data: data)
            return (deltas.mean(), deltas.meanMagnitude())
        }
        
        //MARK: Root Mean Square
        //E₂(f) = √( 1/n (n, k=1)Σ (f(xₖ) - yₖ)²)
        static public func rmsError(f:(Number) -> Number, data:[DataPoint]) -> Number {
            let deltas = delta(f: f, data: data)
            return deltas.rootMeanSquare()
        }
        
        //sometimes ε / epsilon - Sum of squares of residuals
        static public func sumOfSquares(f:(Number) -> Number, data:[DataPoint]) -> Number {
            let deltas = delta(f: f, data: data)
            return deltas.sumOfSquares()
        }
        
        
    }
}

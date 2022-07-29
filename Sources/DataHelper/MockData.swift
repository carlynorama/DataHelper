//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation


extension DataHelper {
    static public func testFunction(_ x:Number) -> Number {
        linear(x, m: 3, b: 2)
    }
    
    static public var testValues:[Number] {
        var values:[Number] = []
        for _ in 0...20 {
            values.append(Number.random(in: -10.0...10.0))
        }
        return values
    }
    
    static public func fuzzValue(_ x:Number, fuzzFactor:Number) -> Number {
        x + Number.random(in: -fuzzFactor...fuzzFactor)
    }
    
    static public func generateTestData() -> [DataPoint] {
        var resultArray:[DataPoint] = []
        for x in testValues {
//                guard let x = i as? Number else {
//                    throw DataError.notANumber
//                }
            let y = fuzzValue(testFunction(x), fuzzFactor: 2)
            let point = Datum(x: x, y: y)
            resultArray.append(point)
        }
        return resultArray
    }
}

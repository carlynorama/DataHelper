//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation


extension DataHelper {
    static public func testLinearFunction(_ x:Number) -> Number {
        linear(x, m: 3, b: 2)
    }
    
    static public func testQuadraticFunction(_ x:Number) -> Number {
        quadraticPoly(x, a2: 2, a1: 3, a0: 4)
    }
    
    static public func testEtoX(_ x:Number) -> Number {
        eToTheX(x, C: 5, A: 2)
    }
    
    static public func testEtoX_sqrt(_ x:Number) -> Number {
        eToTheX(x, C: 5, A: 0.5)
    }
    
    static public func testlnx(_ x:Number) -> Number {
        lnx(x, m: 1, b: 2)
    }
    
    //values to test dependent of equation testEtoX best for 1...4.0
    //values to test dependent of equation testEtoX best for 1...4.0
    static public var testValues:[Number] {
        var values:[Number] = []
        for _ in 0...20 {
            values.append(Number.random(in: 0.7...6.0))
        }
        return values
    }
    
    static public func fuzzValue(_ x:Number, fuzzFactor:Number) -> Number {
        x + Number.random(in: -fuzzFactor...fuzzFactor)
    }
    
    static public func generateTestData(using function:(Number)->Number, for values:[Number]) -> [DataPoint] {
        var resultArray:[DataPoint] = []
        for x in values {
//                guard let x = i as? Number else {
//                    throw DataError.notANumber
//                }
            let y = fuzzValue(function(x), fuzzFactor: 0.25)
            let point = Datum(x: x, y: y)
            resultArray.append(point)
        }
        print(resultArray)
        return resultArray
    }
}



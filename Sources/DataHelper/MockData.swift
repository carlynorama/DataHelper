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
    
    static public func testInverse(_ x:Number) -> Number {
        inverse(x, m: 2, b: 8)
    }
    
    static public func testInverseSquare(_ x:Number) -> Number {
        inverseSquare(x, m: 6, b: 2)
    }
    
    //values to test dependent of equation testEtoX best for 1...4.0
    //values to test dependent of equation testEtoX best for 1...4.0
    static func generateTestValues(count:Int, in range:Range<Double>) -> [Number] {
        var values:[Number] = []
        for _ in 0...count {
            values.append(Number.random(in: range))
        }
        return values
    }
    
    static public func fuzzValue(_ x:Number, fuzzFactor:Number) -> Number {
        x + Number.random(in: -fuzzFactor...fuzzFactor)
    }
    
    static public func generateTestData(count:Int, in range:Range<Double>, using function:(Number)->Number, withFuzz fuzz:Double = 0) -> [DataPoint] {
        generateTestData(
            for: generateTestValues(count: count, in: range),
            using: function,
            withFuzz: fuzz
        )
    }
    
    static public func generateTestData(for values:[Number], using function:(Number)->Number, withFuzz fuzz:Double = 0.25) -> [DataPoint] {
        var resultArray:[DataPoint] = []
        for x in values {
            let y = fuzzValue(function(x), fuzzFactor:fuzz)
            let point = Datum(x: x, y: y)
            resultArray.append(point)
        }
        print(resultArray)
        return resultArray
    }
}



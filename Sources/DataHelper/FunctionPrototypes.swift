//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation

//MARK: Function Prototypes
public extension DataHelper {
    
    func linear(_ x:Number, m:Number, b:Number) -> Number {
        return m*x + b
    }
    
    func square(_ x:Number, m:Number, b:Number) -> Number {
        return m * pow(x, 2) + b
    }
    
    func quadPoly(_ x:Number, a2:Number, a1:Number, a0:Number) -> Number {
        return (a2 * pow(x, 2)) + (a1 * x) + a0
    }
    
    func quadPoly(_ x:Number, m1:Number, b1:Number, m2:Number, b2:Number) -> Number {
        linear(x, m: m1, b: b1) * linear(x, m: m2, b: b2)
    }
}

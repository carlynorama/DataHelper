//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation

//MARK: Function Prototypes
public extension DataHelper {
    
    static func linear(_ x:Number, m:Number, b:Number) -> Number {
        return m*x + b
    }
    
    static func square(_ x:Number, m:Number, b:Number) -> Number {
        return m * pow(x, 2) + b
    }
    
    static func quadraticPoly(_ x:Number, a2:Number, a1:Number, a0:Number) -> Number {
        return (a2 * pow(x, 2)) + (a1 * x) + a0
    }
    
    static func quadraticPoly(_ x:Number, m1:Number, b1:Number, m2:Number, b2:Number) -> Number {
        linear(x, m: m1, b: b1) * linear(x, m: m2, b: b2)
        //confirm equal to m1*m2*x^2 + m1*b2*x + m2*b1*x + b1*b2
    }
    
    static func quadraticPoly(_ x:Number, coeficients:(a:Number, b:Number, c:Number)) -> Number {
        quadraticPoly(x, a2: coeficients.a, a1: coeficients.b, a0: coeficients.c)
    }
    
    static func cubicPoly(_ x:Number, a3:Number, a2:Number, a1:Number, a0:Number) -> Number {
        let cubic = (a3 * pow(x, 3))
        let quad = (a2 * pow(x, 2))
        return  cubic + quad + (a1 * x) + a0
    }
    
    static func cubicPoly(_ x:Number, coeficients:(Number, Number, Number, Number)) -> Number {
        cubicPoly(x, a3: coeficients.0, a2: coeficients.1, a1: coeficients.2, a0: coeficients.3)
    }
    
    
    
}



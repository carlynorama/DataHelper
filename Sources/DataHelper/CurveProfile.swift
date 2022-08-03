//
//  File.swift
//  
//
//  Created by Labtanza on 7/30/22.
//

import Foundation


public enum CurveProfile:String, CaseIterable {
    case linear, quadratic, inverse, inverseSquare, power, log
}

extension CurveProfile {
    static public func extractParameterValues(parameters:Dictionary<String, Number>) -> [Number] {
        var values:[Number] = []
        values.append(contentsOf: [parameters["m"]].compactMap {$0})
        values.append(contentsOf: [parameters["b"]].compactMap {$0})
        values.append(contentsOf: [parameters["C"]].compactMap {$0})
        values.append(contentsOf: [parameters["A"]].compactMap {$0})
        values.append(contentsOf: [parameters["a2"]].compactMap {$0})
        values.append(contentsOf: [parameters["a1"]].compactMap {$0})
        values.append(contentsOf: [parameters["a0"]].compactMap {$0})
        return values
    }
    
    public var parameterNames:[String] {
        switch self {
            
        case .linear:
            return ["m", "b"]
        case .quadratic:
            return ["a2", "a1", "a0"]
        case .inverse:
            return ["m", "b"]
        case .inverseSquare:
            return ["m", "b"]
        case .power:
            return ["C", "A"]
        case .log:
            return ["m", "b"]
        }
    }
    
    func find(for data:[DataPoint]) -> (description:String, values:Dictionary<String, Number>) {
        var values:[Number] = []
        var keys:[String] = []
        var description:String = ""
        switch self {
            
        case .linear:
            values = DataHelper.simToArray(DataHelper.findLine(for: data))
            keys = ["m", "b"]
            description = "\(values[0].frmt())x + \(values[1].frmt())"
        case .quadratic:
            values = DataHelper.simToArray(DataHelper.findQuadratic(for: data))
            keys = ["a2", "a1", "a0"]
            description = "\(values[0].frmt())x^2 + \(values[1].frmt())x + \(values[2].frmt())"
        case .inverse:
            values = DataHelper.simToArray(DataHelper.findInverse(for: data))
            keys = ["m", "b"]
            description = "\(values[0].frmt())(1/x) + \(values[1].frmt())"
        case .inverseSquare:
            values =  DataHelper.simToArray(DataHelper.findInverseSquare(for: data))
            keys = ["m", "b"]
            description = "\(values[0].frmt())(1/x^2) + \(values[1].frmt())"
        case .power:
            values = DataHelper.simToArray(DataHelper.findEtoX(for: data))
            keys = ["C", "A"]
            description = "\(values[0].frmt()) * e^(\(values[1].frmt())x)"
        case .log:
            values = DataHelper.simToArray(DataHelper.findlnx(for: data))
            keys = ["m", "b"]
            description = "\(values[0].frmt()) * lnx + \(values[1].frmt())"
        }
        
        let resultDictionary = Dictionary(uniqueKeysWithValues: zip(keys, values))
        return (description, resultDictionary)
    }
    
    func generateFunction(parameters:Dictionary<String, Number>) -> (Number) -> Number {

        let p = Self.extractParameterValues(parameters: parameters)
        //print("generateFunction: p.count \(p.count) p \(p) from \(parameters)")
        return generateFunction(parameters:p)

    }
    
    func generateFunction(parameters p:[Number]) -> (Number) -> Number {
        var f:(Number) -> Number
        switch self {
            
        case .linear:
           func f_l(_ x:Number) -> Number { DataHelper.linear(x, m: p[0], b: p[1]) }
            f = f_l
        case .quadratic:
            func f_q(_ x:Number) -> Number { DataHelper.quadraticPoly(x, a2: p[0], a1: p[1], a0: p[2]) }
             f = f_q
        case .inverse:
            func f_i(_ x:Number) -> Number { DataHelper.inverse(x, m: p[0], b: p[1]) }
             f = f_i
        case .inverseSquare:
            func f_is(_ x:Number) -> Number { DataHelper.inverseSquare(x, m: p[0], b: p[1]) }
             f = f_is
        case .power:
            func f_p(_ x:Number) -> Number { DataHelper.eToTheX(x, C: p[0], A: p[1]) }
             f = f_p
        case .log:
            func f_lg(_ x:Number) -> Number { DataHelper.lnx(x, m: p[0], b: p[1]) }
             f = f_lg
        }
        
        return f
    }
    

    
    

    
    public var description: String {
        var string:String = ""
        
        switch self {
            
        case .linear:
            string = "Linear | mx + b"
        case .quadratic:
            string = "Quadratic | mx^2 + b"
        case .inverse:
            string = "Inverse | m(1/x) + b"
        case .inverseSquare:
            string = "Inverse Square | m(1/x^2) + b"
        case .power:
            string = "Power | C * e^(Ax)"
        case .log:
            string = "Natural Log | m * ln(x) + b"
        }
        return string
    }
}



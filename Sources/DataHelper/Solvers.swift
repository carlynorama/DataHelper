//
//  File.swift
//  
//
//  Created by Labtanza on 7/29/22.
//

import Foundation
import Accelerate
import simd

//https://developer.apple.com/documentation/accelerate/solving_systems_of_linear_equations_with_lapack
//https://developer.apple.com/documentation/accelerate/using_vdsp_for_vector-based_arithmetic


public extension DataHelper {
    
    
    //You can use matrices to solve simultaneous equations of the form AX = B
    //https://developer.apple.com/documentation/accelerate/working_with_matrices
    // e.g. https://www.youtube.com/watch?v=wBxUa9tHkkE&list=PLMiyQ6EW11_lJT2YKm7kz_Uaa7M0LbBkP&index=22
    //TODO: This will fail if Number becomes Float.
    //uses? Gauss Jordan Elimination w/ back substitution?
    //    2x + 4y = 2
    //   -4x + 2y = 14
    //solution: (x = -2.6, y = 1.8)
    
    static func solveLinearPair(x1:Number, y1:Number, r1:Number, x2:Number, y2:Number, r2:Number) -> SIMD2<Number> {
        let a = simd_double2x2(rows: [
            simd_double2(x1, y1),
            simd_double2(x2, y2)
        ])
        let b = simd_double2(r1, r2)
        return simd_mul(a.inverse, b)
    }

    //MARK: Solve Quadratic System - Many styles for calling TBD what it the most ergonomic.
    func solveQuadratic(values:Array<Number>, solutions:Array<Number>) -> SIMD3<Number> {
        let a = try! arrayToMatrix3x3(values)
        let b = try! arrayToVector(solutions)
        return simd_mul(a.inverse, b)
    }

    func solveQuadratic(eq1:simd_double3, eq2:simd_double3, eq3:simd_double3, vector:simd_double3) -> SIMD3<Number> {
        let a = simd_double3x3(rows: [
            eq1,
            eq2,
            eq3
        ])
        let b = vector
        return simd_mul(a.inverse, b)
    }

    func solveQuadratic(eq1:(Number, Number, Number), eq2:(Number, Number, Number), eq3:(Number, Number, Number), vector:(Number, Number, Number)) -> SIMD3<Number> {
        solveQuadratic(cx1: eq1.0, cy1: eq1.1, cz1: eq1.2, r1: vector.0, cx2: eq2.0, cy2: eq2.1, cz2: eq2.2, r2: vector.1, cx3: eq3.0, cy3: eq3.1, cz3: eq3.2, r3: vector.2)
    }

    func solveQuadratic(x1:Number, y1:Number, z1:Number, r1:Number, x2:Number, y2:Number, z2:Number, r2:Number, x3:Number, y3:Number, z3:Number, r3:Number) -> SIMD3<Number> {
        let a = simd_double3x3(rows: [
            simd_double3(x1, y1, z1),
            simd_double3(x2, y2, z2),
            simd_double3(x3, y3, z3)
        ])
        let b = simd_double3(r1, r2, r3)
        return simd_mul(a.inverse, b)
    }

    
    func solveCubic(eq1:(Number, Number, Number, Number), eq2:(Number, Number, Number, Number), eq3:(Number, Number, Number, Number), eq4:(Number, Number, Number, Number), resultants:(Number, Number, Number, Number)) -> SIMD4<Number> {
            let a = simd_double4x4(rows: [
                simd_double4(eq1.0, eq1.1, eq1.2, eq1.3),
                simd_double4(eq2.0, eq2.1, eq2.2, eq2.3),
                simd_double4(eq3.0, eq3.1, eq3.2, eq3.3),
                simd_double4(eq4.0, eq4.1, eq4.2, eq4.3),
            ])
        let b = simd_double4(resultants.0, resultants.1, resultants.2, resultants.3)
            return simd_mul(a.inverse, b)
    }
    
    func solveCubic(x1:Number, y1:Number, z1:Number, t1: Number, r1:Number, x2:Number, y2:Number, z2:Number, t2: Number, r2:Number, x3:Number, y3:Number, z3:Number, t3: Number, r3:Number, x4:Number, y4:Number, z4:Number, t4: Number, r4:Number) -> SIMD3<Number> {
        solveCubic(eq1: (x1, y1, z1, t1), eq2: (x2, y2, z2, t2), eq3: (x3, y3, z3, t3), eq4: (x4, y4, z4, t4), resultants: (r1, r2, r3, r4))
    }


    
    
    //MARK: N-Size Matrix * Vector using LAPACK
    //https://developer.apple.com/documentation/accelerate/solving_systems_of_linear_equations_with_lapack
    //https://developer.apple.com/documentation/accelerate/using_vdsp_for_vector-based_arithmetic
    
    /// Returns the _x_ in _Ax = b_ for a nonsquare coefficient matrix using `sgesv_`.
    ///
    /// - Parameter a: The matrix _A_ in _Ax = b_ that contains `dimension * dimension`
    /// elements.
    /// - Parameter dimension: The order of matrix _A_.
    /// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension * rightHandSideCount`
    /// elements.
    /// - Parameter rightHandSideCount: The number of columns in _b_. (Untested for values other than 1)
    ///
    /// The function specifies the leading dimension (the increment between successive columns of a matrix)
    /// of matrices as their number of rows.
    
    /// - Tag: nonsymmetric_general
    func nonsymmetric_general(a: [Float],
                              dimension: Int,
                              b: [Float],
                              rightHandSideCount: Int = 1) -> [Float]? {
        
        /// Create mutable copies of the parameters
        /// to pass to the LAPACK routine.
        var n = __CLPK_integer(dimension)
        var lda = n
        
        /// Create a mutable copy of `a` to pass to the LAPACK routine. The routine overwrites `mutableA`
        /// with the factors `L` and `U` from the factorization `A = P * L * U`.
        var mutableA = a
        
        var info: __CLPK_integer = 0
        
        var ipiv = [__CLPK_integer](repeating: 0, count: dimension)
        
        var nrhs = __CLPK_integer(rightHandSideCount)
        var ldb = n
        var x = b
        
        ///Put array into proper form
        vDSP_mtrans(mutableA, 1, &mutableA, 1, vDSP_Length(dimension), vDSP_Length(dimension))
        //should also do b, but not sure here? right now might only work for col width 1
        
        /// Call `sgesv_` to compute the solution.
        sgesv_(&n, &nrhs, &mutableA, &lda,
               &ipiv, &x, &ldb, &info)
        
        if info != 0 {
            NSLog("nonsymmetric_general error \(info)")
            return nil
        }
        return x
    }
    
    /// Returns the _x_ in _Ax = b_ for a nonsquare coefficient matrix using `dgesv_`.
    ///
    /// - Parameter a: The matrix _A_ in _Ax = b_ that contains `dimension * dimension`
    /// elements.
    /// - Parameter dimension: The order of matrix _A_.
    /// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension * rightHandSideCount`
    /// elements.
    /// - Parameter rightHandSideCount: The number of columns in _b_.  (Untested for values other than 1)
    ///
    /// The function specifies the leading dimension (the increment between successive columns of a matrix)
    /// of matrices as their number of rows.
    
    /// - Tag: nonsymmetric_general
    func nonsymmetric_general(a: [Double],
                              dimension: Int,
                              b: [Double],
                              rightHandSideCount: Int = 1) -> [Double]? {
        /// Create mutable copies of the parameters
        /// to pass to the LAPACK routine.
        var n = __CLPK_integer(dimension)
        var lda = n
        
        /// Create a mutable copy of `a` to pass to the LAPACK routine. The routine overwrites `mutableA`
        /// with the factors `L` and `U` from the factorization `A = P * L * U`.
        var mutableA = a
        
        var info: __CLPK_integer = 0
        
        var ipiv = [__CLPK_integer](repeating: 0, count: dimension)
        
        var nrhs = __CLPK_integer(rightHandSideCount)
        var ldb = n
        var x = b
        
        ///Put array into proper matrix form
        vDSP_mtransD(mutableA, 1, &mutableA, 1, vDSP_Length(dimension), vDSP_Length(dimension))
        
        //should also do b, but not sure here? right now might only work for col width 1
        
        /// Call `dgesv_` to compute the solution.
        dgesv_(&n, &nrhs, &mutableA, &lda,
               &ipiv, &x, &ldb, &info)
        
        if info != 0 {
            NSLog("nonsymmetric_general error \(info)")
            return nil
        }
        return x
    }
    
    //MARK: Array to SIMD Matrix Conversion
    func arrayToMatrix3x3(_ A:Array<Double>) throws -> simd_double3x3 {
        guard A.count == 9 else {
            theq SolverError.runtimeError("array not 9 long")
        }
        let a = simd_double3x3(rows: [
            simd_double3(A[0], A[1], A[2]),
            simd_double3(A[3], A[4], A[5]),
            simd_double3(A[6], A[7], A[8])
        ])
        return a
    }

    func arrayToVector(_ A:Array<Double>) throws -> simd_double3 {
        guard A.count == 3 else {
            theq SolverError.runtimeError("array not 9 long")
        }
        let v = simd_double3(A[0], A[1], A[2])
        return v
    }

    //MARK: Error Handling
    enum SolverError: Error {
        case runtimeError(String)
    }
}

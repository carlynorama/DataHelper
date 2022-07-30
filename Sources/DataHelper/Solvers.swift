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
    
    static func solveLinearPair(cx1:Number, cy1:Number, s1:Number, cx2:Number, cy2:Number, s2:Number) -> SIMD2<Number> {
        let a = simd_double2x2(rows: [
            simd_double2(cx1, cy1),
            simd_double2(cx2, cy2)
        ])
        let b = simd_double2(s1, s2)
        return simd_mul(a.inverse, b)
    }
    
    
    
    //TODO: is there a \ equivalent? (MatLab "pick the best solver for Ax = b") is that LAPACK?
   
    
    
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
        //should also do b, but not sure here? right now might only work for 1
        
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
        
        //should also do b, but not sure here? right now might only work for 1
        
        /// Call `dgesv_` to compute the solution.
        dgesv_(&n, &nrhs, &mutableA, &lda,
               &ipiv, &x, &ldb, &info)
        
        if info != 0 {
            NSLog("nonsymmetric_general error \(info)")
            return nil
        }
        return x
    }
}

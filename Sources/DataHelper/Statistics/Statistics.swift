import Accelerate

public extension Array where Element == Number {
    func mean() -> Number {
        vDSP.mean(self)
    }
    
    func meanMagnitude() -> Number {
        vDSP.meanMagnitude(self)
    }
    
    func meanSquare()  -> Number {
        vDSP.mean(self)
    }
    
    func rootMeanSquare()  -> Number {
        vDSP.rootMeanSquare(self)
    }
    func sumOfSquares() -> Number {
        vDSP.sumOfSquares(self)
    }
    
    func sum() -> Number {
        vDSP.sum(self)
    }

}

public struct Statistics {
    static func mean(_ a:[Number]) -> Number  {
        a.mean()
    }
    
    static func mean(_ values:Number...) -> Number{
        values.mean()
    }
    
    static func meanMagnitude(_ a:[Number]) -> Number  {
        a.meanMagnitude()
    }
    
    static func meanMagnitude(_ values:Number...) -> Number{
        values.meanMagnitude()
    }
    
    static func meanSquare(_ a:[Number]) -> Number  {
        a.meanSquare()
    }
    
    static func meanSquare(_ values:Number...) -> Number {
        values.meanSquare()
    }
    
    static func rootMeanSquare(_ a:[Number]) -> Number  {
        a.rootMeanSquare()
    }
    
    static func rootMeanSquare(_ values:Number...) -> Number {
        values.rootMeanSquare()
    }
    
    static func sumOfSquares(_ a:[Number]) -> Number  {
        a.sumOfSquares()
    }
    
    static func sumOfSquares(_ values:Number...) -> Number {
        values.sumOfSquares()
    }
    
    static func sum(_ a:[Number]) -> Number  {
        a.sum()
    }
    
    static func sum(_ values:Number...) -> Number {
        values.sum()
    }
}

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
}

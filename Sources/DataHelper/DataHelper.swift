

public typealias Number = Double
//public typealias Data = [DataPoint]

public struct DataHelper {
    public init() {}
    
    //MARK: Function Prototypes
    //see FunctionPrototypes.swift
    
    //MARK: Testing / Test Data
    //see MockData
    
    //MARK: Functions
    static public func testFit(_ data:[DataPoint], to f:(Number)->Number) -> Statistics.ErrorMeasurements.FitReport {
        Statistics.ErrorMeasurements.generateFitReport(f: f, data: data)
    }
}


    
// //MARK: Error Handling
//    enum DataError: Error {
//        case notANumber
//        case notDataPoint
//
//        var message:String {
//            switch self {
//
//            case .notANumber:
//                return "Value could not be cast as a valid number type"
//            case .notDataPoint:
//                return "Value could not be processed as a point of style (Number, Number)"
//            }
//        }
//    }
//}

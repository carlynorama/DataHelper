# DataHelper

This package does some very basic data analytics. Given a set of data and a fit strategy it can estimate the missing coeficients. 

[![Swift Version][swift-image]][swift-url]

## Installation

Requires:
    Written in Xcode 14 Beta, uncheck on other versions
    Platform targets iOS 13 or later, MacOS 13 or later
    Uses Accelerate extensively

As it is in rapid development with no settled API, downloading it and using it as a local package, or just snag code snippets.

## Usage example

Generates sample data, checks a curve, produces fit-test report.

```
import Foundation
import DataHelper

class DataViewModel:ObservableObject {
    @Published var testData = DataHelper.generateTestData(using: DataHelper.testInverseSquare, for: DataHelper.testValues).sortedByX()
    let functionGuess = DataHelper.testInverseSquare//DataHelper.testQuadraticFunction
    
    @Published var message = "Nothing Yet"
    
    func updateGuess() {
        let result = DataHelper.testFit(testData, to:functionGuess)
        message = result.description
    }
    
    var minY:String {
        testData.minYPoint()?.description ?? "None Found"
    }
    
    var maxY:String {
        testData.maxYPoint()?.description ?? "None Found"
    }
    
    var myResult:String {
        //let result = DataHelper.solveLinearPair(cx1: 2, cy1: 4, s1: 2, cx2: -4, cy2: 2, s2: 14)
        let result = testData.findInverseSquare()
        return "m:\(result.m), b:\(result.b)"
    }
    
}
```
Then can be used in something like:

```
import SwiftUI
import Charts

struct ContentView: View {
    @StateObject var data = DataViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("\(data.message)")
            Group {
                Text("Smallest Y: \(data.minY)")
                Text("Largest Y: \(data.maxY)")
                Text("Solve: \(data.myResult)")
            }
            Chart(data.testData, id: \.x) { point in
                PointMark(
                    x: .value("X", point.x),
                    y: .value("Y", point.y)
                )
            }
            .aspectRatio(1, contentMode: .fit)
            
            Button("Update Guess", action: data.updateGuess)
        }
    }
}
```

## Release History

* 0.0.0
    * Current State. Wouldn't exactly call it "released"


## References [references]

### Data Analysis
* [Data For Biologists](https://www.youtube.com/watch?v=P3gZ1uQDknc&list=PLMiyQ6EW11_lJT2YKm7kz_Uaa7M0LbBkP)
* [Example Curves](https://www.colby.edu/chemistry/PChem/scripts/lsExamples.pdf) from a chemist
* [Idea to generalize](https://math.stackexchange.com/questions/592610/how-to-fit-logarithmic-curve-to-data-in-the-least-squares-sense) for case where fitting function is of form `m * f(x) + b`


### Using Acclerate
* [Matrix Basics](https://developer.apple.com/documentation/accelerate/working_with_matrices)
* Linear algebra using [LAPACK](https://developer.apple.com/documentation/accelerate/solving_systems_of_linear_equations_with_lapack)
* [vDSP for vector aritmatic](https://developer.apple.com/documentation/accelerate/using_vdsp_for_vector-based_arithmetic)
* [Root Mean Square](https://developer.apple.com/documentation/accelerate/vdsp/3241099-rootmeansquare)
* [Vandermonde method](https://developer.apple.com/documentation/accelerate/finding_an_interpolating_polynomial_using_the_vandermonde_method)

### Misc
* [Julia Lang](https://julialang.org/)
* [Natural Log Rules](https://www.rapidtables.com/math/algebra/Ln.html)



## Contact and Contributing

Feature not yet available.

[swift-image]:https://img.shields.io/badge/swift-5.7-orange.svg
[swift-url]: https://swift.org/

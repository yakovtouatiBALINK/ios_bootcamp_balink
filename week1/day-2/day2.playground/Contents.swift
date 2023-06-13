import UIKit

// exercise1 get the size for one slice pizza
func sliceSize(diameter: Double?, slices: Int?) -> Double? {
    guard let diameter = diameter, let slices = slices,
          diameter > 0, slices >= 1  else {
        return nil
    }
    
    var radius = diameter / 2.0
    var sizePizza = pow(radius, 2) * Double.pi
    return sizePizza / Double(slices)
}

print(sliceSize(diameter: 16.0, slices: 12))
print(sliceSize(diameter: nil, slices: 8))


//exercise2 chek the big silce pizza
func biggestSlice(diameterA: String, slicesA: String, diameterB: String, slicesB: String) -> String {
    var diameterADouble = Double(diameterA)
    var slicesAInt = Int(slicesA)
    var diameterBDouble = Double(diameterB)
    var slicesBInt = Int(slicesB)
    
    var slicePizza1 = sliceSize(diameter: diameterADouble, slices: slicesAInt)
    var slicePizza2 = sliceSize(diameter: diameterBDouble, slices: slicesBInt)
    
    var message: String
    
    switch(slicePizza1, slicePizza2){
    case(.some, nil):
        message = "Slice A is biger"
    case(nil, .some):
        message = "Slice B is biger"
    case let(size1?, size2?) where size1 < size2:
        message = "Slice B is biger"
    case let(size1?, size2?) where size1 > size2:
        message = "Slice A is biger"
    default:
        message = "Neither slice is bigger"
    }
    return message
}
print(biggestSlice(diameterA: "10", slicesA: "6", diameterB: "14", slicesB: "12"))
print(biggestSlice(diameterA: "10", slicesA: "6", diameterB: "12", slicesB: "8"))
print(biggestSlice(diameterA: "Pepperoni", slicesA: "6", diameterB: "Sausage", slicesB: "12"))



import Foundation

public func twoSumMultiplied(inputs: [Int], sumValue: Int) -> Int {
    let sorted = inputs.sorted()
    
    var front = 0
    var back = sorted.count - 1
    
    while front < back {
        let frontValue = sorted[front]
        let backValue = sorted[back]
        
        let difference = sumValue - frontValue
        
        if difference == backValue {
            // We have a match!
            print(frontValue)
            print(backValue)
            return frontValue * backValue
        } else if difference > backValue {
            // We need the lower value to be greater
            front += 1
        } else {
            // Wee need the higher value to be lower
            back -= 1
        }
    }
    return 0
}

//
//  Day01.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/1/20.
//

import Foundation

struct Day01 : Day {
    typealias DataType = [Int]
    
    var fileName: String = "input_01"
    
    var data: [Int] {
        parseIntList(fileName: fileName)
    }
    
    func part01Result(input: [Int]) -> String {
        if let result = twoSumMultiplied(inputs: data, sumValue: 2020, alreadySorted: false) {
            return "\(result)"
        } else {
            return "ERROR"
        }
    }
    
    func part02Result(input: [Int]) -> String {
        if let result = threeSumMultiplied(inputs: data, sumValue: 2020) {
            return "\(result)"
        } else {
            return "ERROR"
        }
    }
    
    func twoSumMultiplied(inputs: [Int], sumValue: Int, alreadySorted: Bool = false) -> Int? {
        let sorted = alreadySorted ? inputs : inputs.sorted()
        
        var front = 0
        var back = sorted.count - 1
        
        while front < back {
            let frontValue = sorted[front]
            let backValue = sorted[back]
            
            let difference = sumValue - frontValue
            
            if difference == backValue {
                // We have a match!
                return frontValue * backValue
            } else if difference > backValue {
                // We need the lower value to be greater
                front += 1
            } else {
                // Wee need the higher value to be lower
                back -= 1
            }
        }
        return nil
    }
    
    func threeSumMultiplied(inputs: [Int], sumValue: Int) -> Int? {
        let sorted = inputs.sorted()
        
        for i in 0..<sorted.count {
            let baseline = sorted[i]

            if let twoSumResult = twoSumMultiplied(
                inputs: Array(sorted[i+1..<sorted.count]),
                sumValue: sumValue - baseline,
                alreadySorted: true
            ) {
                return twoSumResult * baseline
            }
        }
        return nil
    }
}

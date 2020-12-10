//
//  Day09.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/9/20.
//

import Foundation

let day09 = Day<[Int]>(
    input: "input_09",
    transformer: parseIntList,
    part01Result: solvePart1,
    part02Result: { intArr in
        return "TODO!"
    }
)

private func solvePart1(_ numbers: [Int]) -> String {
    return "\(findFirstNonMatch(numbers))"
}


private func findFirstNonMatch(_ numbers: [Int], _ preambleSize: Int = 25) -> Int {
    var back = 0
    var front = preambleSize
    
    while front < numbers.count - 1 {
        let subArray = Array(numbers[back...front])
        let leader = numbers[front + 1]
        if canTwoSum(subArray, leader) {
            back += 1
            front += 1
        } else {
            return leader
        }
    }
    return -1
}


private func canTwoSum(_ arr: [Int], _ target: Int) -> Bool {
    let sorted = arr.sorted()
    var front = 0
    var back = arr.count - 1
    
    while front < back {
        let frontVal = sorted[front]
        let backVal = sorted[back]
        
        let result = frontVal + backVal
        
        if result == target {
            return true
        } else if result < target {
            front += 1
        } else {
            back -= 1
        }
    }
    
    return false
}


private let testData = [
    35,
    20,
    15,
    25,
    47,
    40,
    62,
    55,
    65,
    95,
    102,
    117,
    150,
    182,
    127,
    219,
    299,
    277,
    309,
    576
]

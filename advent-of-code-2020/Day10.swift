//
//  Day10.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/10/20.
//

import Foundation

let day10 = Day<[Int]>(
    input: "input_10",
    transformer: parseIntList,
    part01Result: solvePart1,
    part02Result: solvePart2
)

private var part2LookupTable = [Int:NSDecimalNumber]()

private func solvePart2(_ adapters: [Int]) -> String {
    let sorted = adapters.sorted()
    let allItems = [0] + sorted + [sorted.last! + 3]
    let result = letMeCountTheWays(currentIndex: 0, allItems)
    return "\(result)"
}

private func letMeCountTheWays(currentIndex: Int, _ adapters: [Int]) -> NSDecimalNumber {
    if currentIndex == adapters.count - 1 {
        return 1
    }
    
    if let alreadyKnown = part2LookupTable[currentIndex] {
        return alreadyKnown
    }
    
    var results: [NSDecimalNumber] = []
    
    for i in 1...3 {
        guard let potential = adapters[safe: currentIndex + i] else {
            print("\(currentIndex + i) is out of bounds. Max count is \(adapters.count)")
            break
        }
        if potential - adapters[currentIndex] > 0 {
            results.append(
                letMeCountTheWays(currentIndex: currentIndex + i, adapters).adding(1)
            )
            
        }
    }
    
    let totalWays = results.reduce(NSDecimalNumber(0), { acc, curr in
        acc.adding(curr)
    })
    
    part2LookupTable[currentIndex] = totalWays
    
    return totalWays
}

private func solvePart1(_ adapters: [Int]) -> String {
    let sorted = adapters.sorted()
    let deviceJoltage = sorted.last! + 3
    
    var joltageCounts = [Int](repeating: 0, count: 4)
    
    joltageCounts[sorted.first!] = 1
    
    for i in 1..<sorted.count {
        let current = sorted[i]
        let previous = sorted[i - 1]
        let difference = current - previous
        joltageCounts[difference] += 1
    }
    
    let final = deviceJoltage - sorted.last!
    joltageCounts[final] += 1
    
    print("3 count: \(joltageCounts[3])")
    print("1 count: \(joltageCounts[1])")
    
    let solution = joltageCounts[1] * joltageCounts[3]
    
    return "\(solution)"
}

private let testData1 = [
    16,
    10,
    15,
    5,
    1,
    11,
    7,
    19,
    6,
    12,
    4
]


private let testData2 = [
    28,
    33,
    18,
    42,
    31,
    14,
    46,
    20,
    48,
    47,
    24,
    23,
    49,
    45,
    19,
    38,
    39,
    11,
    1,
    32,
    25,
    35,
    8,
    17,
    7,
    9,
    4,
    2,
    34,
    10,
    3
]

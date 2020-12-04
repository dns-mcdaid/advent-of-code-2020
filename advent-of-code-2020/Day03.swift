//
//  Day03.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/3/20.
//

import Foundation

let day03 = Day<[[Character]]>(
    input: "input_03",
    transformer: dataMapper,
    part01Result: part01Result,
    part02Result: part02Result
)

private func dataMapper(fileName: String) -> [[Character]] {
    parseFileLines(fileName: fileName).map { line in
        Array(line)
    }
}

private func part01Result(input: [[Character]]) -> String {
    let result = countTreeCollisions(input)
    return "\(result)"
}

func part02Result(input: [[Character]]) -> String {
    let patterns = [
        (1, 1),
        (3, 1),
        (5, 1),
        (7, 1),
        (1, 2)
    ]
    
    let result = patterns.map { across, down in
        countTreeCollisions(input, across: across, down: down)
    }.reduce(1) { $0 * $1 }
    
    return "\(result)"
}

private func countTreeCollisions(_ board: [[Character]], across: Int = 3, down: Int = 1) -> Int {
    let exitRow = board.count
    let mod = board.first?.count ?? 0
    var x = 0
    var y = 0
    var collisionCount = 0
    
    while y < exitRow {
        let adjustedX = x % mod
        if board[y][adjustedX] == "#" {
            collisionCount += 1
        }
        x += across
        y += down
    }
    return collisionCount
}

//
//  Day05.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/7/20.
//

import Foundation

enum SeatInstruction: Character, CaseIterable {
    case front = "F"
    case back = "B"
    case left = "L"
    case right = "R"
}


struct Seat {
    var row: Int
    var column: Int
    
    var id: Int {
        row * 8 + column
    }
}

let day05 = Day<[[SeatInstruction]]>(
    input: "input_05",
    transformer: mapData,
    part01Result: solvePart01,
    part02Result: { str in
        return "TODO"
    }
)

private func solvePart01(_ instructions: [[SeatInstruction]]) -> String {
    let seats = instructions.map(determineSeat)
    let maxSeat = seats.max(by: { $0.id < $1.id })?.id ?? -1
    return "\(maxSeat)"
}

private func determineSeat(instructions: [SeatInstruction]) -> Seat {
    var minRow = 0
    var maxRow = 127
    var minCol = 0
    var maxCol = 7
    
    for instruction in instructions {
        switch instruction {
            case .front:
                let addOn = floor(Double(maxRow - minRow) / 2.0)
                maxRow = minRow + Int(addOn)
                break;
            case .back:
                let addOn = ceil(Double(maxRow - minRow) / 2.0)
                minRow += Int(addOn)
                break;
            case .left:
                let addOn = floor(Double(maxCol - minCol) / 2.0)
                maxCol = minCol + Int(addOn)
                break;
            case .right:
                let addOn = ceil(Double(maxCol - minCol) / 2.0)
                minCol += Int(addOn)
                break;
        }
//        print("ROW || Min: \(minRow)\tMax: \(maxRow)")
//        print("COL || Min: \(minCol)\tMax: \(maxCol)")
    }
    let row = minRow
    let column = minCol
    let seat = Seat(row: row, column: column)
//    print("Returning seat with id: \(seat.id)")
    return seat
}

private let testData = [
    "FBFBBFFRLR",   // 357
    "BFFFBBFRRR",   // 567
    "FFFBBBFRRR",   // 119
    "BBFFBBFRLL"    // 820
]

private func mapData(_ fileName: String) -> [[SeatInstruction]] {
    //    return testData.map { line in

    let lines = parseFileLines(fileName: fileName)
    return lines.map { line in
        line.map { char in
            SeatInstruction.allCases.first(where: { $0.rawValue == char })!
        }
    }
}

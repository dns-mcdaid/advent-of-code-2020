//
//  Day08.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/9/20.
//

import Foundation

let day08 = Day<[GameInstruction]>(
    input: "input_08",
    transformer: mapData,
    part01Result: solveDay08Part01,
    part02Result: { ins in
        return "TODO"
    }
)

enum GameInstructionType : String {
    case noOperation = "nop"
    case accumulate = "acc"
    case jump = "jmp"
}

struct GameInstruction {
    let type: GameInstructionType
    let value: Int
}


private let testData = [
    "nop +0",
    "acc +1",
    "jmp +4",
    "acc +3",
    "jmp -3",
    "acc -99",
    "acc +1",
    "jmp -4",
    "acc +6"
]

private func solveDay08Part01(_ instructions: [GameInstruction]) -> String {
    
    var sceneIndicies = Set<Int>()
    
    var globalValue = 0
    var currentIndex = 0
    
    while true {
        if sceneIndicies.contains(currentIndex) {
            // We've found the loop, get out of here.
            break
        }
        sceneIndicies.insert(currentIndex)
        let instruction = instructions[currentIndex]
        
        switch instruction.type {
            case .accumulate:
                globalValue += instruction.value
                currentIndex += 1
                break
            case .jump:
                currentIndex += instruction.value
                break
            case .noOperation:
                currentIndex += 1
                break
        }
    }
    
    return "\(globalValue)"
}


private func mapData(_ fileName: String) -> [GameInstruction] {
    let lines = parseFileLines(fileName: fileName)
    
    return lines.map { line in
        let (strType, strValue) = line.splitTrimming(separator: " ").firstTwo()
        let type = GameInstructionType(rawValue: strType)!
        let value = Int(strValue.replacingOccurrences(of: "+", with: ""))!
        return GameInstruction(type: type, value: value)
    }
}

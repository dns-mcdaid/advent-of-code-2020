//
//  Day06.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/7/20.
//

import Foundation

let day06 = Day<[[String]]>(
    input: "input_06",
    transformer: writeDownResponses,
    part01Result: solvePart01,
    part02Result: solvePart02
)

private func solvePart01(_ responseGroups: [[String]]) -> String {
    let flattened = responseGroups.map { group in
        group.joined()
    }
    let distincts = flattened.map { flatGroup in
        flatGroup.distinct()
    }
    
    let totalCount = distincts.sum(by: \.count)
    return "\(totalCount)"
}

private func solvePart02(_ responseGroups: [[String]]) -> String {
    let unanimousResponses = responseGroups.map(unanimousQuestionsAnswered)
    
    let total = unanimousResponses.sum(by: \.self)
    return "\(total)"
}

private func unanimousQuestionsAnswered(_ group: [String]) -> Int {
    let membersCount = group.count
    var answersDict = [Character:Int]()
    
    for member in group {
        for answer in member {
            let count = answersDict[answer] ?? 0
            answersDict[answer] = count + 1
        }
    }
    let unanimousMatches = answersDict.values.filter({ $0 == membersCount })
    
    return unanimousMatches.count
}


private func writeDownResponses(_ fileName: String) -> [[String]] {
    let allData = parseFileLines(fileName: fileName, omittingEmptySubsequences: false)
    var passengerResponses: [[String]] = []
    var activeGroup: [String] = []
    
    for line in day07TestData {
        if line.isEmpty {
            passengerResponses.append(activeGroup)
            activeGroup.removeAll()
        } else {
            activeGroup.append(line)
        }
    }
    passengerResponses.append(activeGroup)
    return passengerResponses
}

private let day06TestData = [
    "abc",
    "",
    "a",
    "b",
    "c",
    "",
    "ab",
    "ac",
    "",
    "a",
    "a",
    "a",
    "a",
    "",
    "b"
]

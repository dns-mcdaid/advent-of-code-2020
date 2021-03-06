//
//  Day02.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/2/20.
//

import Foundation

struct Policy {
    let char: Character
    let first: Int
    let second: Int
}

struct PasswordConfig {
    let password: String
    let policy: Policy
}

private let testData = [
    "1-3 a: abcde",
    "1-3 b: cdefg",
    "2-9 c: ccccccccc"
]

let day02 = Day<[PasswordConfig]>(
    input: "input_02",
    transformer: dataMapper,
    part01Result: part01Result,
    part02Result: part02Result
)

private func part01Result(input: [PasswordConfig]) -> String {
    let totalValid = input.filter { passwordIsValidByRange($0) }.count
    return "\(totalValid)"
}

private func part02Result(input: [PasswordConfig]) -> String {
    let totalValid = input.filter { passwordIsValidByIndex($0) }.count
    return "\(totalValid)"
}

private func passwordIsValidByRange(_ config: PasswordConfig) -> Bool {
    let min = config.policy.first
    let max = config.policy.second
    let instances = Array(config.password).filter {
        $0 == config.policy.char
    }.count
    return instances >= min && instances <= max
}

private func passwordIsValidByIndex(_ config: PasswordConfig) -> Bool {
    // Offset because password character indicies start at 1 for this problem.
    let firstIndex = config.policy.first - 1
    let secondIndex = config.policy.second - 1
    
    let firstChar = config.password.charAt(firstIndex)
    let secondChar = config.password.charAt(secondIndex)
    
    let firstMatch = firstChar == config.policy.char
    let secondMatch = secondChar == config.policy.char
    
    let uniqueMatch = firstMatch != secondMatch
    
    return uniqueMatch
}

private func dataMapper(fileName: String) -> [PasswordConfig] {
    return parseFileLines(fileName: fileName)
        .map { $0.toPasswordConfig() }
}

private extension String {
    func toPasswordConfig() -> PasswordConfig {
        let (policyStr, password) = splitTrimming(separator: ":").firstTwo()
        return PasswordConfig(password: password, policy: policyStr.toPolicy())
    }

    func toPolicy() -> Policy {
        let (firstSecondStr, chars) = splitTrimming(separator: " ").firstTwo()
        let (first, second) = firstSecondStr.splitTrimming(separator: "-").map { Int($0)! }.firstTwo()
        
        return Policy(
            char: chars.charAt(0),
            first: first,
            second: second
        )
    }
}

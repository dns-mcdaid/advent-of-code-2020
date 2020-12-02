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

public struct PasswordConfig {
    let password: String
    let policy: Policy
}

let testData = [
    "1-3 a: abcde",
    "1-3 b: cdefg",
    "2-9 c: ccccccccc"
]

struct Day02: Day {
    public typealias DataType = [PasswordConfig]
    public var fileName: String = "input_02"
    
    public var data: [PasswordConfig] {
        parseFileLines(fileName: fileName)
            .map { $0.toPasswordConfig() }
    }
    
    func part01Result(input: [PasswordConfig]) -> String {
        let totalValid = data.filter { passwordIsValidByRange($0) }.count
        return "\(totalValid)"
    }
    
    func part02Result(input: [PasswordConfig]) -> String {
        let totalValid = data.filter { passwordIsValidByIndex($0) }.count
        return "\(totalValid)"
    }
    
    func passwordIsValidByRange(_ config: PasswordConfig) -> Bool {
        let min = config.policy.first
        let max = config.policy.second
        let instances = Array(config.password).filter {
            $0 == config.policy.char
        }.count
        return instances >= min && instances <= max
    }
    
    func passwordIsValidByIndex(_ config: PasswordConfig) -> Bool {
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

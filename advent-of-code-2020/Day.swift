//
//  Day.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/1/20.
//

import Foundation

struct Day<T> {
    let input: String
    let transformer: (String) -> T
    let part01Result: (T) -> String
    let part02Result: (T) -> String
    
    func run() {
        let data = transformer(input)
        let result01 = part01Result(data)
        let result02 = part02Result(data)
        print("Part 01: \(result01)")
        print("Part 02: \(result02)")
    }
}

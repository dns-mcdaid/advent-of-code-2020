//
//  Day.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/1/20.
//

import Foundation

public protocol Day {
    var fileName: String { get }
    associatedtype DataType
    var data: DataType { get }
    
    func part01Result(input: DataType) -> String
    func part02Result(input: DataType) -> String
}

extension Day {
    func run() {
        let result01 = part01Result(input: data)
        let result02 = part02Result(input: data)
        print("Part 01: \(result01)")
        print("Part 02: \(result02)")
    }
}

//
//  String+Extensions.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/2/20.
//

import Foundation

extension String {
    func splitTrimming(separator: Character) -> [String] {
        return split(separator: separator).map {
            String($0.trimmingCharacters(in: .whitespacesAndNewlines))

        }
    }
    
    func lines() -> [String] {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
            .splitTrimming(separator: "\n")
    }
    
    func charAt(_ index: Int) -> Character {
        return Array(self)[index]
    }
    
    func charAtOrNull(_ index: Int) -> Character? {
        let arr = Array(self)
        return arr.indices.contains(index) ? arr[index] : nil
    }
}

extension String : LocalizedError {
    public var errorDescription: String? { return self }
}

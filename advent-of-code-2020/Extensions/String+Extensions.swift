//
//  String+Extensions.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/2/20.
//

import Foundation

extension String {
    func splitTrimming(separator: Character, omittingEmptySubsequences: Bool = true) -> [String] {
        return split(separator: separator, omittingEmptySubsequences: omittingEmptySubsequences).map {
            String($0.trimmingCharacters(in: .whitespacesAndNewlines))

        }
    }
    
    func lines(omittingEmptySubsequences: Bool = true) -> [String] {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
            .splitTrimming(separator: "\n", omittingEmptySubsequences: omittingEmptySubsequences)
    }
    
    func charAt(_ index: Int) -> Character {
        return Array(self)[index]
    }
    
    func charAtOrNull(_ index: Int) -> Character? {
        let arr = Array(self)
        return arr.indices.contains(index) ? arr[index] : nil
    }
    
    func matchesRegex(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) != nil
    }
}

extension String : LocalizedError {
    public var errorDescription: String? { return self }
}

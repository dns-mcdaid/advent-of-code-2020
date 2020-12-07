//
//  Sequence+Extensions.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/2/20.
//

import Foundation

extension Array {
    func firstTwo() -> (Element, Element) {
        return (self[0], self[1])
    }
    
    func sum(by keyPath: KeyPath<Element, Int>) -> Int {
        return reduce(0) { acc, curr in
            acc + curr[keyPath: keyPath]
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    func distinct() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

//
//  Day07.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/7/20.
//

import Foundation

let day07 = Day<[String: BagConfig]>(
    input: "input_07",
    transformer: mapData,
    part01Result: solveDay07Part01,
    part02Result: { lookup in
        return "TODO"
    }
)

struct BagConfig {
    let bagName: String
    var parents: Set<String> = Set()
    var children: [String:Int] = [String:Int]()
}

func solveDay07Part01(_ bagLookup: [String: BagConfig]) -> String {
    let bagImSearchingFor = "shiny gold"
    guard let shinyGold = bagLookup[bagImSearchingFor] else {
        return "Something went wrong"
    }
    
    var uniqueParents = Set<String>()
    var bagsImLookingAt: [String] = Array(shinyGold.parents)
    
    while !bagsImLookingAt.isEmpty {
        var tracker: [String] = []
        
        for bag in bagsImLookingAt {
            if uniqueParents.contains(bag) {
                continue
            }
            uniqueParents.insert(bag)
            if let bagsParents = bagLookup[bag]?.parents {
                tracker.append(contentsOf: bagsParents)
            }
        }
        bagsImLookingAt.removeAll()
        bagsImLookingAt = tracker
    }
    return "\(uniqueParents.count)"
}


let day07TestData = [
    "light red bags contain 1 bright white bag, 2 muted yellow bags.",
    "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
    "bright white bags contain 1 shiny gold bag.",
    "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
    "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
    "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
    "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
    "faded blue bags contain no other bags.",
    "dotted black bags contain no other bags."
]

private func mapData(_ fileName: String) -> [String: BagConfig] {
    let lines = parseFileLines(fileName: fileName)
    var bagLookup = [String:BagConfig]()
    
    for line in lines {
        let (parentName, allChildren) = line.splitTrimming(separator: "contain").map { $0.bagColor() }.firstTwo()
        let splitChildren = allChildren.splitTrimming(separator: ",")
        
        if bagLookup[parentName] == nil {
            bagLookup[parentName] = BagConfig(bagName: parentName)
        }
        
        for child in splitChildren {
            let elements = child.splitTrimming(separator: " ")
            let count = Int(elements[0]) ?? 0
            let childName = elements[1..<elements.count].joined(separator: " ")
            
            bagLookup[parentName]?.children[childName] = count
            
            if bagLookup[childName] != nil {
                bagLookup[childName]?.parents.insert(parentName)
            } else {
                var newBag = BagConfig(bagName: childName)
                newBag.parents.insert(parentName)
                bagLookup[childName] = newBag
            }
        }
    }
    return bagLookup
}


private extension String {
    func bagColor() -> String {
        return replacingOccurrences(of: "bags", with: "")
            .replacingOccurrences(of: "bag", with: "")
            .replacingOccurrences(of: ".", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

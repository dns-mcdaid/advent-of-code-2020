//
//  Parser.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/1/20.
//

import Foundation

func parseIntList(fileName: String) -> [Int] {
    do {
        let fileStr = try parseFileContents(fileName: fileName)
        return convertStringToListOfInts(fileStr)
    } catch {
        print("Error building list of ints for \(fileName)")
        print(error)
    }
    return []
}

func parseFileLines(fileName: String, omittingEmptySubsequences: Bool = true) -> [String] {
    do {
        let fileStr = try parseFileContents(fileName: fileName)
        return fileStr.lines(omittingEmptySubsequences: omittingEmptySubsequences)
    } catch {
        print("Error getting lines from file \(fileName)")
        print(error)
    }
    return []
}

func convertStringToListOfInts(_ str: String) -> [Int] {
    // Not doing a compactMap here because I definitely want to know if there's a failure.
    return str.lines().map { Int($0)! }
}

func parseFileContents(fileName: String) throws -> String {
    guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
        throw "Error coming up with a URL for \(fileName).txt"
    }
    return try String(contentsOf: fileUrl)
}

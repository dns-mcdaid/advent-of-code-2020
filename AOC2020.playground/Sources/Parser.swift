import Foundation

public func parseIntList(fileName: String) -> [Int] {
    let parseResult = parseFileContents(fileName: fileName)
    
    switch parseResult {
        case .error:
            return []
        case .succces(let result):
            return convertStringToListOfInts(result)
    }
}

func convertStringToListOfInts(_ str: String) -> [Int] {
    return str.trimmingCharacters(in: .whitespacesAndNewlines)
        .split(separator: "\n")
        // Not doing a compactMap here because I definitely want to know if there's a failure.
        .map { Int($0)! }
}


enum ParseResult {
    case succces(result: String)
    case error
}


func parseFileContents(fileName: String) -> ParseResult {
    guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
        print("Error coming up with a URL for \(fileName).txt")
        return .error
    }
    
    do {
        let fileContents = try String(contentsOf: fileUrl)
        return .succces(result: fileContents)
    } catch {
        print("Error parsing file contents:\n\(error)")
        return .error
    }
}

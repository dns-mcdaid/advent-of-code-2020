import Foundation

public protocol Day {
    var fileName: String { get }
    associatedtype DataType
    var data: DataType { get }
    
    func part01Result(input: DataType) -> String
    func part02Result(input: DataType) -> String
}

extension Day {
    public func run() {
        let result01 = part01Result(input: data)
        let result02 = part02Result(input: data)
        print("Part 01: \(result01)")
        print("Part 02: \(result02)")
    }
}

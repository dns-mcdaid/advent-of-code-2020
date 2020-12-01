import Foundation

let days = [
    Day01()
]

func prettyDay(index: Int) -> String {
    let adjusted = index + 1
    return adjusted < 10 ? "0\(adjusted)" : "\(adjusted)"
}

for i in 0..<days.count {
    print("==== Day \(prettyDay(index: i)) ====")
    days[i].run()
    print()
}

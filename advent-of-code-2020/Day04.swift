//
//  Day04.swift
//  advent-of-code-2020
//
//  Created by Dennis McDaid on 12/4/20.
//

import Foundation

let day04 = Day<[Passport]>(
    input: "input_04",
    transformer: buildPassports,
    part01Result: part01Result,
    part02Result: part02Result
)

struct Passport : Codable {
    let birthYearStr: String
    let issueYearStr: String
    let expirationYearStr: String
    let heightStr: String
    let hairColor: String
    let eyeColorStr: String
    let passportId: String
    let countryId: String?
    
    enum CodingKeys: String, CodingKey {
        case birthYearStr = "byr"
        case issueYearStr = "iyr"
        case expirationYearStr = "eyr"
        case heightStr = "hgt"
        case hairColor = "hcl"
        case eyeColorStr = "ecl"
        case passportId = "pid"
        case countryId = "cid"
    }
}

struct SanitizedPassport {
    let birthYear: Int
    let issueYear: Int
    let expirationYear: Int
    let height: Height
    let hairColor: String
    let eyeColor: EyeColor
    let passportId: String
    let countryId: String?
}

struct Height {
    let type: HeightType
    let units: Int
}

enum HeightType: String, CaseIterable {
    case centimeters = "cm"
    case inches = "in"
}

enum EyeColor: String, Codable, CaseIterable {
    case amb
    case blu
    case brn
    case gry
    case grn
    case hzl
    case oth
}

private func maybeSanitizePassport(_ passport: Passport) -> SanitizedPassport? {
    guard let birthYear = Int(passport.birthYearStr) else { return nil }
    guard let issueYear = Int(passport.issueYearStr) else { return nil }
    guard let expirationYear = Int(passport.expirationYearStr) else { return nil }
    guard let height = maybeBuildHeight(passport.heightStr) else { return nil }
    guard let eyeColor = EyeColor.allCases.first(where: { $0.rawValue == passport.eyeColorStr }) else { return nil }
    
    return SanitizedPassport(
        birthYear: birthYear,
        issueYear: issueYear,
        expirationYear: expirationYear,
        height: height,
        hairColor: passport.hairColor,
        eyeColor: eyeColor,
        passportId: passport.passportId,
        countryId: passport.countryId
    )
}

private func maybeBuildHeight(_ str: String) -> Height? {
    var runningUnitTotal = 0
    var heightSuffix = ""
    for char in str {
        if let charInt = Int(String(char)) {
            runningUnitTotal *= 10
            runningUnitTotal += charInt
        } else {
            heightSuffix.append(char)
        }
    }
    
    guard let heightType = HeightType.allCases.first(where: { $0.rawValue == heightSuffix }) else {
        return nil
    }
    
    return runningUnitTotal > 0 ? Height(type: heightType, units: runningUnitTotal) : nil
}

private func part01Result(_ passports: [Passport]) -> String {
    return "\(passports.count)"
}

private func part02Result(_ passports: [Passport]) -> String {
    let sanitized = passports.compactMap {
        maybeSanitizePassport($0)
    }
    let filtered = sanitized.filter { $0.isValid }
    return "\(filtered.count)"
}

private func buildPassports(fileName: String) -> [Passport] {
    let allData = parseFileLines(fileName: fileName, omittingEmptySubsequences: false)
    var activeLineStack: [String] = []
    var passports: [Passport] = []
    
    for line in allData {
        if line.isEmpty {
            if let passport = maybeBuildPassport(lines: activeLineStack) {
                passports.append(passport)
            }
            activeLineStack.removeAll()
        } else {
            activeLineStack.append(line)
        }
    }
    
    if !activeLineStack.isEmpty, let passport = maybeBuildPassport(lines: activeLineStack) {
        passports.append(passport)
    }
    return passports
}

private func maybeBuildPassport(lines: [String]) -> Passport? {
    let joined = lines.joined(separator: " ")
    let split = joined.splitTrimming(separator: " ")
    
    var dictionary: [String: String] = [:]
    
    split.forEach { combo in
        let (key, value) = combo.splitTrimming(separator: ":").firstTwo()
        dictionary[key] = value
    }
    
    return try? Passport.init(from: dictionary)
}


extension SanitizedPassport {
    private var validBirthYear : Bool {
        (1920...2002).contains(birthYear)
    }
    
    private var validIssueYear: Bool {
        (2010...2020).contains(issueYear)
    }
    
    private var validExpirationYear: Bool {
        (2020...2030).contains(expirationYear)
    }
    
    private var validHeight: Bool {
        switch height.type {
            case .centimeters:
                return (150...193).contains(height.units)
            case .inches:
                return (59...76).contains(height.units)
        }
    }
    
    private var validHairColor: Bool {
        hairColor.matchesRegex(pattern: "#[0-9a-f]{6}")
    }
    
    private var validPassportId: Bool {
        passportId.count == 9 && passportId.allSatisfy({ Int(String($0)) != nil })
    }
    
    var isValid: Bool {
        validBirthYear && validIssueYear && validExpirationYear
            && validHeight && validHairColor && validPassportId
    }
}

extension Decodable {
    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}


let testInvalidData = [
    "eyr:1972 cid:100",
    "hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926",
    "",
    "iyr:2019",
    "hcl:#602927 eyr:1967 hgt:170cm",
    "ecl:grn pid:012533040 byr:1946",
    "",
    "hcl:dab227 iyr:2012",
    "ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277",
    "",
    "hgt:59cm ecl:zzz",
    "eyr:2038 hcl:74454a iyr:2023",
    "pid:3556412378 byr:2007"
]

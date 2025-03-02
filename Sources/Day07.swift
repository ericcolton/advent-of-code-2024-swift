import Algorithms

struct OperationType: OptionSet {
  let rawValue: Int

  static let add = OperationType(rawValue: 1 << 0)
  static let multiply = OperationType(rawValue: 1 << 1)
  static let concatenate = OperationType(rawValue: 1 << 2)
}

struct Day07: AdventDay {
  
  typealias CalibrationEntry = (total: Int, operands: [Int])
  typealias InputDataType = [CalibrationEntry]
  
  let inputData : InputDataType
    
  init(data: String) {
    self.inputData = Self.parseInputData(rawData: data)
  }
  
  private static func parseCalibrationEntry(_ line: String) -> CalibrationEntry {
    let components = line.split(separator: " ")
    return (
      total: Int(components[0].dropLast())!,
      operands: components[1...].compactMap { Int($0) }
    )
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    return rawData.split(separator: "\n").map {
      parseCalibrationEntry(String($0))
    }
  }
  
  func _backtrack(entry: CalibrationEntry, index: Int, runningTotal: Int, _ allowedOperations: OperationType) -> Bool {
    if index == entry.operands.count {
      return runningTotal == entry.total  
    }
    // add    
    if (allowedOperations.contains(.add) && _backtrack(entry: entry, index: index + 1, runningTotal: runningTotal + entry.operands[index], allowedOperations)) {
      return true
    }

    // multiply
    if (allowedOperations.contains(.multiply) && _backtrack(entry: entry, index: index + 1, runningTotal: runningTotal * entry.operands[index], allowedOperations)) {
      return true
    }

    // concatenate
    if (allowedOperations.contains(.concatenate)) {
      let concatenatedValue = Int(String(runningTotal) + String(entry.operands[index]))!
      if (_backtrack(entry: entry, index: index + 1, runningTotal: concatenatedValue, allowedOperations)) {
        return true
      }
    }

    return false
  }
  
  func findEntryValue (_ entry: CalibrationEntry, _ allowedOperations: OperationType) -> Int {
    _backtrack(entry: entry, index: 0, runningTotal: 0, allowedOperations)
    ? entry.total
    : 0
  }

  func part1() -> Int {
    return inputData.map {
      findEntryValue($0, [.add, .multiply])
    }.reduce(0, +)
  }

   func part2() -> Int {
    return inputData.map {
      findEntryValue($0, [.add, .multiply, .concatenate])
    }.reduce(0, +)
  }
}

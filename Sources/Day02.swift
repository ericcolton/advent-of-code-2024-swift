import Algorithms

struct Day02: AdventDay {
  
  typealias InputDataType = [[Int]]
  
  let inputData : InputDataType
  
  init(data: String) {
    inputData = Self.parseInputData(rawData: data)
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    rawData.split(separator: "\n").compactMap {
      $0.split(separator: " ").compactMap {
        Int($0)
      }
    }
  }

  func isSafe(report: [Int], tolerance: Int) -> Bool {
    var errors = 0
    for i in 1..<report.count {
      let diff = report[i] - report[i - 1]
      if diff == 0 || abs(diff) > 3 {
        errors += 1
        if errors > tolerance {
          return false
        }
      }
      if i > 1 {
        let diffDecreasing = diff < 0
        let prevDiffDecreasing = report[i - 1] - report[i - 2] < 0
        if diffDecreasing != prevDiffDecreasing {
          errors += 1
          if errors > tolerance {
            return false
          }
        }
      }
    }
    return true
  }

  func part1() -> Int {
    inputData.filter { isSafe(report: $0, tolerance: 0) }.count
  }

  func part2() -> Int {
    inputData.filter { isSafe(report: $0, tolerance: 1) }.count
  }
}

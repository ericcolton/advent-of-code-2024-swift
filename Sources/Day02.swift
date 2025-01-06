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

  // Checks if the report is safe. Assumes the report has at least two elements.
  func isSafe(report: [Int]) -> Bool {
    let isDecreasing = report[1] < report[0]
    for i in 1..<report.count {
      let diff = report[i] - report[i - 1]
      if diff == 0 || abs(diff) > 3 || (diff > 0 && isDecreasing) || (diff < 0 && !isDecreasing) {
        return false
      }
    }
    return true
  }
  
  func isSafeRemovingAnySingleReport(report: [Int]) -> Bool {
    for i in report.indices {
      var candidate = report
      candidate.remove(at: i)
      if (isSafe(report: candidate)) {
        return true
      }
    }
    return false
  }

  func part1() -> Int {
    inputData.filter { isSafe(report: $0) }.count
  }

  func part2() -> Int {
    inputData.filter { isSafe(report: $0) || isSafeRemovingAnySingleReport(report: $0) }.count
  }
}

import Algorithms

struct Day03: AdventDay {
  
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

  func part1() -> Int {
    0
  }

  func part2() -> Int {
    0
  }
}

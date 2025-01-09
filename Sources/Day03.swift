import Algorithms

struct Day03: AdventDay {
  
  typealias InputDataType = [String]
  
  let inputData : InputDataType
  
  init(data: String) {
    inputData = Self.parseInputData(rawData: data)
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    rawData.split(separator: "\n").map { String($0) }
  }
  
  func part1() -> Int {
    let part1Regex = /mul\((\d+),(\d+)\)/
    return inputData.reduce(0) {
      $0 + $1.matches(of:part1Regex).compactMap {
        let (_, a, b) = $0.output
        if let intA = Int(a), let intB = Int(b) {
          return intA * intB
        }
        return nil
      }.reduce(0, +)
    }
  }
  
  func part2() -> Int {
    var enabled = true
    let part2Regex = /(do\(\))|(don't\(\))|(?:mul\((\d+),(\d+)\))/
    return inputData.reduce(0) { totalSum, line in
      line.matches(of:part2Regex).reduce(totalSum) {
        let (_, doMatch, dontMatch, mulA, mulB) = $1.output
        if doMatch != nil {
          enabled = true
        } else if dontMatch != nil {
          enabled = false
        } else if let mulA = mulA, let mulB = mulB, enabled {
          if let intA = Int(mulA), let intB = Int(mulB) {
            return $0 + intA * intB
          }
        }
        return $0
      }
    }
  }
}
    
    
//    inputData.reduce(0) {
//      $0 + $1.matches(of:/(mul)|(doRegex)(dont)/).compactMap {
//        let (_, mulA, mulB)
//        let (_, a, b) = $0.output
//        if let intA = Int(a), let intB = Int(b) {
//          return intA * intB
//        }
//        return nil
//      }.reduce(0, +)
//    }

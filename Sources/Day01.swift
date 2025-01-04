import Algorithms

struct Day01: AdventDay {
  
  typealias InputDataType = [(a: Int, b: Int)]
  
  let inputData : InputDataType
  
  init(data: String) {
    inputData = Self.parseInputData(rawData: data)
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    rawData.split(separator: "\n").compactMap {
      let components = $0.split(separator: " ")
      if components.count == 2,
         let a = Int(components[0]),
         let b = Int(components[1]) {
        return (a, b)
      }
      return nil
    }
  }

  func part1() -> Int {
    let listA = inputData.map { $0.a }.sorted()
    let listB = inputData.map { $0.b }.sorted()
    return zip(listA, listB).reduce(0) { $0 + abs($1.0 - $1.1) }
  }
  
  static func buildCounter<T:Hashable>(_ data: [T]) -> [T:Int] {
    data.reduce(into: [:]) { $0[$1, default:0] += 1 }
  }

  func part2() -> Int {
    let listA = inputData.map { $0.a }
    let counterB = Self.buildCounter(inputData.map { $0.b })
    return listA.reduce(into: 0) {
      $0 += $1 * (counterB[$1] ?? 0)
    }
  }
}

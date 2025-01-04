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

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    return 2
  }
}

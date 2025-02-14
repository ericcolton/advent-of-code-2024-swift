import Algorithms

struct Day05: AdventDay {
  
  typealias InputDataType = (pageOrderings: [Int:Set<Int>], updates: [[Int]])
  
  let inputData : InputDataType
  
  init(data: String) {
    inputData = Self.parseInputData(rawData: data)
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    let sections = rawData.split(separator: "\n\n")

    // parse page ordering rules
    var pageOrderingRules : [Int:Set<Int>] = [:]

    for pageOrderingRule in sections[0].split(separator: "\n") {
      let parts = pageOrderingRule.split(separator:"|")
      if let first = Int(parts[0]), let second = Int(parts[1]) {
        if pageOrderingRules[first] == nil {
          pageOrderingRules[first] = Set<Int>()
        }
        pageOrderingRules[first]!.insert(second)
      } else {
        // parse error
        assert(false)
      }
    }
    
    // parse updates
    let updates = sections[1].split(separator: "\n").compactMap() {
      $0.split(separator: ",").compactMap() {
        Int($0)
      }
    }

    return (pageOrderings: pageOrderingRules, updates: updates)
    // rawData.split(separator: "\n").compactMap {
    //   let components = $0.split(separator: " ")
    //   if components.count == 2,
    //      let a = Int(components[0]),
    //      let b = Int(components[1]) {
    //     return (a, b)
    //   }
    //   return nil
  }

  func part1() -> Int {
    print(inputData)
//    let listA = inputData.map { $0.a }.sorted()
//    let listB = inputData.map { $0.b }.sorted()
//    return zip(listA, listB).reduce(0) { $0 + abs($1.0 - $1.1) }
    return 0
  }

  func part2() -> Int {
    return 0
//    let listA = inputData.map { $0.a }
//    let counterB = Self.buildCounter(inputData.map { $0.b })
//    return listA.reduce(into: 0) {
//      $0 += $1 * (counterB[$1] ?? 0)
//    }
  }
}

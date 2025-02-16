import Algorithms

struct Day05: AdventDay {

  typealias PageOrderingRulesType = [Int:Set<Int>]
  typealias InputDataType = (pageOrderingRules: PageOrderingRulesType, updates: [[Int]])
  
  let inputData : InputDataType
  
  init(data: String) {
    inputData = Self.parseInputData(rawData: data)
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    let sections = rawData.split(separator: "\n\n")

    // parse page ordering rules
    var rules : PageOrderingRulesType = [:]

    for pageOrderingRule in sections[0].split(separator: "\n") {
      let parts = pageOrderingRule.split(separator:"|")
      if let first = Int(parts[0]), let second = Int(parts[1]) {
        if rules[first] == nil {
          rules[first] = Set<Int>()
        }
        rules[first]!.insert(second)
      } else {
        // parse error
        assert(false)
      }
    }
    
    // parse updates
    let updates = sections[1].split(separator: "\n").compactMap() {
      $0.split(separator: ",").compactMap() { Int($0) }
    }

    return (pageOrderingRules: rules, updates: updates)
  }
  
  func entryFollowsRules(first: Int, then: Int) -> Bool {
    if let val = inputData.pageOrderingRules[first] {
      return val.contains(then)
    }
    return false
  }
  
  func rowFollowsRules(_ row: [Int]) -> Bool {
    for (i, earlyEntry) in row.enumerated() {
      for laterEntry in row[(i + 1)...] {
        if !self.entryFollowsRules(first:earlyEntry, then:laterEntry) {
          return false
        }
      }
    }
    return true
  }

  func findCorrectlyOrderedRow(_ origRow: [Int]) -> [Int]? {
    var row = [origRow[0]]
    for i in 1..<origRow.count {
      row.append(origRow[i])
      if self.rowFollowsRules(row) { continue }
      for j in stride(from: i - 1, through: 0, by: -1) {
        row.swapAt(j, j + 1)
        if self.rowFollowsRules(row) { break }
        if j == 0 { return nil }
      }
    }
    return row
  }
  
  func findRowValue(_ row: [Int]) -> Int {
    self.rowFollowsRules(row)
      ? row[Int(row.count / 2)]
      : 0
  }
  
  func findRowValueRequiringReordering(_ row: [Int]) -> Int {
    if self.rowFollowsRules(row) {
      return 0
    }
    else if let reorderedRow = self.findCorrectlyOrderedRow(row) {
      return reorderedRow[reorderedRow.count / 2]
    }
    assert(false)
  }

  func part1() -> Int {
    return inputData.updates
      .map() { self.findRowValue($0) }
      .reduce(0, +)
  }

  func part2() -> Int {
    return inputData.updates
      .map() { self.findRowValueRequiringReordering($0) }
      .reduce(0, +)
  }
}

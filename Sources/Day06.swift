import Algorithms

struct Day06: AdventDay {

  typealias Coordinate = (y: Int, x: Int)
  typealias InputDataType = (start: Coordinate, grid:[[Bool]])
  
  let inputData : InputDataType
  
  init(data: String) {
    inputData = Self.parseInputData(rawData: data)
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    // parse all rows sep by \n
    // walk through each row, using map
    // save the origin
    var start : Coordinate? = nil
    let rows = rawData.split(separator: "\n")
    var grid: [[Bool]] = []
    for (y, row) in rows.enumerated() {
      var gridrow: [Bool] = []
      for (x, c) in row.enumerated() {
        var val = false
        if c == "^" {
          start = (y: y, x: x)
        } else if c == "#" {
          val = true
        }
        gridrow.append(val)
      }
      grid.append(gridrow)
    }
    
    guard let start = start else {
      assert(false)
    }
    return (start:start, grid:grid)
  }

  func part1() -> Int {
    
    return 0
  }

  func part2() -> Int {
    return 0
  }
}

import Algorithms

enum Direction: Int {
  case up = 0, right, down, left
  
  func rotateRight() -> Direction {
    Direction(rawValue:(rawValue + 1) % 4)!
  }
}

struct Coordinate: Hashable {
  let y: Int
  let x: Int
}

class Guard {
  let grid : [[Bool]]
  let bounds: (y: Int, x: Int)
  var location : Coordinate
  var direction : Direction = .up
  var seen : Set<Coordinate>
  var uniqueSteps: Int { seen.count }
  
  init(start: Coordinate, grid: [[Bool]]) {
    assert (grid.count > 0)
    self.grid = grid
    self.bounds = (y: grid.count - 1, x: grid[0].count - 1)
    self.location = start
    self.seen = Set()
  }
  
  private func inBounds(_ point: Coordinate) -> Bool {
    (0...bounds.y).contains(point.y) && (0...bounds.x).contains(point.x)
  }
    
  private func nextLocation() -> Coordinate {
    switch (direction) {
    case .up:    return Coordinate(y: location.y - 1, x: location.x)
    case .down:  return Coordinate(y: location.y + 1, x: location.x)
    case .left:  return Coordinate(y: location.y, x: location.x - 1)
    case .right: return Coordinate(y: location.y, x: location.x + 1)
    }
  }
  
  private func canAdvance() -> Bool {
    let nextLoc = self.nextLocation()
    return !self.inBounds(nextLoc) || !self.grid[nextLoc.y][nextLoc.x]
  }
  
  func advandeUntilOutofBounds() {
    while self.inBounds(location) {
      if self.canAdvance() {
        seen.insert(location)
        location = self.nextLocation()
      } else {
        direction = direction.rotateRight()
      }
    }
  }
}

struct Day06: AdventDay {
  
  typealias InputDataType = (start: Coordinate, grid:[[Bool]])
  
  let inputData : InputDataType
    
  init(data: String) {
    self.inputData = Self.parseInputData(rawData: data)
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    var start : Coordinate? = nil
    let grid = rawData.split(separator: "\n").enumerated().map() { (y, row) in
      row.enumerated().map() { (x, char) in
        if char == "^" { start = Coordinate(y:y, x:x) }
        return char == "#"
      }
    }
    return (start:start!, grid:grid)
  }
  

  func part1() -> Int {
    let theGuard = Guard(start: inputData.start, grid: inputData.grid)
    theGuard.advandeUntilOutofBounds()
    return theGuard.uniqueSteps
  }

  func part2() -> Int {
    return 0
  }
}

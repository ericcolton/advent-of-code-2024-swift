import Algorithms

enum Direction: Int {
  case up = 0, right, down, left
  
  func rotateRight() -> Direction {
    Direction(rawValue:(rawValue + 1) % 4)!
  }
}

enum CannotAdvanceReason {
  case outOfBounds, endlessLoop
}

struct Coordinate: Hashable {
  let y: Int
  let x: Int
}

class Guard {
  let grid : [[Bool]]
  let bounds: (y: Int, x: Int)
  let start : Coordinate
  var location : Coordinate
  var direction : Direction = .up
  var seen : [Coordinate:Set<Direction>]
  var uniqueSteps: Int { seen.count }
  
  init(start: Coordinate, grid: [[Bool]]) {
    assert (grid.count > 0 && grid[0].count > 0, "Grid cannot be empty")
    self.grid = grid
    self.bounds = (y: grid.count - 1, x: grid[0].count - 1)
    self.start = start
    self.location = start
    self.seen = [:]
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
  
  private func hasFallenIntoEndlessLoop() -> Bool {
    seen[location] != nil && seen[location]!.contains(direction)
  }
  
  private func checkForEndlessLoop() -> Bool {
    if seen[location]?.contains(direction) == true {
      return true
    }
    seen[location, default:[]].insert(direction)
    return false
  }
  
  func advanceWhilePossible() -> CannotAdvanceReason {
    while self.inBounds(location) {
      if self.checkForEndlessLoop() {
        return .endlessLoop
      } else if self.canAdvance() {
        location = self.nextLocation()
      } else {
        direction = direction.rotateRight()
      }
    }
    return .outOfBounds
  }
  
  func visitedPoints() -> [Coordinate] {
    seen.keys.filter() { $0 != start }
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
  
  private func checkAddedBarrierFor(point: Coordinate) -> Bool {
    var modifiedGrid = inputData.grid
    modifiedGrid[point.y][point.x] = true
    let aGuard = Guard(start: inputData.start, grid: modifiedGrid)
    return aGuard.advanceWhilePossible() == .endlessLoop
  }
  
  private func countAddedBarriersThatLeadToEndlessLoops(barriers: [Coordinate]) -> Int {
    barriers.enumerated().filter{ (i, point) in
      self.checkAddedBarrierFor(point: point)
    }.count
  }

  func part1() -> Int {
    let theGuard = Guard(start: inputData.start, grid: inputData.grid)
    let reason = theGuard.advanceWhilePossible()
    assert(reason == .outOfBounds)
    return theGuard.uniqueSteps
  }

  func part2() -> Int {
    let theGuard = Guard(start: inputData.start, grid: inputData.grid)
    let reason = theGuard.advanceWhilePossible()
    assert(reason == .outOfBounds)
    return countAddedBarriersThatLeadToEndlessLoops(barriers: theGuard.visitedPoints())
  }
}

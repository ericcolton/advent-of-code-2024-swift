import Algorithms

enum Direction: Int {
  case up = 0, right, down, left
}

struct Coordinate: Hashable {
  let y: Int
  let x: Int
}

class Guard {
  let grid : [[Bool]]
  let yMax : Int
  let xMax : Int
  var location : Coordinate
  var direction : Direction = .up
  var seen : Set<Coordinate>
  var uniqueSteps: Int {
    get { seen.count }
  }
  
  init(start: Coordinate, grid: [[Bool]]) {
    self.grid = grid
    self.yMax = grid.count - 1
    guard self.yMax >= 0 else {
      assert(false)
    }
    self.xMax = grid[0].count - 1
    self.location = start
    self.seen = Set()
  }
  
  private func inBounds(_ point: Coordinate) -> Bool {
    point.x >= 0 && point.x <= xMax && point.y >= 0 && point.y <= yMax
  }
    
  private func nextLocation() -> Coordinate {
    switch (direction) {
    case .up:
      return Coordinate(y: location.y - 1, x: location.x)
    case .down:
      return Coordinate(y: location.y + 1, x: location.x)
    case .left:
      return Coordinate(y: location.y, x: location.x - 1)
    case .right:
      return Coordinate(y: location.y, x: location.x + 1)
    }
  }
  
  private func canAdvance() -> Bool {
    let nextLoc = self.nextLocation()
    if self.inBounds(nextLoc) {
      return !self.grid[nextLoc.y][nextLoc.x]
    }
    return true
  }
  
  private func rotateRight() {
    if let newDirection = Direction(rawValue:(direction.rawValue + 1) % 4) {
      direction = newDirection
    } else {
      assert(false)
    }
  }
  
  func advandeUntilOutofBounds() {
    while self.inBounds(location) {
      if self.canAdvance() {
        seen.insert(location)
        location = self.nextLocation()
      } else {
        self.rotateRight()
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
    
    guard let start = start else {
      assert(false)
    }
    return (start:start, grid:grid)
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

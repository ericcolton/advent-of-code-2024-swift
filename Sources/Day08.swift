import Algorithms

struct Day08: AdventDay {
  
  struct Coordinate: Hashable {
    let y: Int
    let x: Int
  }
  
  typealias InputDataType = [Character:[Coordinate]]
  
  let inputData : InputDataType
  let yMax : Int
  let xMax : Int
  
  init(data: String) {
    (yMax, xMax, inputData) = Self.parseInputData(rawData: data)
  }

  private static func parseInputData(rawData: String) -> (Int, Int, InputDataType) {
    var (y, x, yMax, xMax) = (0, 0, 0, 0)
    var lookup: InputDataType = [:]
    for c in rawData {
      if c == "\n" {
        y += 1
        x = 0
        continue
      }
      if c != "." {
        lookup[c, default: []].append(Coordinate(y: y, x: x))
      }
      xMax = max(xMax, x)
      yMax = max(yMax, y)
      x += 1
    }

    return (yMax, xMax, lookup)
  }

  func part1() -> Int {
    var antiNodeGrid : Set<Coordinate> = []
    for coordinates in inputData.values {
      for i in 0..<(coordinates.count - 1) {
        for j in (i+1)..<coordinates.count {
          let (iCoord, jCoord) = (coordinates[i], coordinates[j])
          let (yDelta, xDelta) = (jCoord.y - iCoord.y, jCoord.x - iCoord.x)
          for cand in [Coordinate(y: iCoord.y - yDelta, x: iCoord.x - xDelta),
                            Coordinate(y: jCoord.y + yDelta, x: jCoord.x + xDelta)] {
            if cand.x >= 0 && cand.x <= xMax && cand.y >= 0 && cand.y <= yMax {
              antiNodeGrid.insert(cand)
            }
          }
        }
      }
    }
    return antiNodeGrid.count
  }

  func part2() -> Int {
    return 0
  }
}

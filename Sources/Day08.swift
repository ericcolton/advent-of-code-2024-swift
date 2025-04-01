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
  
  func processCoordPairDirection(_ coord: Coordinate, _ delta: Coordinate, _ antiNodes: inout Set<Coordinate>, _ extended: Bool) {
    var cand = coord
    while true {
      cand = Coordinate(y: cand.y - delta.y, x: cand.x - delta.x)
      if cand.x < 0 || cand.x > xMax || cand.y < 0 || cand.y > yMax {
        break
      }
      antiNodes.insert(cand)
      if !extended { break }
    }
  }
  
  func processCoordPair(a: Coordinate, b: Coordinate, antiNodes: inout Set<Coordinate>, extended: Bool) {
    let delta = Coordinate(y: a.y - b.y, x: a.x - b.x)
    let negDelta = Coordinate(y: -delta.y, x: -delta.x)
    processCoordPairDirection(extended ? a : b, delta, &antiNodes, extended)
    processCoordPairDirection(extended ? b : a, negDelta, &antiNodes, extended)
  }
  
  func countAntiNodes(extended: Bool) -> Int {
    var antiNodes : Set<Coordinate> = []
    for coords in inputData.values {
      for i in 0..<(coords.count - 1) {
        for j in (i+1)..<coords.count {
          processCoordPair(a: coords[i], b: coords[j], antiNodes: &antiNodes, extended: extended)
        }
      }
    }
    return antiNodes.count
  }

  func part1() -> Int {
    return countAntiNodes(extended: false)
  }
  
  func part2() -> Int {
    return countAntiNodes(extended: true)
  }
}

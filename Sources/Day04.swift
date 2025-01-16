import Algorithms

struct Day04: AdventDay {
  
  typealias InputDataType = [[Character]]
  typealias Delta = (x: Int, y: Int)
  
  let inputData : InputDataType
  private let maxY: Int
  private let maxX: Int
  private let target = Array("XMAS")
  private let allDeltas = [Delta(x: -1, y: -1),
                           Delta(x: -1, y: 0),
                           Delta(x: -1, y: 1),
                           Delta(x: 0, y: -1),
                           Delta(x: 0, y: 1),
                           Delta(x: 1, y: -1),
                           Delta(x: 1, y: 0),
                           Delta(x: 1, y: 1)]
  
  init(data: String) {
    inputData = Self.parseInputData(rawData: data)
    // throw if maxY == 0
    maxY = inputData.count
    maxX = inputData[0].count
  }
  
  private static func parseInputData(rawData: String) -> InputDataType {
    rawData.split(separator: "\n").compactMap {
      Array($0)
    }
  }
  
  func checkSimpleMatch(y: Int, x: Int, delta: Delta, index: Int = 1) -> Bool {
    if index == target.count {
      return true
    }
    let newY = y + delta.y
    let newX = x + delta.x
    if newY < 0 || newX < 0 || newY >= maxY || newX >= maxX || inputData[newY][newX] != target[index] {
      return false
    }
    return checkSimpleMatch(y:newY, x:newX, delta: delta, index: index + 1)
  }
  
  func checkCrossMatch(y: Int, x: Int) -> Bool {
    // identify cells a,b,c, d w/ respect to current location:
    // a.b
    // .X.
    // c.d
    let pointA = inputData[y - 1][x - 1]
    let pointB = inputData[y - 1][x + 1]
    let pointC = inputData[y + 1][x - 1]
    let pointD = inputData[y + 1][x + 1]
    let slash = (pointB == target[1] && pointC == target[3]) || (pointC == target[1] && pointB == target[3])
    let backslash = (pointA == target[1] && pointD == target[3]) || (pointD == target[1] && pointA == target[3])
    return slash && backslash
  }

  func part1() -> Int {
    (0..<maxY).flatMap { y in
      (0..<maxX).map { x in
        inputData[y][x] == target[0]
        ? allDeltas.filter { checkSimpleMatch(y:y, x:x, delta:$0) }.count
        : 0
      }
    }.reduce(0, +)
  }
  
  func part2() -> Int {
    (1..<maxY-1).map { y in
      (1..<maxX-1).filter { x in
        inputData[y][x] == target[2] && checkCrossMatch(y:y, x:x)
      }.count
    }.reduce(0, +)
  }
}

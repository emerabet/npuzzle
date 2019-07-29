//
//  Solvability.swift
//  testnpuzzle
//
//  Created by Leo-taro FUJIMOTO on 7/28/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

extension Array where Element == Array<Int> {
    var flatArray: [Int] {
        return self.flatMap({$0})
    }
    var flatArrayCoord: Dictionary<Int, Int> {
        var coordinates: Dictionary<Int, Int> = [:]
        for (index, number) in flatArray.enumerated() {
            coordinates[number] = index
        }
        return coordinates
    }
}

func checkIfSolvable(state: [[Int]], goalState: [[Int]], storedGoalCoordinates: Dictionary<Int, (row: Int, col: Int)>, size: Int, printMessage: Bool = false) -> Bool {
    let flatState = state.flatArray
    let storedStateCoordinates: Dictionary<Int, (row: Int, col: Int)> = storeGoalCoordinates(goalState: state, size: size)
    var inversions = 0
    let length = flatState.count - 1
    for valueA in ((size + 1) % 2)...(length - 1) {
        for valueB in (valueA + 1)...(length) {
            let objA = storedStateCoordinates[valueA]
            let objB = storedStateCoordinates[valueB]
            let retA = goalState[objA!.row][objA!.col]
            let retB = goalState[objB!.row][objB!.col]
            let add = (retB != 0 && (retA == 0 || retA > retB)) ? 1 : 0
            inversions = inversions + add
        }
    }
    let isOddSize: Bool = (size + 1) % 2 == 1
    let isOddInversions: Bool = inversions % 2 == 1
    let col: Int = abs(storedGoalCoordinates[0]!.col - storedStateCoordinates[0]!.col)
    let row: Int = abs(storedGoalCoordinates[0]!.row - storedStateCoordinates[0]!.row)
    let posBlank: Int = col + row
    let isOddPosBlank:Bool = posBlank % 2 == 1
    if (isOddSize && !isOddInversions) || (!isOddSize && (isOddInversions && !isOddPosBlank) || (!isOddInversions && isOddPosBlank)) {
//        if inversions > 30 {
//            return false
//        }
        return true
    }
    if printMessage {
        print("NOT SOLVABLE")
    }
    return false
}


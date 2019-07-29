//
//  Generator.swift
//  testnpuzzle
//
//  Created by Leo-taro FUJIMOTO on 7/28/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

func npuzzleGenerator(size: Int, solvable: Bool = true) -> [[Int]] {
    let nbPieces = size * size - 1
    var stop: Bool = false

    while !stop {
        var flatArray: [Int] = Array(0...nbPieces)
        var flatShuffledArray: [Int] = []
        var generatedState: [[Int]] = []
        for _ in 0..<flatArray.count
        {
            let rand = Int(arc4random_uniform(UInt32(flatArray.count)))
            flatShuffledArray.append(flatArray[rand])
            flatArray.remove(at: rand)
        }
        for i in 0...(size - 1) {
            generatedState.append(Array(flatShuffledArray[(i * size)...(i * size + size - 1)]))
        }
        let goalState = findGoal(startingState: generatedState, size: size - 1)
        let storedGoalCoordinates = storeGoalCoordinates(goalState: goalState, size: size - 1)
        if checkIfSolvable(state: generatedState, goalState: goalState, storedGoalCoordinates: storedGoalCoordinates, size: size - 1) == solvable {
            stop = true
            return generatedState
        }
    }
}

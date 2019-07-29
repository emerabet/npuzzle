//
//  Algo.swift
//  Cli-Npuzzle
//
//  Created by Eric MERABET on 7/27/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

class Algo {
    let startState: [[Int]]
    let goalState: [[Int]]
    let size: Int
    let weight: Int
    let fnChoosenHeuristic: ([[Int]]) -> Int
    let storedGoalCoordinates: Dictionary<Int, (row: Int, col: Int)>
    var progress: Int = 0
    
    init (startState: [[Int]], goalState: inout [[Int]], weight: Int, _ storedGoalCoordinates: Dictionary<Int, (row: Int, col: Int)>, choosenHeuristic: @escaping ([[Int]]) -> Int) {
        self.startState = startState
        self.goalState = goalState
        self.size = startState.count - 1
        self.weight = weight
        self.fnChoosenHeuristic = choosenHeuristic
        self.storedGoalCoordinates = storedGoalCoordinates
    }
}

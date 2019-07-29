//
//  Engine.swift
//  testnpuzzle
//
//  Created by Leo-taro FUJIMOTO on 7/27/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

enum Algorithm {
    case ASTAR
    case GREEDY
}

class Engine {
    let startState: [[Int]]
    var goalState: [[Int]]
    var storedGoalCoordinates: Dictionary<Int, (row: Int, col: Int)>
    let size: Int
    let weight: Int // weight of the heuristic
    var performHeuristic: Dictionary<Heuristic, ([[Int]]) -> Int>?
    let choosenHeuristic: Heuristic
    let choosenAlgorithm: Algorithm

    var count = 0
    
    init(startState: [[Int]], goalState: [[Int]], storedGoalCoordinates: Dictionary<Int, (row: Int, col: Int)>, choosenHeuristic: Heuristic, choosenAlgorithm: Algorithm, weight: Int = 1) {
        self.startState = startState
        self.size = startState.count - 1
        self.weight = weight
        self.choosenHeuristic = choosenHeuristic
        self.choosenAlgorithm = choosenAlgorithm
        self.goalState = goalState
        self.storedGoalCoordinates = storedGoalCoordinates
        self.performHeuristic = getHeuristics(size: self.size, goalState: self.goalState, storedGoalCoordinates: self.storedGoalCoordinates)
    }
    
    

    func execute() -> [Move] {
        var strategy: SearchPath?
        switch choosenAlgorithm {
        case .ASTAR:
            strategy = AstarStrategy(startState: startState, goalState: &goalState, weight: weight, self.storedGoalCoordinates, choosenHeuristic: performHeuristic![choosenHeuristic]!)
        case .GREEDY:
            strategy = GreedyStrategy(startState: startState, goalState: &goalState, weight: weight, self.storedGoalCoordinates, choosenHeuristic: performHeuristic![choosenHeuristic]!)
        }
        return strategy!.execute()
    }
}

extension Array where Element == Array<Int> {
    func findCoordinates(_ number: Int, size: Int) -> (row: Int, col: Int)? {
        for i in 0...size {
            for j in 0...size {
                if self[i][j] == number {
                    return (i, j)
                }
            }
        }
        return nil
    }
}

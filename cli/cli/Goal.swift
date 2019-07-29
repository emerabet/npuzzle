//
//  Goal.swift
//  Cli-Npuzzle
//
//  Created by Leo-taro FUJIMOTO on 7/28/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

func findGoal(startingState: [[Int]], size: Int) -> [[Int]] {
    var goal: [[Int]] = startingState
    var numbers: [Int] = goal.flatMap({
        $0
    }).filter({
        $0 != 0
    })
    numbers = numbers.sorted(by: {$0 < $1})
    var numberIndex = 0
    var x = 0
    for y in 0...(size / 2) {
        for xx in (x)...(size - x) {
            goal[y][xx] = numberIndex < numbers.count ? numbers[numberIndex] : 0
            numberIndex = numberIndex + 1
        }
        if (y + 1) <= (size - y - 1) {
            for yy in (y + 1)...(size - y - 1) {
                goal[yy][size - x] = numberIndex < numbers.count ? numbers[numberIndex] : 0
                numberIndex = numberIndex + 1
            }
        }
        for xx in (x...(size - x)).reversed() {
            goal[size - y][xx] = numberIndex < numbers.count ? numbers[numberIndex] : 0
            numberIndex = numberIndex + 1
        }
        if (y + 1) <= (size - y - 1) {
            for yy in ((y + 1 )...(size - y - 1)).reversed() {
                goal[yy][x] = numberIndex < numbers.count ? numbers[numberIndex] : 0
                numberIndex = numberIndex + 1
            }
        }
        x = x + 1
    }
    return goal
}

func storeGoalCoordinates(goalState: [[Int]], size: Int) -> Dictionary<Int, (row: Int, col: Int)> {
    var storedCoord: Dictionary<Int, (row: Int, col: Int)> = [:]
    
    for i in 0...size {
        for j in 0...size {
            storedCoord[goalState[i][j]] = (row: i, col: j)
        }
    }
    return storedCoord
}


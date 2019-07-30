//
//  Astar.swift
//  Cli-Npuzzle
//
//  Created by Eric MERABET on 7/27/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

class AstarStrategy : Algo, SearchPath {
    func execute() -> [Move] {
        let (x, y) = startState.findCoordinates(0, size: self.size)!
        let (goalX, goalY) = storedGoalCoordinates[0]!
        
        let root = Node(state: startState, parent: nil, zeroRow: x, zeroCol: y, cost: 0, heuristic: self.fnChoosenHeuristic(startState) * self.weight)
        let goalNode = Node(state: goalState, parent: nil, zeroRow: goalX, zeroCol: goalY, cost: 0)
        var openList = PriorityQueue(queue: [root])
        var closedList = Dictionary<String, Node>()
        var nb: Int = 0
        while (!openList.isEmpty) {
            if (nb % 50000 == 0) {
                let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                if timeElapsed > 60 {
                    print("taking too much time -> stopped")
                    exit(0)
                }
            }
            
            let currentNode = openList.pop()
            let children = currentNode!.getChildren(weight: self.weight, fnCalculHeuristic: self.fnChoosenHeuristic)
            
            closedList[currentNode!.hash] = currentNode
            
            for child in children {
                // if child is the solution we can stop
                if (child == goalNode) {
                    closedList[child.hash] = child
                    print("Done")
                    let moves = child.draw()
                    print("Open list: ", openList.count)
                    print("Close list: ", closedList.count)
                    return moves
                }
                
                if (closedList[child.hash] == nil) {
                    openList.push(child)
                    self.progress += 1;
                    // if closedList.count % 1000 == 0 { print (closedList.count) }
                }
                
            }
            nb = nb + 1
        }
        return []
    }
}

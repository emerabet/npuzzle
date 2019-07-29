//
//  Greedy.swift
//  testnpuzzle
//
//  Created by Eric MERABET on 7/27/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

class GreedyStrategy : Algo, SearchPath {
    func execute() -> [Move] {
        let (x, y) = startState.findCoordinates(0, size: self.size)!
        let (goalX, goalY) = storedGoalCoordinates[0]!
        
        let root = Node(state: startState, parent: nil, zeroRow: x, zeroCol: y, cost: 0, heuristic: self.fnChoosenHeuristic(startState) * self.weight)
        let goalNode = Node(state: goalState, parent: nil, zeroRow: goalX, zeroCol: goalY, cost: 0)
        var openList = PriorityQueue(queue: [root])
        var closedList = Dictionary<String, Node>()
        
        var found: Bool = false
        
        var currentNode: Node? = root
        while (!found && currentNode != nil) {
            print("CURRENT", currentNode!.hash, currentNode!.score, currentNode!.cost, currentNode!.heuristic)

            let children = currentNode!.getChildren(weight: self.weight, fnCalculHeuristic: self.fnChoosenHeuristic)
            
            closedList[currentNode!.hash] = currentNode
            var bestChild: Node? = nil
            
            for child in children {
                print("CHILD", child.hash, child.score, child.cost, child.heuristic)
                
                // if child is the solution we can stop
                if (child == goalNode) {
                    found = true
                    closedList[child.hash] = child
                    print("Done")
                    let moves = child.draw()
                    print("Open list: ", openList.count)
                    print("Close list: ", closedList.count)
                    return moves
                }
                
                if (closedList[child.hash] == nil) {
                    if (bestChild == nil) {
                        bestChild = child
                    } else {
                        if child.score < bestChild!.score {
                            bestChild = child
                        }
                    }
                    openList.push(child)
                    self.progress += 1;
                }
            }
            currentNode = bestChild
        }
        return []
    }
}

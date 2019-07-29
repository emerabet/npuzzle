//
//  Node.swift
//  Cli-Npuzzle
//
//  Created by Eric MERABET on 7/24/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

class Node: Comparable, Hashable {
    let state: [[Int]]
    let parent: Node?
    let cost: Int
    var heuristic: Int
    let zeroRow: Int
    let zeroCol: Int
    let hash: String
    let flatState: [Int]
    
    var score: Int {
        return cost + heuristic
    }
    
    init(state: [[Int]], parent: Node?, zeroRow: Int, zeroCol: Int, cost: Int, heuristic: Int = 0) {
        self.state = state
        self.parent = parent
        self.cost = cost
        self.heuristic = heuristic
        self.zeroRow = zeroRow
        self.zeroCol = zeroCol
        self.flatState = Array(state.joined())
        
        var h = "";
        for i in self.flatState {
            h += String(i)
        }
        self.hash = h;
    }
    
    var hashValue: Int {
        return (Int) (cost + heuristic)
    }
    
    private func childFactory(state: inout [[Int]], _ x: Int, _ y: Int, _ newX: Int, _ newY: Int, _ weight: Int, _ fnCalculHeuristic: ([[Int]]) -> Int) -> Node {
        // swap new position
        state[x][y] = state[newX][newY]
        state[newX][newY] = 0
        
        // create child
        let child = Node(state: state, parent: self, zeroRow: newX, zeroCol: newY, cost: self.cost + 1, heuristic: fnCalculHeuristic(state) * weight)
        return child
    }
    
    func getChildren(weight: Int, fnCalculHeuristic: @escaping ([[Int]]) -> Int) -> [Node] {
        var children:[Node] = []
        
        let x = self.zeroRow
        let y = self.zeroCol
        
        var copyState: [[Int]];
        
        // Check if we can go up
        if (x > 0) {
            copyState = self.state;
            let newX = x - 1
            let newY = y
            children.append(childFactory(state: &copyState, x, y, newX, newY, weight, fnCalculHeuristic))
        }
        
        // down
        if (x < self.state.count - 1) {
            copyState = self.state;
            let newX = x + 1
            let newY = y
            children.append(childFactory(state: &copyState, x, y, newX, newY, weight, fnCalculHeuristic))
        }
        
        // left
        if (y > 0) {
            copyState = self.state;
            let newX = x
            let newY = y - 1
            children.append(childFactory(state: &copyState, x, y, newX, newY, weight, fnCalculHeuristic))
        }
        
        // right
        if (y < self.state[0].count - 1) {
            copyState = self.state;
            let newX = x
            let newY = y + 1
            children.append(childFactory(state: &copyState, x, y, newX, newY, weight, fnCalculHeuristic))
        }
        
        return children
    }
    
    func draw() -> [Move] {
        var moves: [Move] = []
        var nb = 0;
        let size = self.state.count - 1
        var current: Node? = self
        var lastX = 0
        var lastY = 0
        while current != nil {
            var drawing: String = ""
            print("\u{001B}[0;33mmove \(nb): scoreF \(current!.score) G \(current!.cost) H \(current!.heuristic)")
            for row in current!.state {
                for column in row {
                    drawing = drawing + String(describing: column) + " "
                }
                drawing = drawing + "\n"
            }
            
            print(drawing)
            
            let (curX, curY) = current!.state.findCoordinates(0, size: size)!
            if nb > 0 {
                if curX > lastX {
                    moves.append(.UP)
                } else if curX < lastX {
                    moves.append(.DOWN)
                } else if curY > lastY {
                    moves.append(.LEFT)
                } else if curY < lastY {
                    moves.append(.RIGHT)
                }
            }
            lastX = curX
            lastY = curY
            current = current!.parent
            nb = nb + 1
        }
        return moves.reversed()
    }
    
    static func <(lhs: Node, rhs: Node) -> Bool {
        return (lhs.cost + lhs.heuristic) < (rhs.cost + rhs.heuristic)
    }
    
    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.hash == rhs.hash
    }
}

//
//  PrQueue.swift
//  testnpuzzle
//
//  Created by Eric MERABET on 7/24/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

struct PriorityQueue {
    var queue: [Node] = []
    
   /* var queueInt: [Int] {
        return queue.flatMap({
            $0.scoreF
        })
    }*/
    
    var isEmpty : Bool {
        return queue.isEmpty
    }
    
    var count : Int {
        return queue.count
    }
    
    func peek() -> Node? {
        return queue.first
    }
    
    func isRoot(_ index: Int) -> Bool {
        return (index == 0)
    }
    
    func leftChildIndex(of index: Int) -> Int {
        return (2 * index) + 1
    }
    
    func rightChildIndex(of index: Int) -> Int {
        return (2 * index) + 2
    }
    
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    // lower score = higher priority
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return queue[firstIndex].score < queue[secondIndex].score
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex
            else { return }
        queue.swapAt(firstIndex, secondIndex)
    }
    
    
    
    mutating func goUp(index: Int) {
        let parentInd = parentIndex(of: index)
        if isHigherPriority(at: index, than: parentInd) {
            swapElement(at: index, with: parentInd)
            goUp(index: parentInd)
        }
        return
    }
    
    mutating func goDown(index: Int) {
        let childInd = highestPriorityIndex(for: index)
        if index == childInd { // 2
            return
        }
        if !isHigherPriority(at: index, than: childInd) {
            swapElement(at: index, with: childInd)
            goDown(index: childInd)
        }
        return
    }
    
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < queue.count && isHigherPriority(at: childIndex, than: parentIndex)
            else { return parentIndex }
        return childIndex
    }
    
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }
    
    
    mutating func enqueue(node: Node) {
        queue.append(node)
        goUp(index: queue.count - 1)
    }
    
    mutating func push(_ node: Node) {
        queue.append(node)
        goUp(index: queue.count - 1)
    }
    
    mutating func pop() -> Node? {
        
        guard !isEmpty
            else {return nil}
        swapElement(at: 0, with: queue.count - 1)
        let node = queue.removeLast()
        if !isEmpty {
            goDown(index: 0)
        }
        return node
    }
    
    mutating func dequeue() -> Node? {
        
        guard !isEmpty
            else {return nil}
        swapElement(at: 0, with: queue.count - 1)
        let node = queue.removeLast()
        if !isEmpty {
            goDown(index: 0)
        }
        return node
    }
    
}

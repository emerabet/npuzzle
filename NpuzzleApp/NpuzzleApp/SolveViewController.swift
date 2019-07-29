//
//  SolveViewController.swift
//  NpuzzleApp
//
//  Created by Leo-taro FUJIMOTO on 7/29/19.
//  Copyright © 2019 Leo-taro FUJIMOTO. All rights reserved.
//

import UIKit

var sizee: CGFloat = 3
extension SolveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (screenWidth - 10) / sizee , height: (screenWidth - 10) / sizee)
    }
}

class SolveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var values: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0]
    var moves: [Move] = []
    var started = false
    var nameImage = "nasa"
    
    
    var argsAlgo: Algorithm = Algorithm.ASTAR
    var argsHeuri: Heuristic = Heuristic.MANHATTAN
    var sizeChoosen: Int = 3 {
        didSet {
            sizee = CGFloat(sizeChoosen)
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! PuzzleCell
        cell.backgroundColor = .gray
        cell.myValue = (name: self.nameImage, value: values[indexPath.row], size: sizeChoosen)
        return cell
    }

    @IBAction func solveButtonPressed(_ sender: Any) {
        print("Solve pressed")
        if (self.started) {
            return
        }
        
        self.started = true
        let size = self.sizeChoosen
        let zeroPos = values.index(of: 0)
        let from = IndexPath(row: zeroPos!, section: 0)
            increaseLabel(from: from, index: 0, size: size)
    }
    
    
    func increaseLabel(from: IndexPath, index: Int, size: Int) {
        let move = moves[index]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            var to: IndexPath
            print("MOVE", move)
            switch move {
            case .DOWN:
                to = IndexPath(row: from.row + size, section: 0)
                self.collectionView.moveItem(at: from, to: to)
                self.collectionView.moveItem(at: IndexPath(row: to.row - 1, section: 0), to: from)
                break
            case .UP:
                to = IndexPath(row: from.row - size, section: 0)
                self.collectionView.moveItem(at: from, to: to)
                self.collectionView.moveItem(at: IndexPath(row: to.row + 1, section: 0), to: from)
                break
            case .LEFT:
                to = IndexPath(row: from.row - 1, section: 0)
                self.collectionView.moveItem(at: from, to: to)
                break
            case .RIGHT:
                to = IndexPath(row: from.row + 1, section: 0)
                self.collectionView.moveItem(at: from, to: to)
                break
            }
            print("From: ", from, " to: ", to)
            if index < self.moves.count - 1 && self.started {
                self.increaseLabel(from: to, index: index + 1, size: size)
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.started = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var state: [[Int]]
        let names: [String] = ["nasa", "42", "code"]
        self.nameImage = names[Int(arc4random_uniform(3))]

        let argsWeight: Int = 50
        state = npuzzleGenerator(size: self.sizeChoosen, solvable: true)
        values = state.flatArray
        let size = state.count - 1
        let goalState = findGoal(startingState: state, size: size)
        let storedGoalCoordinates = storeGoalCoordinates(goalState: goalState, size: size)
        if checkIfSolvable(state: state, goalState: goalState, storedGoalCoordinates: storedGoalCoordinates, size: size, printMessage: true) {
            
            let engine = Engine(startState: state, goalState: goalState, storedGoalCoordinates: storedGoalCoordinates, choosenHeuristic: .MANHATTAN, choosenAlgorithm: .ASTAR, weight: argsWeight)
            print("started")
            moves = engine.execute()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  ViewController.swift
//  NpuzzleApp
//
//  Created by Leo-taro FUJIMOTO on 7/29/19.
//  Copyright © 2019 Leo-taro FUJIMOTO. All rights reserved.
//

import UIKit

enum ArgsAlgorithm: String {
    case ASTAR = "astar"
    case UNIFORM = "uniform"
    case GREEDY = "greedy"
}

enum ArgsHeuristic: String {
    case MISPLACED = "misplaced"
    case EUCLIDEAN = "euclidean"
    case MANHATTAN = "manhattan"
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
        }
    }
    var algorithms: [ArgsAlgorithm] = [.ASTAR, .GREEDY, .UNIFORM]
    var heuristics: [ArgsHeuristic] = [.MISPLACED, .EUCLIDEAN, .MANHATTAN]
    var sizes: [Int] = [2, 3, 4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is SolveViewController
        {
            let vc = segue.destination as? SolveViewController
            
            var algo: Algorithm = .ASTAR
            var heur: Heuristic = .MANHATTAN
            
            
            let selectedAlgo: ArgsAlgorithm = algorithms[self.pickerView.selectedRow(inComponent: 0)]
            let selectedHeur: ArgsHeuristic = heuristics[self.pickerView.selectedRow(inComponent: 1)]
            let selectedSize: Int = sizes[self.pickerView.selectedRow(inComponent: 2)]
            
            if selectedAlgo == .GREEDY {
                algo = .GREEDY
            }
            
            if selectedAlgo == .UNIFORM {
                heur = .UNIFORM_COST
            } else if selectedHeur == .MISPLACED {
                heur = .MISSPLACED
            } else if selectedHeur == .EUCLIDEAN {
                heur = .EUCLIDEAN
            }
            
            self.pickerView.selectedRow(inComponent: 0)
            print(self.pickerView.selectedRow(inComponent: 1))
            print(self.pickerView.selectedRow(inComponent: 2))
            
            
            vc?.argsAlgo = algo
            vc?.argsHeuri = heur
            vc?.sizeChoosen = selectedSize
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return algorithms.count
        } else if component == 1 {
            return heuristics.count
        } else {
            return sizes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return algorithms[row].rawValue
        } else if component == 1{
            return heuristics[row].rawValue
        } else {
            return String(describing:sizes[row])
        }
    }
    @IBAction func continueButtonPressed(_ sender: Any) {
        print(self.pickerView.selectedRow(inComponent: 0))
         print(self.pickerView.selectedRow(inComponent: 1))
         print(self.pickerView.selectedRow(inComponent: 2))
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print(algorithms[row].rawValue)
        }
    }
}


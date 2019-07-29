//
//  SearchPath.swift
//  Cli-Npuzzle
//
//  Created by Eric MERABET on 7/27/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//

import Foundation

enum Move {
    case UP
    case DOWN
    case LEFT
    case RIGHT
}

protocol SearchPath {
    func execute() -> [Move]
}

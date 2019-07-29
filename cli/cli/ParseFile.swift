//
//  ParseFile.swift
//  Cli-Npuzzle
//
//  Created by Leo-taro FUJIMOTO on 7/27/19.
//  Copyright © 2019 Eric MERABET. All rights reserved.
//
import Foundation
enum ParseError: Error {
    case parseError(String)
}
class ParseFile {
    var filePaths: [String] = []
    let path: String
    
    init() {
        let fm = FileManager.default
        path = Bundle.main.resourcePath! + "/input_files"
        do {
            self.filePaths = try fm.contentsOfDirectory(atPath: path)
        } catch {
            filePaths = []
        }
    }
    
    func printFile(fileName: String) {
        do {
            let fileContent = try String(contentsOfFile: self.path + "/" + fileName, encoding: .utf8)
            print(fileContent)
        }
        catch {
            print("ERROR READING FILE")
        }
    }
    
    func parseState(fileName: String, directoryPath: String = Bundle.main.resourcePath! + "/input_files") throws -> [[Int]] {
        var state: [[Int]] = []
        var size: Int? = nil
        var containsZero: Bool = false
        var numberSet: Set<Int> = []
        
        do {
            let fileContent = try String(contentsOfFile: directoryPath + "/" + fileName, encoding: .utf8)
            if fileContent == "" {
                throw ParseError.parseError("Empty file")
            }
            let lines = fileContent.components(separatedBy: "\n")
            for line in lines {
                
                var lineNumbers: [Int] = []
                let characters = line.components(separatedBy: " ")
                
                if size == nil {
                    for char in characters {
                        let c = char.trimmingCharacters(in: .whitespaces)
                        if c.isEmpty {
                            continue ;
                        }
                        if c.starts(with: "#") {
                            break ;
                        }
                        if let num = Int(c) {
                            if size == nil {
                                size = num
                                if num < 2 {
                                    throw ParseError.parseError("Puzzle size must be at least 2")
                                }
                            } else {
                                throw ParseError.parseError("Invalid number for size")
                            }
                        } else {
                            throw ParseError.parseError("Invalid number for size")
                        }
                    }
                } else {
                    for char in characters {
                        let c = char.trimmingCharacters(in: .whitespaces)
                        if c.isEmpty {
                            continue ;
                        }
                        if c.starts(with: "#") {
                            break ;
                        }
                        if let num = Int(c) {
                            lineNumbers.append(num)
                            if numberSet.contains(num) {
                                throw ParseError.parseError("Two times the same number")
                            }
                            numberSet.insert(num)
                            if num == 0 {
                                containsZero = true
                            }
                            continue
                        } else {
                            throw ParseError.parseError("Invalid integer in State")
                        }
                    }
                    if lineNumbers.count == size! {
                        state.append(lineNumbers)
                    } else if lineNumbers.count > 0 {
                        throw ParseError.parseError("Invalid number of numbers in line")
                    }
                }
            }
            if state.count != size! || !containsZero {
                throw ParseError.parseError("Do not contains 0 or wrong line numbers")
            }
        }
        catch ParseError.parseError(let error){
            throw ParseError.parseError(error)
        }
        catch {throw ParseError.parseError("WRONG FILE")
        }
        return state;
    }
}

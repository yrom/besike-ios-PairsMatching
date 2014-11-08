//
//  GameLayout.swift
//  PairsMatchingGame
//
//  Created by yrom on 14-11-7.
//  Copyright (c) 2014年 yrom. All rights reserved.
//

import UIKit

class GameLayout {
    lazy var grid: [CGRect] = {
        var grid = [CGRect]()
        let rows = 5
        let cols = 4
        let size = CGSize(width: 65, height: 80)
        for row in 0..<rows {
            for col in 0..<cols {
                let x = 15+Int(size.width)*col+10*col
                let y = 70+Int(size.height)*row+10*row
                grid.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
            }
        }
        return grid
    }()
    
//    =====================
//    let grid: [CGRect] = {
//        var grid = [CGRect]()
//        let rows = 5
//        let cols = 4
//        
//        let size = CGSize(width: 65, height: 80)
//        for row in 0..<rows {
//            for col in 0..<cols {
//                let x = 15+Int(size.width)*col+10*col
//                let y = 70+Int(size.height)*row+10*row
//                grid.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
//            }
//        }
//        return grid
//    }()
//    
    
//  ======================
//    let grid = [CGRect]()
//    
//    init() {
//        let rows = 5
//        let cols = 4
//        let size = CGSize(width: 65, height: 80)
//        for row in 0..<rows {
//            for col in 0..<cols {
//                let x = 15+Int(size.width)*col+10*col
//                let y = 70+Int(size.height)*row+10*row
//                self.grid.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
//            }
//        }
//    }
    
}

extension GameLayout {
    
    /// Return the requested number of rectangles.
    func forPairs(pairs: Int) -> [CGRect] {
        assert(pairs >= 1 && pairs <= 10)
        var rects = [CGRect]()
        let layout = gameLayouts[pairs-1]
        
        for (i, rect) in enumerate(self.grid) {
            if layout[i] == 1 {
                rects.append(rect)
            }
        }
        
        return rects
    }

}

private let gameLayouts: [[Int]] = [
    [0,0,0,0,
        0,0,0,0,
        0,1,1,0,
        0,0,0,0,
        0,0,0,0],
    
    [0,0,0,0,
        0,0,0,0,
        1,1,1,1,
        0,0,0,0,
        0,0,0,0],
    
    [0,0,0,0,
        0,1,1,0,
        0,1,1,0,
        0,1,1,0,
        0,0,0,0],
    
    [0,0,0,0,
        1,0,0,1,
        1,1,1,1,
        1,0,0,1,
        0,0,0,0],
    
    [1,0,0,1,
        0,1,1,0,
        1,0,0,1,
        0,1,1,0,
        1,0,0,1],
    
    [0,1,1,0,
        1,0,0,1,
        1,1,1,1,
        1,0,0,1,
        0,1,1,0],
    
    [1,1,1,1,
        1,0,0,1,
        1,0,0,1,
        1,0,0,1,
        1,1,1,1],
    
    [1,1,1,1,
        1,0,0,1,
        1,1,1,1,
        1,0,0,1,
        1,1,1,1],
    
    [1,1,1,1,
        1,1,1,1,
        1,0,0,1,
        1,1,1,1,
        1,1,1,1],
    
    [1,1,1,1,
        1,1,1,1,
        1,1,1,1,
        1,1,1,1,
        1,1,1,1],
]



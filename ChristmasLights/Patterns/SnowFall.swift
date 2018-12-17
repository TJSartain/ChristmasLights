//
//  SnowFall.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/17/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class SnowFall: Pattern
{
    var snowFlakes = [[Location]]()

    override func start()
    {
        start(every: 0.2, with: nil)
    }

    override func start(every interval: TimeInterval, with info: Any?)
    {
        net.blackOut()
        snowFlakes = [[Location]]()
        super.start(every: interval, with: info)
    }

    override func draw(timer: Timer)
    {
        var cols = Set<Int>()
        while cols.count < Int.random(in: 1...4) {
            cols.insert(Int.random(in: 0..<net.columns))
        }
        if snowFlakes.count == net.rows {
            for col in 0..<snowFlakes[net.rows-1].count {
                net.turnOffBulb(snowFlakes[net.rows-1][col])
            }
            snowFlakes.removeLast()
        }
        for row in 0..<snowFlakes.count
        {
            for col in 0..<snowFlakes[row].count
            {
                net.turnOffBulb(snowFlakes[row][col])
                snowFlakes[row][col].row = row + 1
                net.setColor(color: .white, loc: snowFlakes[row][col])
            }
        }
        snowFlakes.insert([Location](), at: 0)
        for col in cols {
            snowFlakes[0].append((0, col))
            net.setColor(color: .white, loc: (0, col))
        }
    }
}

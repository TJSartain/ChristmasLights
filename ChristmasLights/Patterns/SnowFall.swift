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
    var snowFlakes = [[(Int, Location)]]()
    var useColor = false

    override func start()
    {
        start(every: 0.1, with: nil)
    }

    override func start(every interval: TimeInterval, with info: Any?)
    {
        net.blackOut()
        snowFlakes = [[(Int, Location)]]()
        useColor = Int.random(in: 0 ..< 2) < 1
        if useColor {
            colors = UIColor.colorCycle(n: 144)
        }
        super.start(every: interval, with: info)
    }

    override func draw(timer: Timer)
    {
        var cols = Set<Int>()
        while cols.count < Int.random(in: 0...2) {
            cols.insert(Int.random(in: 0..<net.columns))
        }
        if snowFlakes.count == net.rows {
            for col in 0..<snowFlakes[net.rows-1].count {
                net.turnOffBulb(snowFlakes[net.rows-1][col].1)
            }
            snowFlakes.removeLast()
        }
        for row in 0..<snowFlakes.count
        {
            for col in 0..<snowFlakes[row].count
            {
                net.turnOffBulb(snowFlakes[row][col].1)
                snowFlakes[row][col].1.row = row + 1
                if useColor {
                    net.setColor(color: colors[snowFlakes[row][col].0], loc: snowFlakes[row][col].1)
                } else {
                    net.setColor(color: .white, loc: snowFlakes[row][col].1)
                }
            }
        }
        snowFlakes.insert([(Int, Location)](), at: 0)
        for col in cols {
            if useColor {
                let c = Int.random(in: 0..<colors.count)
                snowFlakes[0].append((c, (0, col)))
                net.setColor(color: colors[c], loc: (0, col))
            } else {
                snowFlakes[0].append((0, (0, col)))
                net.setColor(color: .white, loc: (0, col))
            }
        }
        super.draw(timer: timer)
    }
}

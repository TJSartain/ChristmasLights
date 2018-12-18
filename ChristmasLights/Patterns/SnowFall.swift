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
        useColor = Int.random(in: 0 ..< 4) < 1
        if useColor {
            colors = UIColor.colorCycle(n: 144)
        }
        super.start(every: interval, with: info)
    }

    override func draw(timer: Timer)
    {
        var cols = Set<Int>()
        while cols.count < Int.random(in: 0...2) { // 0, 1, or 2 new flakes
            cols.insert(Int.random(in: 0..<net.columns))
        }
        if snowFlakes.count == net.rows { // we're full
            for col in 0..<snowFlakes[net.rows-1].count { // turn off last row
                net.turnOffLocation(snowFlakes[net.rows-1][col].1)
            }
            snowFlakes.removeLast() // delete from local collection
        }
        for row in 0..<snowFlakes.count
        {
            for col in 0..<snowFlakes[row].count
            {
                net.turnOffLocation(snowFlakes[row][col].1) // turn off current row
                snowFlakes[row][col].1.row = row + 1 // move flake to next row
                if useColor {
                    net.setColor(color: colors[snowFlakes[row][col].0], loc: snowFlakes[row][col].1)
                } else {
                    net.setColor(color: .white, loc: snowFlakes[row][col].1) // turn back on
                }
            }
        }
        snowFlakes.insert([(Int, Location)](), at: 0) // new row 0 in local collection
        for col in cols {
            if useColor {
                let c = Int.random(in: 0..<colors.count)
                snowFlakes[0].append((c, (0, col)))
                net.setColor(color: colors[c], loc: (0, col))
            } else {
                snowFlakes[0].append((0, (0, col))) // add to local collection
                net.setColor(color: .white, loc: (0, col)) // turn bulb on
            }
        }
        super.draw(timer: timer)
    }
}

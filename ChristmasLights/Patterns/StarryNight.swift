//
//  StarryNight.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/17/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class StarryNight: Pattern
{
    var starField = [Location]()

    override func start()
    {
        start(every: 0.1, with: nil)
    }

    override func start(every interval: TimeInterval, with info: Any?)
    {
        net.oneColor(placeholderColor)
        starField = [Location]()
        for _ in 0..<35 {
            let x = Int.random(in: 0..<net.columns)
            let y = Int.random(in: 0..<net.rows)
            starField.append((x, y))
            net.setColor(color: .white, row: y, column: x)
        }
        super.start(every: interval, with: info)
    }

    override func draw(timer: Timer)
    {
        let i = Int.random(in: 0..<starField.count)
        net.setColor(color: placeholderColor, loc: starField[i])
        let x = Int.random(in: 0..<net.columns)
        let y = Int.random(in: 0..<net.rows)
        starField[i] = (y, x)
        net.setColor(color: .white, loc: starField[i])
        super.draw(timer: timer)
    }
}

//
//  Spiral.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/17/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class Spiral: Pattern
{
    override func start()
    {
        start(every: 0.1, with: UIColor.colorCycle(n: net.rows))
    }

    override func start(every interval: TimeInterval, with info: Any?)
    {
        net.oneColor(placeholderColor)
        if let colors = info as? [UIColor] {
            self.colors = colors
            currentRow = 0
            currentCol = 0
            super.start(every: interval, with: nil)
        }
    }

    override func draw(timer: Timer)
    {
        for row in 0..<net.rows
        {
            let color = colors[(currentRow - row + net.rows) % net.rows]
            net.setColor(color: placeholderColor,
                               row: row,
                               column: (currentCol + 1 + row) % net.columns)
            net.setColor(color: color,
                               row: row,
                               column: (currentCol + row) % net.columns)
        }
        currentRow = (currentRow + 1) % net.rows
        currentCol = (currentCol - 1 + net.columns) % net.columns
        super.draw(timer: timer)
    }
}

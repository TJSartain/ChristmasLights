//
//  DoRows.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/14/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class RowsPattern: Pattern
{
    override func start()
    {
        start(every: 0.06, with: [RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, Emerald, RadicalRed, RadicalRed])
    }

    override func start(every interval: TimeInterval, with info: Any?)
    {
        if let colors = info as? [UIColor] {
            self.colors = colors
            currentRow = 0
            super.start(every: interval, with: nil)
        }
    }

    override func draw(timer: Timer)
    {
        for row in 0..<net.rows
        {
            let color = colors[((row + currentRow) % net.rows) % colors.count]
            for col in 0..<net.columns
            {
                net.setColor(color: color, row: row, column: col)
            }
        }
        currentRow = (currentRow + 1) % net.rows
        super.draw(timer: timer)
    }
}

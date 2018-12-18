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
        start(every: 0.06, with: UIColor.colorCycle(n: 24))
//        start(every: 0.06, with: [RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, Emerald, RadicalRed, RadicalRed])
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
            let color = colors[(row + currentRow) % colors.count]
            net.setRow(row, to: color)
        }
        currentRow = (currentRow + 1) % colors.count
        super.draw(timer: timer)
    }
}

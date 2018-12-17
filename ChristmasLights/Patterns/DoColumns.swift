//
//  DoColumns.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/14/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class ColumnsPattern: Pattern
{
    override func start()
    {
        start(every: 0.1, with: [RadicalRed, RadicalRed, Emerald, RadicalRed, RadicalRed])
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        if let colors = info as? [UIColor] {
            self.colors = colors
            currentCol = 0
            super.start(every: interval, with: nil)
        }
    }
    
    override func draw(timer: Timer)
    {
        for col in 0..<net.columns
        {
            let color = colors[((col + currentCol) % net.columns) % colors.count]
            for row in 0..<net.rows
            {
                net.setColor(color: color, row: row, column: col)
            }
        }
        currentCol = (currentCol + 1) % net.columns
    }
}

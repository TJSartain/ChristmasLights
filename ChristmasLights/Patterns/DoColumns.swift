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
    var currentCol = 0
    
    override func start()
    {
        start(every: 0.1, with: [RadicalRed, RadicalRed, Emerald, RadicalRed, RadicalRed])
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        currentCol = 0
        super.start(every: interval, with: info)
    }
    
    override func draw(timer: Timer)
    {
        let colors = timer.userInfo as! [UIColor]
        for col in 0..<lightsView.columns
        {
            let color = colors[((col + currentCol) % lightsView.columns) % colors.count]
            for row in 0..<lightsView.rows
            {
                lightsView.setColor(color: color, row: row, column: col)
            }
        }
        currentCol = (currentCol + 1) % lightsView.columns
    }
}

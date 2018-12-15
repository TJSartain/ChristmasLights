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
    var currentRow = 0

    override func start()
    {
        start(every: 0.06, with: [RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, Emerald, RadicalRed, RadicalRed])
    }

    override func start(every interval: TimeInterval, with info: Any?)
    {
        currentRow = 0
        super.start(every: interval, with: info)
    }

    override func draw(timer: Timer)
    {
        let colors = info as! [UIColor]
        for row in 0..<lightsView.rows
        {
            let color = colors[((row + currentRow) % lightsView.rows) % colors.count]
            for col in 0..<lightsView.columns
            {
                lightsView.setColor(color: color, row: row, column: col)
            }
        }
        currentRow = (currentRow + 1) % lightsView.rows
    }
}

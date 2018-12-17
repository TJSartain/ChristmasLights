//
//  DoSwirl.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/14/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class FatSwirlPattern: Pattern
{
    override func start()
    {
        start(every: 0.03, with: [RadicalRed, Emerald])
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
        for col in 0..<lightsNet.columns
        {
            for row in 0..<lightsNet.rows
            {
                let color = (row + currentRow + col) % lightsNet.columns < lightsNet.columns / 2 ? colors[0] : colors[1]
                lightsNet.setColor(color: color, row: row, column: col)
            }
        }
        currentRow = (currentRow + 1) % lightsNet.rows
    }
}

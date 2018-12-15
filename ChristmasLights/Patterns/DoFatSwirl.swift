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
    var currentRow = 0
    
    override func start()
    {
        start(every: 0.03, with: [RadicalRed, Emerald])
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        currentRow = 0
        super.start(every: interval, with: info)
    }
    
    override func draw(timer: Timer)
    {
        let colors = timer.userInfo as! [UIColor]
        for col in 0..<lightsView.columns
        {
            for row in 0..<lightsView.rows
            {
                let color = (row + currentRow + col) % lightsView.columns < lightsView.columns / 2 ? colors[0] : colors[1]
                lightsView.setColor(color: color, row: row, column: col)
            }
        }
        currentRow = (currentRow + 1) % lightsView.rows
    }
}

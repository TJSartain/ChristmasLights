//
//  DoRandom.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/14/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class RandomPattern: Pattern
{
    override func start()
    {
        start(every: 0.2, with: [Malibu, SuperNova, Pizazz, RadicalRed, AzureRadiance, Emerald, RedOrange])
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        if let colors = info as? [UIColor] {
            self.colors = colors
            super.start(every: interval, with: nil)
        }
    }
    
    override func draw(timer: Timer)
    {
        for row in 0..<net.rows
        {
            for col in 0..<net.columns
            {
                let index = Int.random(in: 0..<colors.count)
                let color = colors[index]
                net.setColor(color: color, row: row, column: col)
            }
        }
        super.draw(timer: timer)
    }
}

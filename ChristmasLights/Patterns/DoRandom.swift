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
    
    override func draw(timer: Timer)
    {
        let colors = timer.userInfo as! [UIColor]
        for row in 0..<lightsView.rows
        {
            for col in 0..<lightsView.columns
            {
                let index = Int.random(in: 0..<colors.count)
                let color = colors[index]
                lightsView.setColor(color: color, row: row, column: col)
            }
        }
    }
}

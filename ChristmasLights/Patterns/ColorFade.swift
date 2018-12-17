//
//  ColorFade.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/15/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class ColorFade: Pattern
{
    var index = 0
    
    override func start()
    {
        start(every: 0.05, with: UIColor.colorCycle(n: 288))
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        if let colors = info as? [UIColor], colors.count > 0 {
            index = 0
            self.colors = colors
            super.start(every: interval, with: nil)
        }
    }
    
    override func draw(timer: Timer)
    {
        net.oneColor(colors[index])
        index = (index + 1) % colors.count
    }
}

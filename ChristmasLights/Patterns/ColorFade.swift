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
        index = 0
        start(every: 0.05, with: UIColor.colorCycle(n: 288))
    }
    
    override func draw(timer: Timer)
    {
        let colors = info as! [UIColor]
        lightsView.oneColor(colors[index])
        index = (index + 1) % colors.count
    }
}

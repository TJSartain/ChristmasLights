//
//  Pattern.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/14/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class Pattern: NSObject
{
    var lightsNet: LightsNet
    var timer = Timer()
    var colors = [UIColor]()
    var currentRow = 0
    var currentCol = 0

    init(using view: LightsNet)
    {
        lightsNet = view
    }

    func start()
    {
        start(every: 1, with: "")
    }

    func start(every interval: TimeInterval, with info: Any?)
    {
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(self.draw),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc func draw(timer: Timer)
    {
        // override for custom drawing
    }

    func stop()
    {
        timer.invalidate()
    }
}

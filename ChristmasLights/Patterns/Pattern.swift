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
    var lightsView: LightsView
    var timer = Timer()
    var info: Any?

    init(using view: LightsView)
    {
        lightsView = view
    }

    func start()
    {
        start(every: 1, with: "")
    }

    func start(every interval: TimeInterval, with info: Any?)
    {
        self.info = info
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

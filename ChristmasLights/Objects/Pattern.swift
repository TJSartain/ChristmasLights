//
//  Pattern.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/14/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

protocol PatternDelegate
{
    var net: Net! { get }
    func redraw()
}

class Pattern: NSObject
{
    let name: String
    var colors = [UIColor]()
    var currentRow = 0
    var currentCol = 0
    var delegate: PatternDelegate?
    var net: Net

    init(_ name: String, _ delegate: PatternDelegate)
    {
        self.name = name
        self.delegate = delegate
        self.net = delegate.net
    }

    func start()
    {
        start(every: 1, with: nil)
    }

    func start(every interval: TimeInterval, with info: Any?)
    {
        Global.timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(draw),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc func draw(timer: Timer)
    {
        // override for custom drawing
        delegate?.redraw()
    }

    func stop()
    {
        colors = [UIColor]()
        Global.timer.invalidate()
    }
}

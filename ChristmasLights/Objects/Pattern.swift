//
//  Pattern.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/14/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

protocol PatternDelegate {
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

    init(_ name: String, _ delegate: PatternDelegate, _ net: Net)
    {
        self.name = name
        self.delegate = delegate
        self.net = net
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

    static func allPatterns(_ delegate: PatternDelegate, _ net: Net) -> [Pattern] {
        return [
            RandomPattern("Random", delegate, net),
            ColorFade("Color Cycle", delegate, net),
            FatSwirlPattern("Fat Swirl", delegate, net),
            RowsPattern("Rows", delegate, net),
            ColumnsPattern("Columns", delegate, net),
            RazzleDazzle("Razzle Dazzle", delegate, net),
            StarryNight("Starry Night", delegate, net),
            SnowFall("Snow Fall", delegate, net),
            Spiral("Spiral", delegate, net),
            SnakePattern("Snake", delegate, net)
        ]
    }
}

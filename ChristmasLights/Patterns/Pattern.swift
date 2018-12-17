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
    let name: String
    var colors = [UIColor]()
    var currentRow = 0
    var currentCol = 0

    init(_ name: String)
    {
        self.name = name
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
    }

    func stop()
    {
        colors = [UIColor]()
        Global.timer.invalidate()
    }

    static func allPatterns() -> [Pattern] {
        return [
            RandomPattern("Random"),
            ColorFade("Color Cycle"),
            FatSwirlPattern("Fat Swirl"),
            RowsPattern("Rows"),
            ColumnsPattern("Columns"),
            RowColumnDazzle("Razzle Dazzle"),
            StarryNight("Starry Night"),
            Spiral("Spiral"),
            SnakePattern("Snake")
        ]
    }
}

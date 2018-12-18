//
//  RowColumnDazzle.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/16/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class RazzleDazzle: Pattern
{
    var rowColor = Emerald
    var columnColor = Malibu
    var dazzle = false
    var dazzle2 = false
    var dazzleCount = 0
    var dazzleLimit = 1

    override func start()
    {
        rowColor = Emerald
        columnColor = Malibu
        start(every: 0.03, with: nil)
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        colors = UIColor.colorCycle(n: 288)
        net.blackOut()
        currentRow = 0
        super.start(every: interval, with: nil)
    }
    
    override func draw(timer: Timer)
    {
        if dazzle {
            if dazzle2 {
                if currentCol == 0 {
                    dazzleCount += 1
                    dazzle = dazzleCount < dazzleLimit
                    dazzle2 = false
                    currentRow = 0
                    if dazzleCount >= dazzleLimit {
                        net.turnOffColumn(currentCol)
                        Global.timer.invalidate()
                        Global.timer = Timer.scheduledTimer(timeInterval: 0.06,
                                                           target: self,
                                                           selector: #selector(draw),
                                                           userInfo: nil,
                                                           repeats: true)
                    }
                } else {
                    net.turnOffColumn(currentCol)
                    currentCol = (currentCol - 1) % net.columns
                    net.setColumn(currentCol, to: columnColor)
                }
            } else {
                if currentCol == net.columns - 1 {
                    dazzle2 = true
                } else {
                    net.turnOffColumn(currentCol)
                    currentCol = (currentCol + 1) % net.columns
                    net.setColumn(currentCol, to: columnColor)
                }
            }
        } else {
            net.turnOffRow(currentRow)
            net.turnOffRow(net.rows - currentRow)
            if currentRow == net.rows - 1 {
                dazzle = true
                Global.timer.invalidate()
                Global.timer = Timer.scheduledTimer(timeInterval: 0.03,
                                             target: self,
                                             selector: #selector(draw),
                                             userInfo: nil,
                                             repeats: true)
                columnColor = colors[Int.random(in: 0..<288)]
                dazzleLimit = Int.random(in: 1...3)
                dazzleCount = 0
                currentCol = 0
            } else {
                currentRow = (currentRow + 1) % net.rows
                net.setRow(currentRow, to: rowColor)
                net.setRow(net.rows - currentRow, to: rowColor)
            }
        }
        super.draw(timer: timer)
    }
}

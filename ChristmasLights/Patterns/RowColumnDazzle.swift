//
//  RowColumnDazzle.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/16/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class RowColumnDazzle: Pattern
{
    var rowColor = Emerald
    var columnColor = Malibu
    var dazzle = false
    var dazzle2 = false

    override func start()
    {
        rowColor = Emerald
        columnColor = Malibu
        start(every: 0.05, with: nil)
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        lightsNet.blackOut()
        currentRow = 0
        super.start(every: interval, with: nil)
    }
    
    override func draw(timer: Timer)
    {
        if dazzle {
            if dazzle2 {
                lightsNet.turnOffColumn(currentCol)
                if currentCol == 0 {
                    dazzle = false
                    dazzle2 = false
                    currentRow = 0
                } else {
                    currentCol = (currentCol - 1) % lightsNet.columns
                    lightsNet.setColumn(currentCol, to: columnColor)
                }
            } else {
                if currentCol == lightsNet.columns - 1 {
                    dazzle2 = true
                } else {
                    lightsNet.turnOffColumn(currentCol)
                    currentCol = (currentCol + 1) % lightsNet.columns
                    lightsNet.setColumn(currentCol, to: columnColor)
                }
            }
        } else {
            lightsNet.turnOffRow(currentRow)
            lightsNet.turnOffRow(lightsNet.rows - currentRow)
            if currentRow == lightsNet.rows - 1 {
                dazzle = true
                currentCol = 0
            } else {
                currentRow = (currentRow + 1) % lightsNet.rows
                lightsNet.setRow(currentRow, to: rowColor)
                lightsNet.setRow(lightsNet.rows - currentRow, to: rowColor)
            }
        }
    }
}

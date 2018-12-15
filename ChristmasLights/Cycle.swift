//
//  Cycle.swift
//  ColorCycleTest
//
//  Created by TJ Sartain on 12/12/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

enum CycleStyles: Int
{
    case SINE
    case RAMP
    case RAMP2
    case SAW
    case SAW2

    var string: String { return "\(self)" }
}

class Cycle: NSObject
{
    let styles = [sine, ramp, ramp2, saw, saw2]
    var style = CycleStyles.SINE

    var speed: CGFloat = 1
    var cycle: CGFloat = 0
    var start: CGFloat = 0   { didSet { cycle = start } }
    var range: CGFloat = 0
    var min:   CGFloat = 0   { didSet { range = max - min } }
    var max:   CGFloat = 100 { didSet { range = max - min } }

    override init()
    {
        cycle = start
        range = max - min
    }

    init(spd: CGFloat, strt: CGFloat, lo: CGFloat, hi: CGFloat, stl: CycleStyles)
    {
        speed = spd
        start = strt
        cycle = start
        min = lo
        max = hi
        range = max - min
        style = stl
    }

    override var description: String
    {
        return "Min \(min)"
            + ", Max \(max)"
            + ", Start \(String(format: "%.2f", start))%"
            + ", Speed \(String(format: "%.1f", speed))%"
            + ", Style \(style.string)"
//            + ", Cycle \(String(format: "%.1f", cycle))%"
//            + ", Value \(String(format: "%.2f", current()))%"
    }
    
    func incSpeed() { speed *= 110.0 / 100.0 }
    func decSpeed() { speed *= 100.0 / 110.0 }
    
    func current() -> CGFloat { return styles[style.rawValue](self)() }
    
    func doCycle()
    {
        cycle += speed
        if cycle >= 100 {
            cycle = cycle - 100
        }
    }
    
    func next() -> CGFloat
    {
        let c = current()
        doCycle()
        return c
    }
    
    func reset() { cycle = start }
    
    func sine() -> CGFloat
    {
        return (sin(cycle / 50 * CGFloat.pi) + 1) / 2 * range + min
    }
    
    func ramp() -> CGFloat
    {
        switch Int(3 * cycle / 50)
        {
        case 0:
            return min + 3 * cycle / 50 * range
        case 1, 2:
            return max
        case 3:
            return max - 3 * (cycle - 50) / 50 * range
        case 4, 5:
            return min
        default:
            return min
        }
    }

    func ramp2() -> CGFloat
    {
        switch Int(cycle / 25)
        {
        case 0:
            return min + cycle / 25 * range
        case 1, 2:
            return max
        case 3:
            return max - (cycle - 50) / 25 * range
        case 4, 5:
            return min
        default:
            return min
        }
    }

    func saw() -> CGFloat
    {
        return cycle / 100 * range + min
    }

    func saw2() -> CGFloat
    {
        let c = cycle > 50 ? 100 - cycle : cycle
        return c / 50 * range + min
    }
}

//
//  LightView.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/2/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class Net: NSObject
{
    var size = CGSize(width: 0, height: 0)
    var rows = 1
    var columns = 1
//    let og = OrthoGraphics()
    var wrapAround = false
    var lights = [[Bulb]]()
    
    /// All the little light views are (re)created and positioned
    /// every time the view is laid out (including a rotation)
    /// No math has to be done when drawing the light

    func draw()
    {
        for row in 0..<lights.count
        {
            let dimBulbs = lights[row].filter( { $0.isOn && $0.color == placeholderColor } )
            let coloredBulbs = lights[row].filter( { $0.isOn && $0.color != placeholderColor } )
            for bulb in dimBulbs
            {
                bulb.draw()
            }
            for bulb in coloredBulbs
            {
                bulb.draw()
            }
        }
    }
    
    func radialLayout()
    {
        let h = self.size.width / CGFloat(columns)
        let v = self.size.height / CGFloat(rows)
        let size: CGFloat = sqrt(h*h + v*v) / 5 // "average" 
        let sweep = 2 * asin((self.size.width - h) / ((v - 1) * CGFloat(rows)) / 2)
        lights = [[Bulb]]()
        for row in 0..<rows
        {
            var lightRow = [Bulb]()
            let radius = v * (CGFloat(row) + 0.5)
            for col in 0..<columns
            {
                let angle = CGFloat.pi/2 - CGFloat(col) * sweep / CGFloat(columns - 1) + sweep / 2
                let x = self.size.width / 2 + cos(angle) * radius
                let y = sin(angle) * radius

                let bulb = Bulb(size: size, center: CGPoint(x: x, y: y))
                lightRow.append(bulb)
            }
            lights.append(lightRow)
        }
    }
    
//    func orthoLayout()
//    {
//        for subView in subviews {
//            subView.removeFromSuperview()
//        }
//        og.center = CGPoint(x: frame.width / 2, y: 0)
//
//        let h = frame.width / CGFloat(columns)
//        let v = frame.height / CGFloat(rows)
//        let size: CGFloat = 2 * sqrt(h*h + v*v) / 5 // "average" divided by 5
//        og.scale = min(h, v)
//
//        for row in 0..<rows
//        {
//            let radius = CGFloat(row) / 5 /////// CGFloat(row) / 2
//            for col in 0..<columns {
//                let angle = 2 * CGFloat.pi * CGFloat(col) / CGFloat(columns)
//                let x = cos(angle) * radius
//                let z = sin(angle) * radius
//                let projection = og.orthoProjection(x, CGFloat(row) * 0.75, z) /////////// CGFloat(row) * 1.5
//                let pt = projection.0
//
////                let bulb = Bulb(frame: CGRect(x: pt.x,
////                                                        y: pt.y,
////                                                        width: h, height: v))
////                bulb.isInBack = (projection.1 > 0)
////                bulb.size = size
////                bulb.tag = row * 1000 + col + 1
////                addSubview(bulb)
//            }
//        }
//    }

//     func originalLayout()
//    {
//        for subView in subviews {
//            subView.removeFromSuperview()
//        }
//        var h = frame.width / CGFloat(columns)
//        let v = frame.height / CGFloat(rows)
//        let size: CGFloat = (h + v) / 10 // average divided by 5
//        let delta = (h - size * 0.5) / (CGFloat(rows) - 1)
//        h = size * 0.5
//        for row in 0..<rows {
//            let offset = (frame.width - h * CGFloat(columns)) / 2
//            for col in 0..<columns {
////                let bulb = Bulb(frame: CGRect(x: CGFloat(col) * h + offset,
////                                                        y: CGFloat(row) * v,
////                                                        width: h, height: v))
////                bulb.size = size
////                bulb.tag = row * 1000 + col + 1
////                addSubview(bulb)
//            }
//            h += delta
//        }
//    }

    func onFrame(_ loc: Location) -> Bool
    {
        return loc.row == 0 || loc.column == 0 ||
            loc.row == rows-1 || loc.column == (wrapAround ? columns/2 : columns-1)
    }
    
    /// Turns all the lights on the perimeter
    /// to the specified color
    
    func frameIn(_ color: UIColor)
    {
        for col in 0..<columns {
            setColor(color: color, row: 0, column: col)
            setColor(color: color, row: rows-1, column: col)
        }
        for row in 1..<rows-1 {
            setColor(color: color, row: row, column: 0)
            setColor(color: color, row: row, column: (wrapAround ? columns/2 : columns-1))
        }
    }
    
    /// Turns all the lights off
    
    func blackOut()
    {
        oneColor(.black)
    }
    
    /// Turns all the lights to one color
    
    func oneColor(_ color: UIColor)
    {
        for col in 0..<columns {
            setColumn(col, to: color)
        }
    }
    
    func turnOffRow(_ row: Int)
    {
        for col in 0..<columns {
            setColor(color: .black, row: row, column: col)
        }
    }

    func turnOffColumn(_ col: Int)
    {
        for row in 0..<rows {
            setColor(color: .black, row: row, column: col)
        }
    }

    func turnOffBulb(_ loc: Location)
    {
        setColor(color: .black, row: loc.row, column: loc.column)
    }
    
    func setRow(_ row: Int, to color: UIColor)
    {
        for col in 0..<columns {
            setColor(color: color, row: row, column: col)
        }
    }
    
    func setColumn(_ col: Int, to color: UIColor)
    {
        for row in 0..<rows {
            setColor(color: color, row: row, column: col)
        }
    }
    
    /// Sets a light at the given coords to the specified color

    func setColor(color: UIColor, row: Int, column: Int)
    {
        if lights.count > row, lights[row].count > column
        {
            lights[row][column].color = color
        }
    }

    func setColor(color: UIColor, loc: Location)
    {
        setColor(color: color, row: loc.row, column: loc.column)
    }
}

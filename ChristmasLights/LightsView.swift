//
//  LightView.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/2/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class LightsView: UIView
{
    var rows = 1
    var columns = 1
    
    /// All the little light views are (re)created and positioned
    /// every time the view is laid out (including a rotation)
    /// No math has to be done when drawing the light
    
    override func layoutSubviews()
    {
        for subView in subviews {
            subView.removeFromSuperview()
        }
        var h = frame.width / CGFloat(columns)
        let v = frame.height / CGFloat(rows)
        let size: CGFloat = (h + v) / 10 // average divided by 5
        let delta = (h - size * 1.5) / (CGFloat(rows) - 1)
        h = size * 1.5
        for row in 0..<rows {
            let offset = (frame.width - h * CGFloat(columns)) / 2
            for col in 0..<columns {
                let lightView = LightView(frame: CGRect(x: CGFloat(col) * h + offset,
                                                        y: CGFloat(row) * v,
                                                        width: h, height: v))
                lightView.size = size
                lightView.tag = row * 1000 + col + 1
                addSubview(lightView)
            }
            h += delta
        }
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
            setColor(color: color, row: row, column: columns-1)
        }
    }
    
    /// Turns all the lights off
    
    func blackOut()
    {
        for col in 0..<columns {
            for row in 0..<rows {
                setColor(color: .black, row: row, column: col)
            }
        }
    }
    
    /// Sets a light at the given coords to the specified color
    
    func setColor(color: UIColor, row: Int, column: Int)
    {
        if let lightView = viewWithTag(row * 1000 + column + 1) as? LightView {
            lightView.color = color
        }
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
}

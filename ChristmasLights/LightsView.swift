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
    let og = OrthoGraphics()
    
    /// All the little light views are (re)created and positioned
    /// every time the view is laid out (including a rotation)
    /// No math has to be done when drawing the light
    
    @IBAction func changeToEye(_ sender: UISlider) {
        print("Plane To Eye: \(sender.value)")
        og.planeToEye = CGFloat(sender.value)
        setNeedsLayout()
    }
    @IBAction func changeToObj(_ sender: UISlider) {
        print("Plane To Obj: \(sender.value)")
        og.planeToObj = CGFloat(sender.value)
        setNeedsLayout()
    }
    @IBAction func changeAzimuth(_ sender: UISlider) {
        print("Azimuth: \(sender.value)")
        og.azimuth = CGFloat(sender.value)
        og.projCoefficients()
        setNeedsLayout()
    }
    @IBAction func changeElevation(_ sender: UISlider) {
        print("Elevation: \(sender.value)")
        og.elevation = CGFloat(sender.value)
        og.projCoefficients()
        setNeedsLayout()
    }
    
    override func layoutSubviews()
    {
        for subView in subviews {
            subView.removeFromSuperview()
        }
        og.center = CGPoint(x: frame.width / 2, y: 0)
        
        let h = frame.width / CGFloat(columns)
        let v = frame.height / CGFloat(rows)
        let size: CGFloat = 2 * sqrt(h*h + v*v) / 5 // "average" divided by 5
        og.scale = min(h, v)
        
        for row in 0..<rows
        {
            let radius = CGFloat(row) / 2
            for col in 0..<columns {
                let angle = 2 * CGFloat.pi * CGFloat(col) / CGFloat(columns)
                let x = cos(angle) * radius
                let z = sin(angle) * radius
                let projection = og.orthoProjection(x, CGFloat(row) * 1.5, z)
                let pt = projection.0
                
                let lightView = LightView(frame: CGRect(x: pt.x,
                                                        y: pt.y,
                                                        width: h, height: v))
                lightView.isInBack = (projection.1 > 0)
                lightView.size = size
                lightView.tag = row * 1000 + col + 1
                addSubview(lightView)
            }
        }
    }
    
     func layoutSubviews2()
    {
        for subView in subviews {
            subView.removeFromSuperview()
        }
        var h = frame.width / CGFloat(columns)
        let v = frame.height / CGFloat(rows)
        let size: CGFloat = (h + v) / 10 // average divided by 5
        let delta = (h - size * 0.5) / (CGFloat(rows) - 1)
        h = size * 0.5
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
            setColor(color: color, row: row, column: columns/2)
        }
    }
    
    /// Turns all the lights to one color
    
    func oneColor(_ color: UIColor)
    {
        for col in 0..<columns {
            for row in 0..<rows {
                setColor(color: color, row: row, column: col)
            }
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

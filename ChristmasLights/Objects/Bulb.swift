//
//  LightView.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/6/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class Bulb: NSObject
{
    var isOn = false // don't draw if the light is off

    var isInBack = false // if in 3D, lower opacity when in the back

    var color = UIColor.white {
        didSet {
            isOn = (color != .black) // turn off when color is black
        }
    }
    
    /// The shape is calculated upon creation at unit size,
    /// ready for sizing and translation when the size is set.
    /// No calculations are needed (except transforms) when drawing
    
//    var shape = starPath()
    var shape = UIBezierPath(ovalIn: CGRect(x: -0.5, y: -0.5, width: 1, height: 1))

    init(size: CGFloat, center: CGPoint)
    {
        shape = UIBezierPath(ovalIn: CGRect(x: center.x - size/2,
                                            y: center.y - size/2,
                                            width: size,
                                            height: size))
    }

    func sizeAndPlace(at pt: CGPoint, size: CGFloat)
    {
        shape = UIBezierPath(ovalIn: CGRect(x: -0.5, y: -0.5, width: 1, height: 1))
        shape.apply(CGAffineTransform(scaleX: size, y: size))
        shape.apply(CGAffineTransform(translationX: pt.x, y: pt.y))
    }
    
    /// Only draws anything if the light is turned on
    /// the shape (star) is translated back to 0, 0, rotated
    /// and then translated back before setting the color
    /// and doing a fill
    ///
    /// - Parameter rect: light to be centered within
    
    func draw()
    {
        if isOn
        {
            var alpha: CGFloat = 1
            color.getWhite(nil, alpha: &alpha)
            color.withAlphaComponent(isInBack ? 0.25 * alpha : alpha).setFill()
            shape.fill()
        }
    }
}

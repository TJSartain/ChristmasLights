//
//  LightView.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/6/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class LightView: UIView
{
    /// No drawing is done if the light is off
    
    var isOn = false
    
    /// When the color is changed, a redraw is initiated
    /// If the color is black, the light is turned off
    
    var color = UIColor.white {
        didSet {
            isOn = (color != .black)
            setNeedsDisplay()
        }
    }
    
    /// The shape is calculated upon creation at unit size,
    /// ready for sizing and translation when the size is set.
    /// No calculations are needed (except transforms) when drawing
    
    var star = starPath()
    
    /// When the size is set, the shape is also translated to the center
    /// before being sized. If the size wasn't 1 beforehand, the shape is
    /// first translated back to 0, 0 and resized back to 1
    /// This will probably only happen one time upon creation
    
    var size: CGFloat = 1 {
        willSet {
            if size != 1 {
                star.apply(CGAffineTransform(translationX: -frame.width/2, y: -frame.height/2))
                star.apply(CGAffineTransform(scaleX: 1/size, y: 1/size))
            }
        }
        didSet {
            star.apply(CGAffineTransform(scaleX: size, y: size))
            star.apply(CGAffineTransform(translationX: frame.width/2, y: frame.height/2))
        }
    }
    
    /// Only draws anything if the light is turned on
    /// the shape (star) is translated back to 0, 0, rotated
    /// and then translated back before setting the color
    /// and doing a fill
    ///
    /// - Parameter rect: light to be centered within
    
    override func draw(_ rect: CGRect)
    {
        if isOn
        {
            let angle = CGFloat.random(in: 0..<2*CGFloat.pi)
            star.apply(CGAffineTransform(translationX: -frame.width/2, y: -frame.height/2))
            star.apply(CGAffineTransform(rotationAngle: angle))
            star.apply(CGAffineTransform(translationX: frame.width/2, y: frame.height/2))
            color.setFill()
            star.fill()
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

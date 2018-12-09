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
    var isOn = false
    var color = UIColor.white {
        didSet {
            isOn = (color != .black)
            setNeedsDisplay()
        }
    }
    var star = starPath()
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

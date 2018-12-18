//
//  NetView.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/18/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class NetView: UIView, PatternDelegate
{
    var net: Net!

    override func layoutSubviews()
    {
        net.size = bounds.size
        net.radialLayout()
    }

    override func draw(_ rect: CGRect)
    {
        net.draw()
    }

    func redraw()
    {
        setNeedsDisplay()
    }
}

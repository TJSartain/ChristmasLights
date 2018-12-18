//
//  NetView.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/18/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class NetView: UIView
{
    var net: Net?

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        net = Net()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        net = Net()
    }

    override func layoutSubviews()
    {
        net?.size = bounds.size
        net?.radialLayout()
    }

    override func draw(_ rect: CGRect)
    {
        net?.draw()
    }
}

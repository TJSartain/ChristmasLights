//
//  Drawing.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/2/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

func starPath() -> UIBezierPath
{
    let pts = regularPolygon(sides: 5,
                             center: CGPoint(x: 0, y: 0),
                             radius: 0.5,
                             angle: 0)
    let path = UIBezierPath()
    path.move(to: pts[0])
    for i in 1..<pts.count {
        path.addLine(to: pts[i])
    }
    path.close()
    return path
}

func regularPolygon(sides: Int,
                    center: CGPoint,
                    radius: CGFloat,
                    angle: CGFloat) -> [CGPoint]
{
    let angleDiff = 2 * CGFloat.pi / CGFloat(sides)
    var pts = [CGPoint]()
    for i in 0..<sides { // "2 *" for every other tip
        let theta = angle + 2 * CGFloat(i) * angleDiff
        pts.append(CGPoint(x: center.x + cos(theta) * radius,
                           y: center.y + sin(theta) * radius))
    }
    return pts
}

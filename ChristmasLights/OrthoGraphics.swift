//
//  OrthoGraphics.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/10/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class OrthoGraphics
{
    public var planeToEye, planeToObj, azimuth, elevation, scale: CGFloat
    public var center: CGPoint

    private var cosT, sinT, cosP, sinP: CGFloat
    private var cosTcosP, cosTsinP, sinTcosP, sinTsinP: CGFloat

    init()
    {
        cosT = 0
        sinT = 0
        cosP = 0
        sinP = 0
        cosTcosP = 0
        cosTsinP = 0
        sinTcosP = 0
        sinTsinP = 0
        planeToEye = 120
        planeToObj = 0
        azimuth = 180 // in degrees
        elevation = 0 // in degrees
        scale = 1 // og pixel is worth this many screen pixels
        center = CGPoint(x: 0, y: 0) // screen pixel for origin
        projCoefficients()
    }
    
    func set(azimuth: CGFloat, elevation: CGFloat)
    {
        self.azimuth = azimuth
        self.elevation = elevation
        projCoefficients()
    }
    
    // MARK: - Orthographic Projection -
    
    func projCoefficients()
    {
        let theta = CGFloat.pi / 180.0 * azimuth  // convert to radians
        let phi = CGFloat.pi / 180.0 * elevation
        cosT = cos(theta)  // do these calculations only when angles have
        sinT = sin(theta)
        cosP = cos(phi)
        sinP = sin(phi)
        cosTcosP = cosT * cosP
        cosTsinP = cosT * sinP
        sinTcosP = sinT * cosP
        sinTsinP = sinT * sinP
    }
    
    func orthoProjection(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> (CGPoint, CGFloat)
    {
        var x1 = cosT * x + sinT * z
        var y1 = -sinTsinP * x + cosP * y + cosTsinP * z
        // now adjust things to get a perspective projection
        let z1 = cosTcosP * z - sinTcosP * x - sinP * y
        x1 = x1 * planeToEye / (z1 + planeToEye + planeToObj)
        y1 = y1 * planeToEye / (z1 + planeToEye + planeToObj)
        // return new 2D point (ignore Z of new point)
        return (CGPoint(x: center.x + x1 * scale,
                       y: center.y + y1 * scale),
        z1)
    }
}

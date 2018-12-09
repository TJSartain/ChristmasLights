//
//  Snake.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/7/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

typealias Heading = (v: Int, h: Int)
typealias Location = (row: Int, column: Int)
typealias Bounds = (rows: Int, columns: Int)

struct SnakeLight
{
    var color: UIColor
    var location: Location
}

class Snake: NSObject
{
    var segments = [SnakeLight]()
    var heading: Heading = (0, 0)

    // move func

    func move(bounds: Bounds) -> Bool
    {
        if canMove(bounds: bounds) {
            var next = nextLocation(bounds: bounds)
            for i in 0..<segments.count {
                let save = segments[i].location
                segments[i].location = next
                next = save
            }
            return true
        } else {
            return false
        }
    }

    // randomize next location

    func nextLocation(bounds: Bounds) -> Location
    {
        if Int.random(in: 0 ..< 5) < 1 { // turn 20% of the time
            heading = randomDirection()
        }
        var nextHead = getNextHead(heading, bounds: bounds)
        while !inBounds(loc: nextHead, bounds: bounds) || onSelf(loc: nextHead)
        {
            heading = randomDirection()
            nextHead = getNextHead(heading, bounds: bounds)
        }
        return nextHead
    }

    func getNextHead(_ newHeading: Heading, bounds: Bounds) -> Location
    {
        let newHead = (segments[0].location.row + newHeading.v,
                       (segments[0].location.column + newHeading.h + bounds.columns) % bounds.columns)
        return newHead
    }

    func randomDirection() -> Heading
    {
        var h = 0
        var v = 0
        repeat {
            h = Int.random(in: -1 ... 1)
            v = Int.random(in: -1 ... 1)
        } while h == 0 && v == 0
        return (v, h)
    }
    
    // can actually move test
    
    func canMove(bounds: Bounds) -> Bool
    {
        for v in -1...1 {
            for h in -1...1 {
                if h == 0 && v == 0 { continue }
                let nextHead = getNextHead((v, h), bounds: bounds)
                if inBounds(loc: nextHead, bounds: bounds) && !onSelf(loc: nextHead) {
                    return true
                }
            }
        }
        return false
    }
    
    // inbounds test
    
    func inBounds(loc: Location, bounds: Bounds) -> Bool
    {
        return
            loc.row >= 0 && loc.row < bounds.rows
//            && loc.column >= 0 && loc.column < bounds.columns
    }

    // on self test

    func onSelf(loc: Location) -> Bool
    {
        for segment in segments {
            if segment.location.row == loc.row && segment.location.column == loc.column {
                return true
            }
        }
        return false
    }

}

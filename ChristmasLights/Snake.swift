//
//  Snake.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/7/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

typealias Heading = (v: Int, h: Int)

struct SnakeLight
{
    var color: UIColor
    var location: Location
}

class Snake: NSObject
{
    var segments = [SnakeLight]()
    var heading: Heading = (0, 0)

    /// Determines if there are any viable spots to move to
    /// If so, the head is moved followed by the rest
    /// If not, nothing is changed and the caller is notified
    ///
    /// - Parameter bounds: coords the snake can move within
    /// - Returns: whether or not the snake was moved
    
    func move() -> Bool
    {
        if canMove() {
            var next = nextLocation()
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

    /// Determines the next snake head position. 20% of the time
    /// it will possibly be in a new direction
    ///
    /// - Parameter bounds: coords the snake can move within
    /// - Returns: tuple for vertical and horizontal coordinates
    
    func nextLocation() -> Location
    {
        if Int.random(in: 0 ..< 5) < 1 { // turn 20% of the time
            heading = randomDirection()
        }
        var nextHead = getNextHead(heading)
        while !inBounds(loc: nextHead) || onSelf(loc: nextHead)
        {
            heading = randomDirection()
            nextHead = getNextHead(heading)
        }
        return nextHead
    }

    /// Given a heading, determine the next snake head position
    ///
    /// - Parameters:
    ///   - newHeading: tuple for vertical and horizontal movement
    ///   - bounds: coords the snake can move within
    /// - Returns: tuple for vertical and horizontal coordinates
    
    func getNextHead(_ newHeading: Heading) -> Location
    {
        let newHead = (segments[0].location.row + newHeading.v,
                       (segments[0].location.column + newHeading.h + net.columns) % net.columns)
        return newHead
    }

    /// Randomly chooses a new heading in one of 8 directions
    ///
    /// - Returns: tuple for vertical and horizontal movement
    
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
    
    /// Is there a valid place for the snake to move
    ///
    /// - Parameter bounds: coords the snake can move within
    /// - Returns: yes or no

    func canMove() -> Bool
    {
        for v in -1...1 {
            for h in -1...1 {
                if h == 0 && v == 0 { continue }
                let nextHead = getNextHead((v, h))
                if inBounds(loc: nextHead) && !onSelf(loc: nextHead) {
                    return true
                }
            }
        }
        return false
    }
    
    /// Determines if the given location is in bounds
    /// The snaks is allowed to wrap around horizontally
    ///
    /// - Parameters:
    ///   - loc: some location
    ///   - bounds: coords the snake can move within
    /// - Returns: yes or no

    func inBounds(loc: Location) -> Bool
    {
        return loc.row >= 3 && loc.row < net.rows
    }

    /// Determines if the given location is anywhre on the snake
    ///
    /// - Parameter loc: some location
    /// - Returns: yes or no
    
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

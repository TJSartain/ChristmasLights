//
//  DoSnake.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/14/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class SnakePattern: Pattern
{
    var snake: Snake!
    
    override func start()
    {
        snake = Snake(net)
        snake.segments = [SnakeLight(color: RadicalRed, location: (14, 9)),
                          SnakeLight(color: Emerald,    location: (14, 8)),
                          SnakeLight(color: Emerald,    location: (14, 7)),
                          SnakeLight(color: Emerald,    location: (14, 6)),
                          SnakeLight(color: Emerald,    location: (14, 5)),
                          SnakeLight(color: Emerald,    location: (14, 4)),
                          SnakeLight(color: Emerald,    location: (14, 3)),
                          SnakeLight(color: Emerald,    location: (14, 2)),
                          SnakeLight(color: Emerald,    location: (14, 1)),
                          SnakeLight(color: Emerald,    location: (14, 0)),
                          SnakeLight(color: Emerald,    location: (15, 0)),
                          SnakeLight(color: Emerald,    location: (16, 0)),
                          SnakeLight(color: Emerald,    location: (17, 0)),
                          SnakeLight(color: Emerald,    location: (18, 0)),
                          SnakeLight(color: Emerald,    location: (19, 0))]
        snake.heading = (1, 1)
        start(every: 0.1, with: snake)
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        if let snake = info as? Snake, snake.segments.count > 0 {
            self.snake = snake
            for i in 0..<snake.segments.count {
                let pct = CGFloat(snake.segments.count - i) / CGFloat(snake.segments.count) * 0.75 + 0.25
                snake.segments[i].color = snake.segments[i].color.withAlphaComponent(pct)
            }
            net.oneColor(placeholderColor)
            net.frameIn(.darkGray)
            super.start(every: interval, with: snake)
        }
    }
    
    override func draw(timer: Timer)
    {
        let lastRow = snake.segments.last!.location.row
        let lastColumn = snake.segments.last!.location.column
        if snake.move()
        {
            for segment in snake.segments
            {
                net.setColor(color: segment.color,
                                    row: segment.location.row,
                                    column: segment.location.column)
            }
            net.setColor(color: net.onFrame((lastRow, lastColumn)) ? .darkGray : placeholderColor,
                                row: lastRow,
                                column: lastColumn)
            super.draw(timer: timer)
        } else {
            stop()
            start() // start over
        }
    }
}

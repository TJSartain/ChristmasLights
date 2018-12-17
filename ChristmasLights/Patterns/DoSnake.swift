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
    var snake = Snake()
    
    override func start()
    {
        snake = Snake()
        snake.segments = [SnakeLight(color: RadicalRed, location: (4, 9)),
                          SnakeLight(color: Emerald,    location: (4, 8)),
                          SnakeLight(color: Emerald,    location: (4, 7)),
                          SnakeLight(color: Emerald,    location: (4, 6)),
                          SnakeLight(color: Emerald,    location: (4, 5)),
                          SnakeLight(color: Emerald,    location: (4, 4)),
                          SnakeLight(color: Emerald,    location: (4, 3)),
                          SnakeLight(color: Emerald,    location: (4, 2)),
                          SnakeLight(color: Emerald,    location: (4, 1)),
                          SnakeLight(color: Emerald,    location: (4, 0)),
                          SnakeLight(color: Emerald,    location: (5, 0)),
                          SnakeLight(color: Emerald,    location: (6, 0)),
                          SnakeLight(color: Emerald,    location: (7, 0)),
                          SnakeLight(color: Emerald,    location: (8, 0)),
                          SnakeLight(color: Emerald,    location: (9, 0))]
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
        } else {
            stop()
            start() // start over
        }
    }
}

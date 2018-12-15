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
    override func start()
    {
        let snake = Snake()
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
        start(every: 0.2, with: snake)
    }
    
    override func start(every interval: TimeInterval, with info: Any?)
    {
        let snake = info as! Snake
        for i in 0..<snake.segments.count {
            let pct = CGFloat(snake.segments.count - i) / CGFloat(snake.segments.count) * 0.75 + 0.25
            snake.segments[i].color = snake.segments[i].color.withAlphaComponent(pct)
        }
        lightsView.oneColor(placeholderColor)
        lightsView.frameIn(.white)
        super.start(every: interval, with: snake)
    }
    
    override func draw(timer: Timer)
    {
        let snake = timer.userInfo as! Snake
        let lastRow = snake.segments.last!.location.row
        let lastColumn = snake.segments.last!.location.column
        if snake.move(bounds: (rows, columns))
        {
            for segment in snake.segments
            {
                lightsView.setColor(color: segment.color,
                                    row: segment.location.row,
                                    column: segment.location.column)
            }
            lightsView.setColor(color: onFrame((lastRow, lastColumn)) ? .white : placeholderColor,
                                row: lastRow,
                                column: lastColumn)
        } else {
            print("Starting over")
            stop()
            start() // start over
        }
    }
}

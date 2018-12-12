//
//  ViewController.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/2/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var lightsView: LightsView!
    
    let colors = [Malibu, SuperNova, Pizazz, RadicalRed, AzureRadiance, Emerald, RedOrange]
    let rows = 32
    let columns = 32

    var timer = Timer()
    var currentRow = 0
    var currentCol = 0
    var currentDir = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()

        lightsView.rows = rows
        lightsView.columns = columns
        lightsView.backgroundColor = .black

        doRandom()
    }

    @IBAction func patternChange(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0 {
            doRandom()
        } else if sender.selectedSegmentIndex == 1 {
            doRows()
        } else if sender.selectedSegmentIndex == 2 {
            doFatSwirl()
        } else { // sender.selectedSegmentIndex == 3
            doSnake()
        }
    }
    
    func onFrame(_ loc: Location) -> Bool
    {
        return loc.row == 0 || loc.column == 0 || loc.row == rows-1 || loc.column == columns/2
    }

    // MARK: - Random -
    
    func doRandom()
    {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.2,
                             target: self,
                             selector: #selector(self.drawRandom),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func drawRandom(timer: Timer)
    {
        for row in 0..<rows {
            for col in 0..<columns {
                let number = Int.random(in: 0..<colors.count)
                let color = colors[number]
                lightsView.setColor(color: color, row: row, column: col)
            }
        }
    }
    
    // MARK: - Rows -

    func doRows()
    {
        doRows([RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, RadicalRed, Emerald, RadicalRed, RadicalRed])
    }
    
    func doRows(_ colors: [UIColor])
    {
        currentRow = 0
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.06,
                             target: self,
                             selector: #selector(self.drawRows),
                             userInfo: colors,
                             repeats: true)
    }
    
    @objc func drawRows(timer: Timer)
    {
        let c = timer.userInfo as! [UIColor]
        for row in 0..<rows {
            let color = c[((row + currentRow) % rows) % c.count]
            for col in 0..<columns {
                lightsView.setColor(color: color, row: row, column: col)
            }
        }
        currentRow = (currentRow + 1) % rows
    }
    
    // MARK: - Stripes -
    
    func doStripes()
    {
        doStripes([RadicalRed, RadicalRed, Emerald, RadicalRed, RadicalRed])
    }
    
    func doStripes(_ colors: [UIColor])
    {
        currentCol = 0
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(self.drawStripes),
                                     userInfo: colors,
                                     repeats: true)
    }
    
    @objc func drawStripes(timer: Timer)
    {
        let c = timer.userInfo as! [UIColor]
        for col in 0..<columns {
            let color = c[((col + currentCol) % columns) % c.count]
            for row in 0..<rows {
                lightsView.setColor(color: color, row: row, column: col)
            }
        }
        currentCol = (currentCol + 1) % columns
    }
    
    // MARK: - Fat Swirl -
    
    func doFatSwirl()
    {
        doFatSwirl([RadicalRed, .white])
    }
    
    func doFatSwirl(_ colors: [UIColor])
    {
        currentRow = 0
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.03,
                                     target: self,
                                     selector: #selector(self.drawFatSwirl),
                                     userInfo: colors,
                                     repeats: true)
    }
    
    @objc func drawFatSwirl(timer: Timer)
    {
        let c = timer.userInfo as! [UIColor]
        for col in 0..<columns {
            for row in 0..<rows {
                let color = (row + currentRow + col) % columns < columns / 2 ? c[0] : c[1]
                lightsView.setColor(color: color, row: row, column: col)
            }
        }
        currentRow = (currentRow + 1) % rows
    }

    // MARK: - Snake -
    
    let placeholderColor = UIColor.darkGray.withAlphaComponent(0.25)

    func doSnake()
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
        doSnake(snake)
    }

    func doSnake(_ snake: Snake)
    {
        for i in 0..<snake.segments.count {
            let pct = CGFloat(snake.segments.count - i) / CGFloat(snake.segments.count) * 0.75 + 0.25
            snake.segments[i].color = snake.segments[i].color.withAlphaComponent(pct)
        }
        lightsView.oneColor(placeholderColor)
        lightsView.frameIn(.white)
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.2,
                                     target: self,
                                     selector: #selector(self.drawSnake),
                                     userInfo: snake,
                                     repeats: true)
    }

    @objc func drawSnake(timer: Timer)
    {
        let snake = timer.userInfo as! Snake
        let lastRow = snake.segments.last!.location.row
        let lastColumn = snake.segments.last!.location.column
        if snake.move(bounds: (rows, columns)) {
            for segment in snake.segments {
                lightsView.setColor(color: segment.color,
                                    row: segment.location.row,
                                    column: segment.location.column)
            }
            lightsView.setColor(color: onFrame((lastRow, lastColumn)) ? .white : placeholderColor,
                                row: lastRow,
                                column: lastColumn)
        } else {
            print("Starting over")
            doSnake() // start over
        }
    }
}

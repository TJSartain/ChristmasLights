//
//  ViewController.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/2/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

let placeholderColor = UIColor.darkGray.withAlphaComponent(0.25)
var timer = Timer()
let rows = 20
let columns = 20

func onFrame(_ loc: Location) -> Bool
{
    return loc.row == 0 || loc.column == 0 || loc.row == rows-1 || loc.column == columns/2
}

class ViewController: UIViewController
{
    @IBOutlet weak var lightsView: LightsView!
    
    let colors = [Malibu, SuperNova, Pizazz, RadicalRed, AzureRadiance, Emerald, RedOrange]

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
            doStripes()
        } else if sender.selectedSegmentIndex == 3 {
            doSnake()
        } else { // sender.selectedSegmentIndex == 4
            doFatSwirl()
        }
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
        doFatSwirl([RadicalRed, Emerald])
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
}

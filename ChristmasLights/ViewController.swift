//
//  ViewController.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/2/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

let placeholderColor = UIColor.white.withAlphaComponent(0.15)

class ViewController: UIViewController
{
    @IBOutlet weak var lightsNet: LightsNet!
    var patterns = [Pattern]()
    var currentPattern = 0
    
    let colors = [Malibu, SuperNova, Pizazz, RadicalRed, AzureRadiance, Emerald, RedOrange]

    var currentRow = 0
    var currentCol = 0
    var currentDir = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()

        lightsNet.rows = 35
        lightsNet.columns = 11
        lightsNet.backgroundColor = .black
        
        patterns = [RowColumnDazzle(using: lightsNet),
                    RowsPattern(using: lightsNet),
                    ColumnsPattern(using: lightsNet),
                    SnakePattern(using: lightsNet),
                    FatSwirlPattern(using: lightsNet),
                    ColorFade(using: lightsNet)]

        patterns[currentPattern].start()
    }

    @IBAction func patternChange(_ sender: UISegmentedControl)
    {
        patterns[currentPattern].stop()
        currentPattern = sender.selectedSegmentIndex
        patterns[currentPattern].start()
    }
}

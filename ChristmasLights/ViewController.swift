//
//  ViewController.swift
//  ChristmasLights
//
//  Created by TJ Sartain on 12/2/18.
//  Copyright © 2018 iTrinity Inc. All rights reserved.
//

import UIKit

typealias Location = (row: Int, column: Int)

struct Global {
    static var timer: Timer! // why do I have to put this in a struct but not the 2 vars below ???
}

var placeholderColor = rgb(31, 31, 31)
var patterns = [Pattern]()

class ViewController: UIViewController
{
    @IBOutlet weak var netView: NetView!

    var currentPattern: Pattern!
    var delegate: CenterViewControllerDelegate?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        Global.timer = Timer()

        netView.net = Net(rows: 35, columns: 11)
        netView.backgroundColor = .black

        patterns = allPatterns()
        currentPattern = patterns[0]
        currentPattern.start()
    }

    @IBAction func patternsTapped(_ sender: Any)
    {
        delegate?.toggleLeftPanel?()
    }

    func allPatterns() -> [Pattern]
    {
        return [
            RandomPattern("Random",       netView),
            ColorFade("Color Cycle",      netView),
            FatSwirlPattern("Fat Swirl",  netView),
            RowsPattern("Rows",           netView),
            ColumnsPattern("Columns",     netView),
            RazzleDazzle("Razzle Dazzle", netView),
            StarryNight("Starry Night",   netView),
            SnowFall("Snow Fall",         netView),
            Spiral("Spiral",              netView),
            SnakePattern("Snake",         netView)
        ]
    }
}

extension ViewController: SidePanelViewControllerDelegate
{
    func didSelectPattern(_ pattern: Pattern)
    {
        currentPattern.stop()
        currentPattern = pattern
        currentPattern.start()
        delegate?.collapseSidePanels?()
    }
}

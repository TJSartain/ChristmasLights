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

class ViewController: UIViewController, PatternDelegate
{
    @IBOutlet weak var netView: NetView!
    var currentPattern: Pattern!

    var delegate: CenterViewControllerDelegate?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        Global.timer = Timer()

        netView.net?.rows = 35
        netView.net?.columns = 11
        netView.backgroundColor = .black

        patterns = allPatterns(netView.net!)
        currentPattern = patterns[0]
        currentPattern.start()
    }

    @IBAction func patternsTapped(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }

    func redraw() {
        netView.setNeedsDisplay()
    }

    func allPatterns(_ net: Net) -> [Pattern] {
        return [
            RandomPattern("Random",       self, net),
            ColorFade("Color Cycle",      self, net),
            FatSwirlPattern("Fat Swirl",  self, net),
            RowsPattern("Rows",           self, net),
            ColumnsPattern("Columns",     self, net),
            RazzleDazzle("Razzle Dazzle", self, net),
            StarryNight("Starry Night",   self, net),
            SnowFall("Snow Fall",         self, net),
            Spiral("Spiral",              self, net),
            SnakePattern("Snake",         self, net)
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

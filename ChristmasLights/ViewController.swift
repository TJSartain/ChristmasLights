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
//var net: Net!
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

        patterns = Pattern.allPatterns(self, netView.net!)
        currentPattern = patterns[0]
        currentPattern.start()
    }

    @IBAction func patternsTapped(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }

    func redraw() {
        netView.setNeedsDisplay()
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

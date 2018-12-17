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
var net: Net!

class ViewController: UIViewController
{
    @IBOutlet weak var lightsNet: Net!
    var patterns = [Pattern]()
    var currentPattern: Pattern!

    var delegate: CenterViewControllerDelegate?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        Global.timer = Timer()

        net = lightsNet
        net.rows = 35
        net.columns = 11
        net.backgroundColor = .black

        currentPattern = Pattern.allPatterns()[0]
        currentPattern.start()
    }

    @IBAction func patternsTapped(_ sender: Any) {
        delegate?.toggleLeftPanel?()
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

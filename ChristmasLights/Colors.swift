//
//  Colors.swift
//  ClearChain
//
//  Created by TJ Sartain on 12/2/18.
//  Copyright © 2018 Penske Logistics. All rights reserved.
//

import UIKit

// MARK: - Apple Color Palette since iOS 7 -

let Malibu          = UIColor.fromHex("#54C7FC")
let SuperNova       = UIColor.fromHex("#FFCD00")
let Pizazz          = UIColor.fromHex("#FF9600")
let RadicalRed      = UIColor.fromHex("#FF2851")
let AzureRadiance   = UIColor.fromHex("#0076FF")
let Emerald         = UIColor.fromHex("#44DB5E")
let RedOrange       = UIColor.fromHex("#FF3824")
let Manatee         = UIColor.fromHex("#8E8E93")

// MARK: - Color Extensions -

extension UIColor
{
    static func fromHex(_ h: String) -> UIColor
    {
        var hex = h.replace("#", with: "")
        if hex.count == 1 {
            hex = hex + hex + hex + hex + hex + hex
        } else if hex.count == 2 {
            hex = hex + hex + hex
        } else if hex.count == 3 {
            hex = "\(hex[0])\(hex[0])\(hex[1])\(hex[1])\(hex[2])\(hex[2])"
        }
        if hex.count != 6 {
            return .clear
        }
        let r = hexToCGFloat(hex: String(hex[0...1]))
        let g = hexToCGFloat(hex: String(hex[2...3]))
        let b = hexToCGFloat(hex: String(hex[4...5]))
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }

    static func hexToCGFloat(hex: String) -> CGFloat
    {
        var value: UInt32 = 0
        let hexValueScanner = Scanner(string: hex)
        hexValueScanner.scanHexInt32(&value)
        return CGFloat(value) / 255
    }
}

// MARK: - String Extensions -

extension String
{
    func replace(_ this: String, with that: String) -> String
    {
        return self.replacingOccurrences(of: this, with: that)
    }

    subscript (i: Int) -> Character
    {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript (bounds: CountableClosedRange<Int>) -> Substring
    {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
}

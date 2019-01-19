//
//  GlobalVariables.swift
//  Clock
//
//  Created by Joseph Yuen on 8/4/18.
//  Copyright © 2018 Joseph Yuen. All rights reserved.
//

import Foundation
import UIKit

// Global Variables
var dateGV = 1; // 0=off 1=on
var timeGV = 1; // 0=24HR 1=12HR
var themeGV = 1; // 0=white 1=black
var basicFont:UIFont = UIFont.systemFont(ofSize: 100, weight:UIFont.Weight.bold)

// Global Colors
var aluminum:UIColor = hexStringToUIColor(hex:"848789")
var steel:UIColor = hexStringToUIColor(hex:"7B9095")

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

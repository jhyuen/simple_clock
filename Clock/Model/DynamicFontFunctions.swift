//
//  DynamicFontFunctions.swift
//  Clock
//
//  Created by Joseph Yuen on 8/6/18.
//  Copyright © 2018 Joseph Yuen. All rights reserved.
//

import Foundation
import UIKit

// DON'T USE... Doesn't Work *** Keep for reference
extension UIFont {
    
    /**
     Will return the best font conforming to the descriptor which will fit in the provided bounds.
     */
    static func bestFittingFontSize(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {
        //23:59
        let constrainingDimension = min(bounds.width, bounds.height)
        print("\(bounds.width)");
        print("\(bounds.height)")
        let properBounds = CGRect(origin: .zero, size: bounds.size)
        var attributes = additionalAttributes ?? [:]
        
        let infiniteBounds = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
        var bestFontSize: CGFloat = constrainingDimension
        /*
        for fontSize in stride(from: bestFontSize, through: 0, by: -1) {
            
            let newFont = UIFont(descriptor: fontDescriptor, size: fontSize)
            attributes[.font] = newFont
            
            let currentFrame = text.boundingRect(with: infiniteBounds, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
            
            if properBounds.contains(currentFrame) {
                bestFontSize = fontSize
                break
            }
            
            print("\(fontSize)")
        }
         */
        
        if (bestFontSize >= 500) {
            bestFontSize = 500
        }
        print("\(bestFontSize)")
        return bestFontSize
    }
    
    static func bestFittingFont(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> UIFont {
        let bestSize = bestFittingFontSize(for: text, in: bounds, fontDescriptor: fontDescriptor, additionalAttributes: additionalAttributes)
        print("\(bestSize)")
        return UIFont(descriptor: fontDescriptor, size: bestSize)
    }
}

extension UILabel {
    
    /// Will auto resize the contained text to a font size which fits the frames bounds.
    /// Uses the pre-set font to dynamically determine the proper sizing
    func fitTextToBounds() {
        guard let text = text, let currentFont = font else { return }
        
        let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor, additionalAttributes: basicStringAttributes)
        
        print("\(bestFittingFont)")
        
        font = bestFittingFont
    }
    
    private var basicStringAttributes: [NSAttributedString.Key: Any] {
        var attribs = [NSAttributedString.Key: Any]()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = self.lineBreakMode
        attribs[.paragraphStyle] = paragraphStyle
        
        return attribs
    }
}

// Used to determine how long (pixels) a string is at a certain font and size
// Regardless of frame
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

func scaleTimeTextToFrame(label: UILabel, view:UIView) {
    
    // 8 is the fattest single digit number
    let basicString:String = "88:88"
    var correctFontSize:CGFloat = 100
    
    //print("Time Label Font:\(label.font)")
    print("BasicFont Font:\(basicFont)")
    print("Basic String Width:\(basicString.width(withConstrainedHeight: 3000, font: basicFont))")
    print("Basic String Height:\(basicString.height(withConstrainedWidth: 3000, font: basicFont))")
    
    /*
    print("TimeLbl Width:\(UIScreen.main.bounds.width-80)")
    print("TimeLbl Height:\(UIScreen.main.bounds.height-80)")
 */
 
    print("View Width:\(view.frame.width)")
    print("View Height:\(view.frame.height)")
    
    print("View Adjusted Width:\(view.frame.width-80)")
    print("View Adjusted Height:\(view.frame.height-95)")
    
    while ((basicString.width(withConstrainedHeight: 3000, font: basicFont) < (view.frame.width-80)) && (basicString.height(withConstrainedWidth: 3000, font: basicFont) < (view.frame.height-95))) {
        
        correctFontSize = correctFontSize + 1
        
        basicFont = UIFont.systemFont(ofSize: correctFontSize, weight:UIFont.Weight.bold)
        
        //print("\(correctFontSize)")
    }
    
    correctFontSize = correctFontSize - 1
    
    print("Correct Font Size:\(correctFontSize)")
    
    basicFont = UIFont.systemFont(ofSize: correctFontSize, weight:UIFont.Weight.bold)
    
    print("Basic String with Correct Font Size Width:\(basicString.width(withConstrainedHeight: 1000, font: basicFont))")
    print("Basic String Height with Correct Font Size Height:\(basicString.height(withConstrainedWidth: 1000, font: basicFont))")
    
    //  if statement needed for iPad Retina and iPad 2
    if (((UIScreen.main.bounds.width == 768) && (UIScreen.main.bounds.height == 1024)) || ((UIScreen.main.bounds.width == 1024) && (UIScreen.main.bounds.height == 768))) {
        
        print("fun device")
        
        if UIDevice.current.orientation.isLandscape {
            correctFontSize = 343
        } else if UIDevice.current.orientation.isPortrait {
            correctFontSize = 250
        }
    }
 
    basicFont = UIFont.systemFont(ofSize: 100, weight:UIFont.Weight.bold)
    label.font = UIFont.systemFont(ofSize: correctFontSize, weight:UIFont.Weight.bold)
}


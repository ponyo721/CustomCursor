//
//  Color.swift
//  CustomCursor
//
//  Created by 박병호 on 6/5/24.
//

import AppKit

struct Color : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
    
    var color : NSColor {
        return NSColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    init(color : NSColor) {
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

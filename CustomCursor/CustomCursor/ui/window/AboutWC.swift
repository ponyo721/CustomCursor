//
//  AboutWC.swift
//  CustomCursor
//
//  Created by 박병호 on 5/31/24.
//

import Cocoa

public class AboutWC : NSWindowController, NSWindowDelegate{
    
    public override var windowNibName: NSNib.Name? {    // load custom xib object
        return NSNib.Name("AboutWindow")
    }
    
}



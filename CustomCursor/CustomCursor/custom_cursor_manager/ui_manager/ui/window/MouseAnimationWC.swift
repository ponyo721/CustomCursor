//
//  MouseAnimationWC.swift
//  CustomCursor
//
//  Created by 박병호 on 5/23/24.
//

import Cocoa

public class MouseAnimationWC : NSWindowController, NSWindowDelegate{
    
    public override var windowNibName: NSNib.Name? {    // load custom xib object
        return NSNib.Name("MouseAnimationWindow")
    }
    
    public override func windowDidLoad() {
        print("[MouseAnimationWC] windowDidLoad")
    }
    
    public func windowShouldClose(_ sender: NSWindow) -> Bool {
        print("[MouseAnimationWC] windowShouldClose")
        
        return true
    }
    
}

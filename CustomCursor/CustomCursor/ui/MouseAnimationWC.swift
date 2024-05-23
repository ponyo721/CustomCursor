//
//  MouseAnimationWC.swift
//  CustomCursor
//
//  Created by 박병호 on 5/23/24.
//

import Cocoa

public class MouseAnimationWC : NSWindowController, NSWindowDelegate{
    
    public override var windowNibName: NSNib.Name? {
        return NSNib.Name("MouseAnimationWindow")
    }
    
    public override func windowDidLoad() {
        print("windowDidLoad \(String(describing: self.window?.title))")
    }
    
    public func windowShouldClose(_ sender: NSWindow) -> Bool {
        print("windowShouldClose")
        
        return true
    }
    
}

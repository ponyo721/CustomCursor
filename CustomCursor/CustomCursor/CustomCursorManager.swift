//
//  CustomCursorManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa
import AppKit

public class CustomCursorManager {
    private let menuIconManager: MenuIconManager? = MenuIconManager()
    
    var eventHandler : GlobalEventMonitor?
    var gecount : Int = 0
    
//    menuIconManager?.showAppMenuIcon()
    
    init() {
        print("CustomCursorManager init")
        
        menuIconManager?.showAppMenuIcon()
        
        eventHandler = GlobalEventMonitor(mask: .leftMouseDown, handler: { (mouseEvent: NSEvent?) in
            self.gecount += 1
            print("global event monitor: \(self.gecount)")
        })
        eventHandler?.start()
    }
}

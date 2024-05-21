//
//  AppDelegate.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var menuIconManager: MenuIconManager? = MenuIconManager()
    
    @IBOutlet var window: NSWindow!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.level = .floating
        
        menuIconManager?.showAppMenuIcon()
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
}


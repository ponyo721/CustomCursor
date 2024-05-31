//
//  AppDelegate.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let customCursorManager: CustomCursorManager! = CustomCursorManager()
    let sharedData : SharedData = SharedData.sharedData
    
    @IBOutlet var window: NSWindow!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
        sharedData.saveData()
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
}


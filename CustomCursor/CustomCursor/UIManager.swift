//
//  UIManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa

class UIManager {
    private var appUIVisbleModule : AppUIVisbleModule?
    let mouseTrakingWindow = MouseAnimationWC(windowNibName: "MyWindowController")
    
    func initalize(){
        print("[UIManager] initalize")
        
        //  app menu item configure
        let menuItems = [MenuItemConfigure(itemTitle: "menuTitle", keyEquivalent: "k", action: "sayBhpark", actionTarget: self)]
        
        //  app menu configure
        let configure : AppUIVisbleConfigure! = AppUIVisbleConfigure(apaName: "", isShowDockIcon: false, appIconImage: nil, isShowMenuIcon: true, appMenuIconImage: NSImage(systemSymbolName: "visionpro", accessibilityDescription: nil), appMenuItems: menuItems)
        
        // AppUIVisbleModule create && show menu
        appUIVisbleModule = AppUIVisbleModule()
        DispatchQueue.main.async {
            self.appUIVisbleModule?.setVisbleWithConfigure(configure:configure)
        }
        
        // window
        mouseTrakingWindow.showWindow(self)
    }
    
    @objc func sayBhpark() {
        let alert = NSAlert()
        alert.messageText = "bhpark!"
        alert.runModal()
    }
}

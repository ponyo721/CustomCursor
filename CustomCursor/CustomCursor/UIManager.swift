//
//  UIManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa

class UIManager {
    private var appUIVisbleModule : AppUIVisbleModule?
    
    func initalize(){
        print("[UIManager] initalize")
        
        let menuItems = [MenuItemConfigure(itemTitle: "menuTitle", keyEquivalent: "k", action: "sayBhpark", actionTarget: self)]
        
        //
        let configure : AppUIVisbleConfigure! = AppUIVisbleConfigure(apaName: "", isShowDockIcon: false, appIconImage: nil, isShowMenuIcon: true, appMenuIconImage: NSImage(systemSymbolName: "visionpro", accessibilityDescription: nil), appMenuItems: menuItems)
        
        appUIVisbleModule = AppUIVisbleModule()
        
        DispatchQueue.main.async {
            self.appUIVisbleModule?.setVisble(configure:configure)
        }
    }
    
    
    
    @objc func sayBhpark() {
        let alert = NSAlert()
        alert.messageText = "bhpark!"
        alert.runModal()
    }
}

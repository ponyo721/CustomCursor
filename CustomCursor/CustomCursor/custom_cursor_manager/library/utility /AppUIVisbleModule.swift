//
//  AppUIVisbleModule.swift
//  CustomCursor
//
//  Created by 박병호 on 5/23/24.
//

import AppKit

struct AppUIVisbleConfigure {
    var apaName : String?
    var isShowDockIcon : Bool?
    var appIconImage : NSImage?
    
    var isShowMenuIcon : Bool?
    var appMenuIconImage : NSImage?
    var appMenuItems : [MenuItemConfigure]?
}

struct MenuItemConfigure {
    var itemTitle : String!
    var keyEquivalent : String!
    var action : String!
    var actionTarget : AnyObject?
}

public class AppUIVisbleModule {
    private var configure : AppUIVisbleConfigure?
    private var statusItem: NSStatusItem?
    
//    init(configure: AppUIVisbleConfigure?) {
//        self.configure = configure
//    }
    
    func setVisbleWithConfigure(configure: AppUIVisbleConfigure){
        print("[AppUIVisbleModule] setVisbleWithConfigure")
        
        self.configure = configure
        // apaName
        
        if self.configure?.isShowDockIcon ?? false {

        }else {
            NSApp.setActivationPolicy(.accessory)
        }
        // appIconImage
        
        if self.configure?.isShowMenuIcon ?? false {
            self.showAppMenuIconWithItems(items:self.configure!.appMenuItems!)
        }
        // appMenuIconImage
    }
    
    func showAppMenuIconWithItems(items: [MenuItemConfigure]) {
        print("[AppUIVisbleModule] showAppMenuIconWithItems")
        // 상태 아이템 생성
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            if self.configure?.appMenuIconImage == nil {
                button.image = NSImage(systemSymbolName: "highlighter", accessibilityDescription: "Menu Icon")
            }else {
                let config = NSImage.SymbolConfiguration(scale: .large)
                button.image = self.configure!.appMenuIconImage?.withSymbolConfiguration(config)
            }
        }
        
        // 메뉴 생성
        let menu = NSMenu()
        for item in items {
            let menuItem = NSMenuItem(title: item.itemTitle, action: Selector(item.action), keyEquivalent: item.keyEquivalent)
            menuItem.target = item.actionTarget
            menu.addItem(menuItem)
        }
        
        // 메뉴 아이템에 메뉴 설정
        statusItem?.menu = menu
    }
}

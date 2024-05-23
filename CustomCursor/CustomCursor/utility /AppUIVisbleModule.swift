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
}

public class AppUIVisbleModule {
    private var configure : AppUIVisbleConfigure?
    private var statusItem: NSStatusItem?
    
//    init(configure: AppUIVisbleConfigure?) {
//        self.configure = configure
//    }
    
    func setVisble(_ configure: AppUIVisbleConfigure){
        // apaName
        
        // isShowDockIcon
        NSApp.setActivationPolicy(.accessory)
        // appIconImage
        
        if configure.isShowMenuIcon ?? false {
            self.showAppMenuIcon()
        }
        // appMenuIconImage
    }
    
    func showAppMenuIcon() {
        print("[AppUIVisbleModule] showAppMenuIcon")
        // 상태 아이템 생성
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "star.fill", accessibilityDescription: "Menu Icon")
        }
        
        // 메뉴 생성
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Say Hello", action: #selector(sayHello), keyEquivalent: "H"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        
        // 메뉴 아이템에 메뉴 설정
        statusItem?.menu = menu
    }
    
    // test func
    @objc func sayHello() {
        let alert = NSAlert()
        alert.messageText = "Hello!"
        alert.runModal()
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(nil)
    }
}

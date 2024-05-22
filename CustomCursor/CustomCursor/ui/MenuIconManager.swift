//
//  MenuIconManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa

class MenuIconManager {
    var statusItem: NSStatusItem?
    
    init() {
        print("MenuIconManager init")
    }
    
    func showAppMenuIcon() {
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
    
    //
    @objc func sayHello() {
        let alert = NSAlert()
        alert.messageText = "Hello!"
        alert.runModal()
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(nil)
    }
}

//
//  CustomCursorManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa
import AppKit

public class CustomCursorManager {
    private let uiManager: UIManager! = UIManager()
    private let systemEventManager: SystemEventManager! = SystemEventManager()
    
    init() {
        print("[CustomCursorManager] init")
        
        self.initalizeApplication()
    }
    
    func initalizeApplication(){
        print("[CustomCursorManager] initalizeApplication")
        
        uiManager.initalize()
        systemEventManager.initalize()
    }
}

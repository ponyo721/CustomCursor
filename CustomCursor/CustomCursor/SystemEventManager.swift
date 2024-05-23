//
//  SystemEventManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/23/24.
//

import Foundation
import AppKit

public class SystemEventManager {
    private var eventListener : SystemMouseEventListenerModule?
    
    func initalize(){
        print("[SystemEventManager] initalize")
            
        // global mouse event
        eventListener = SystemMouseEventListenerModule(globalEventMask: .mouseMoved, globalHandler: { (mouseEvent: NSEvent?) in
//            print("global event monitor")
        })
        
        eventListener?.startGlobalMouseEventListener()
        
        // local mouse event
    }
}

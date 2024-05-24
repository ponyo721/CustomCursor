//
//  SystemEventManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/23/24.
//

import Foundation
import AppKit

protocol SystemEventManagerDelegate: AnyObject {
    func actionGlobalMouseEvent(event:NSEvent?)
}

public class SystemEventManager {
    var delegate : SystemEventManagerDelegate?
    private var eventListener : SystemMouseEventListenerModule?
    
    func initalize(){
        print("[SystemEventManager] initalize")
            
        // global mouse event
        eventListener = SystemMouseEventListenerModule(globalEventMask: [.mouseMoved, .leftMouseDragged, .rightMouseDragged, .leftMouseDown, .leftMouseUp, .otherMouseDragged], globalHandler: { (mouseEvent: NSEvent?) in
            
            self.delegate?.actionGlobalMouseEvent(event: mouseEvent)
        })
        
        eventListener?.startGlobalMouseEventListener()
        
        // local mouse event
    }
}

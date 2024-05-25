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
    func actionLocalMouseEvent(event:NSEvent?)
}

public class SystemEventManager : SystemMouseEventListenerModuleDelegate {
    var delegate : SystemEventManagerDelegate?
    private var eventListener : SystemMouseEventListenerModule?
    
    func initalize(){
        print("[SystemEventManager] initalize")
            
        // global mouse event
//        eventListener = SystemMouseEventListenerModule(globalEventMask: [.mouseMoved, .leftMouseDragged, .rightMouseDragged, .leftMouseDown, .leftMouseUp, .otherMouseDragged], globalHandler: { (mouseEvent: NSEvent?) in
//            
//            self.delegate?.actionGlobalMouseEvent(event: mouseEvent)
//        })
        
        let eventMaskList : NSEvent.EventTypeMask = [.mouseMoved, .leftMouseDragged, .rightMouseDragged, .leftMouseDown, .leftMouseUp, .otherMouseDragged]
        
        eventListener = SystemMouseEventListenerModule(delegate: self, globalEventMask: eventMaskList, globalHandler: { (mouseEvent: NSEvent?) in
            
            self.delegate?.actionGlobalMouseEvent(event: mouseEvent)
        }, localEventMask: eventMaskList)
        
        eventListener?.delegate = self
        
        eventListener?.startGlobalMouseEventListener()
        
        // local mouse event
        eventListener?.startLocalMouseEventListener()
    }
    
    func actionLocalMouseEvent(event:NSEvent?){
        print("[SystemEventManager] actionLocalMouseEvent")
        self.delegate?.actionLocalMouseEvent(event: event)
    }
}

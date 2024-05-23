//
//  SystemMouseEventListenerModule.swift
//  CustomCursor
//
//  Created by 박병호 on 5/23/24.
//

import AppKit

class SystemMouseEventListenerModule {
    
    private var globalEventmonitor: AnyObject?
    private var globalEventMask: NSEvent.EventTypeMask = []
    private var globalHandler: (NSEvent?) -> Void
    
//    private var localEventmonitor: AnyObject?
//    private var localEventMask: NSEvent.EventTypeMask
//    private var localHandler: (NSEvent?) -> Void
    
//    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
//        self.mask = mask
//        self.handler = handler
//    }
    
    init(globalEventmonitor: AnyObject? = nil, globalEventMask: NSEvent.EventTypeMask, globalHandler: @escaping (NSEvent?) -> Void) {
        self.globalEventmonitor = globalEventmonitor
        self.globalEventMask = globalEventMask
        self.globalHandler = globalHandler
    }
    
    
    deinit {
        stopGlobalMouseEventListener()
    }
    
    func initalize(){
        
    }
    
    public func startGlobalMouseEventListener() {
        globalEventmonitor = NSEvent.addGlobalMonitorForEvents(matching: globalEventMask, handler: globalHandler) as AnyObject?
    }
    
    public func stopGlobalMouseEventListener() {
        if globalEventmonitor != nil {
            NSEvent.removeMonitor(globalEventmonitor!)
            globalEventmonitor = nil
        }
    }
    
    
}

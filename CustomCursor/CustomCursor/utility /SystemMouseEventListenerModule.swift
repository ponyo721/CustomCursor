//
//  SystemMouseEventListenerModule.swift
//  CustomCursor
//
//  Created by 박병호 on 5/23/24.
//

import AppKit

protocol SystemMouseEventListenerModuleDelegate: AnyObject {
    func actionLocalMouseEvent(event:NSEvent?)
}

class SystemMouseEventListenerModule {
    var delegate : SystemMouseEventListenerModuleDelegate?
    
    private var globalEventmonitor: AnyObject?
    private var globalEventMask: NSEvent.EventTypeMask = []
    private var globalHandler: (NSEvent?) -> Void
    
    private var localEventmonitor: AnyObject?
    private var localEventMask: NSEvent.EventTypeMask = []
    
    init(delegate: SystemMouseEventListenerModuleDelegate? = nil, globalEventmonitor: AnyObject? = nil, globalEventMask: NSEvent.EventTypeMask, globalHandler: @escaping (NSEvent?) -> Void, localEventmonitor: AnyObject? = nil, localEventMask: NSEvent.EventTypeMask) {
        self.delegate = delegate
        self.globalEventmonitor = globalEventmonitor
        self.globalEventMask = globalEventMask
        self.globalHandler = globalHandler
        self.localEventmonitor = localEventmonitor
        self.localEventMask = localEventMask
    }
    
//    init(globalEventmonitor: AnyObject? = nil, globalEventMask: NSEvent.EventTypeMask, globalHandler: @escaping (NSEvent?) -> Void) {
//        self.globalEventmonitor = globalEventmonitor
//        self.globalEventMask = globalEventMask
//        self.globalHandler = globalHandler
//    }
    
    
    deinit {
        stopGlobalMouseEventListener()
    }
    
    func initalize(){
        
    }
    
    // global
    public func startGlobalMouseEventListener() {
        globalEventmonitor = NSEvent.addGlobalMonitorForEvents(matching: globalEventMask, handler: globalHandler) as AnyObject?
    }
    
    public func stopGlobalMouseEventListener() {
        if globalEventmonitor != nil {
            NSEvent.removeMonitor(globalEventmonitor!)
            globalEventmonitor = nil
        }
    }
    
    // local
    public func startLocalMouseEventListener() {
        localEventmonitor = NSEvent.addLocalMonitorForEvents(matching: localEventMask) { [weak self] event in
            self?.handleMouseDown(event)
            return event
        } as AnyObject?
    }
    
    private func handleMouseDown(_ event: NSEvent) {
        self.delegate?.actionLocalMouseEvent(event: event)
    }
    
    
}

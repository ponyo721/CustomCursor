//
//  CustomCursorManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa
import AppKit

public class CustomCursorManager : SystemEventManagerDelegate{
    private let uiManager: UIManager! = UIManager()
    private let systemEventManager: SystemEventManager! = SystemEventManager()
    
    init() {
        print("[CustomCursorManager] init")
        
        self.initalizeApplication()
    }
    
    func initalizeApplication(){
        print("[CustomCursorManager] initalizeApplication")
        
        uiManager.initalize()
        systemEventManager.delegate = self
        systemEventManager.initalize()
    }
    
    func actionGlobalMouseEvent(event:NSEvent?){
        print("[CustomCursorManager] actionGlobalMouseEvent")
      
        let positionX : CGFloat = NSEvent.mouseLocation.x - ((uiManager.mouseTrackingWindow.window?.frame.size.width ?? 1)/2)
        let positionY : CGFloat = NSEvent.mouseLocation.y - ((uiManager.mouseTrackingWindow.window?.frame.size.height ?? 1)/2)
        
        uiManager.mouseTrackingWindow.window?.setFrameOrigin(NSMakePoint(positionX, positionY))
    }
}

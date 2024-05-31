//
//  UIManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa

class UIManager : SettingWCDelegate{
    let sharedData : SharedData = SharedData.sharedData
    
    private var appUIVisbleModule : AppUIVisbleModule?
    let mouseTrackingWindow = MouseAnimationWC(windowNibName: "MyWindowController")
    var settingWC : SettingWC?
    
    func initalize(){
        print("[UIManager] initalize")
        
        //  app menu item configure
        let menuItems = [MenuItemConfigure(itemTitle: "menuTitle", keyEquivalent: "k", action: "sayBhpark", actionTarget: self), MenuItemConfigure(itemTitle: "settings...", keyEquivalent: "", action: "actionShowSettings", actionTarget: self), MenuItemConfigure(itemTitle: "terminate", keyEquivalent: "", action: "appTerminate", actionTarget: self)]
        
        //  app menu configure
        let configure : AppUIVisbleConfigure! = AppUIVisbleConfigure(apaName: "", isShowDockIcon: false, appIconImage: nil, isShowMenuIcon: true, appMenuIconImage: NSImage(systemSymbolName: "visionpro", accessibilityDescription: nil), appMenuItems: menuItems)
        
        // AppUIVisbleModule create && show menu
        appUIVisbleModule = AppUIVisbleModule()
        self.appUIVisbleModule?.setVisbleWithConfigure(configure:configure)
        
        // mouse tracking window
        mouseTrackingWindow.window?.level = .screenSaver
        mouseTrackingWindow.window?.isOpaque = false
        mouseTrackingWindow.window?.backgroundColor = .clear
        mouseTrackingWindow.window?.ignoresMouseEvents = true // 마우스 이벤트 무시
        
//        mouseTrackingWindow.window?.makeKeyAndOrderFront(nil)
        mouseTrackingWindow.showWindow(nil)
        self.setWindowPositionOnMouse()
        
        // mouse tracking window sub view
        let rotatingRingView : RotatingRingView? = RotatingRingView(frame: mouseTrackingWindow.window!.contentView!.bounds)
        rotatingRingView?.ringRadius = sharedData.effectRingInfo.ringRadius
        rotatingRingView?.ringLineWidth = sharedData.effectRingInfo.ringLineWidth
        rotatingRingView?.ringLineAlpha = sharedData.effectRingInfo.ringLineAlpha
        rotatingRingView?.setupLayer()
        
        mouseTrackingWindow.window?.contentView?.addSubview(rotatingRingView!)
        
    }
    
    // MARK: - private method -
    
    func setWindowPositionOnMouse(){
//        print("[UIManager] setWindowPositionOnMouse")
        
        DispatchQueue.main.async {
            let positionX : CGFloat = NSEvent.mouseLocation.x - ((self.mouseTrackingWindow.window?.frame.size.width ?? 1)/2)
            let positionY : CGFloat = NSEvent.mouseLocation.y - ((self.mouseTrackingWindow.window?.frame.size.height ?? 1)/2)
            
            self.mouseTrackingWindow.window?.setFrameOrigin(NSMakePoint(positionX, positionY))
        }
    }
    
    func reloadView(radius:CYCLE_RING_RADIUS, width:CGFloat, alpha:CGFloat){
        DispatchQueue.main.async {
            self.mouseTrackingWindow.window?.contentView?.subviews.removeAll()
            
            let rotatingRingView : RotatingRingView? = RotatingRingView(frame: self.mouseTrackingWindow.window!.contentView!.bounds)
            rotatingRingView?.ringRadius = radius
            rotatingRingView?.ringLineWidth = width
            rotatingRingView?.ringLineAlpha = alpha
            rotatingRingView?.setupLayer()
            
            self.mouseTrackingWindow.window?.contentView?.addSubview(rotatingRingView!)
        }
    }
    
    // MARK: - test method -
    
    @objc func actionShowSettings(){
        if settingWC == nil {
            settingWC = SettingWC(windowNibName: "SettingWindow")
            settingWC?.delegate = self
            settingWC?.mouseRingRadius = sharedData.effectRingInfo.ringRadius
            settingWC?.mouseRingWidth = sharedData.effectRingInfo.ringLineWidth
            settingWC?.mouseRingAlpha = sharedData.effectRingInfo.ringLineAlpha
        }
        settingWC?.window?.level = .floating
        settingWC?.showWindow(nil)
    }
    
    @objc func sayBhpark() {
        let alert = NSAlert()
        alert.messageText = "bhpark!"
        alert.runModal()
    }
    
    @objc func appTerminate() {
        print("appTerminate")
        NSApp.terminate(nil)
    }
    
    // MARK: - private method -
    func actionSelectRadius(_ raduis: CYCLE_RING_RADIUS) {
        print("[UIManager] actionSelectRadius")
        sharedData.effectRingInfo.ringRadius = raduis
        self.reloadView(radius: sharedData.effectRingInfo.ringRadius, width: sharedData.effectRingInfo.ringLineWidth, alpha: sharedData.effectRingInfo.ringLineAlpha)
    }
    
    func actionRingWidthSlider(_ value: CGFloat) {
        print("[UIManager] actionRingWidthSlider")
        sharedData.effectRingInfo.ringLineWidth = value
        self.reloadView(radius: sharedData.effectRingInfo.ringRadius, width: sharedData.effectRingInfo.ringLineWidth, alpha: sharedData.effectRingInfo.ringLineAlpha)
    }
    
    func actionRingAlphaSlider(_ value: CGFloat) {
        print("[UIManager] actionRingAlphaSlider")
        sharedData.effectRingInfo.ringLineAlpha = value
        self.reloadView(radius: sharedData.effectRingInfo.ringRadius, width: sharedData.effectRingInfo.ringLineWidth, alpha: sharedData.effectRingInfo.ringLineAlpha)
    }
}

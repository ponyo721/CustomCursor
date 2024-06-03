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
    var aboutWC : AboutWC?
    
    func initalize(){
        print("[UIManager] initalize")
        let appName :String = Bundle.main.infoDictionary!["CFBundleName"] as! String
        
        //  app menu item configure
        let menuItems = [MenuItemConfigure(itemTitle: "About " + appName, keyEquivalent: "", action: "showAbout", actionTarget: self), MenuItemConfigure(itemTitle: "settings...", keyEquivalent: "", action: "actionShowSettings", actionTarget: self), MenuItemConfigure(itemTitle: "terminate", keyEquivalent: "", action: "appTerminate", actionTarget: self)]
        
        //  app menu configure
        let configure : AppUIVisbleConfigure! = AppUIVisbleConfigure(apaName: "", isShowDockIcon: false, appIconImage: nil, isShowMenuIcon: true, appMenuIconImage: NSImage(systemSymbolName: "cursorarrow.click.2", accessibilityDescription: nil), appMenuItems: menuItems)
        
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
        
        switch sharedData.effectRingInfo.ringAniMationState {
        case CYCLE_RING_ANIMATION_STATE.NONE:
            rotatingRingView?.addRotationAnimation(to: (rotatingRingView?.layer?.sublayers?.first)!)
            break
        case CYCLE_RING_ANIMATION_STATE.START:
            rotatingRingView?.addRotationAnimation(to: (rotatingRingView?.layer?.sublayers?.first)!)
            break
        case CYCLE_RING_ANIMATION_STATE.STOP:
            break
        }
        
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
    
    func reloadView(radius:CYCLE_RING_RADIUS, width:CGFloat, alpha:CGFloat, animationState:CYCLE_RING_ANIMATION_STATE){
        DispatchQueue.main.async {
            self.mouseTrackingWindow.window?.contentView?.subviews.removeAll()
            
            let rotatingRingView : RotatingRingView? = RotatingRingView(frame: self.mouseTrackingWindow.window!.contentView!.bounds)
            rotatingRingView?.ringRadius = radius
            rotatingRingView?.ringLineWidth = width
            rotatingRingView?.ringLineAlpha = alpha
            rotatingRingView?.setupLayer()
            
            switch animationState {
            case CYCLE_RING_ANIMATION_STATE.NONE:
                rotatingRingView?.addRotationAnimation(to: (rotatingRingView?.layer?.sublayers?.first)!)
                break
            case CYCLE_RING_ANIMATION_STATE.START:
                rotatingRingView?.addRotationAnimation(to: (rotatingRingView?.layer?.sublayers?.first)!)
                break
            case CYCLE_RING_ANIMATION_STATE.STOP:
                break
            }
            
            self.mouseTrackingWindow.window?.contentView?.addSubview(rotatingRingView!)
        }
    }
    
    // MARK: - menu icon action method -
    
    @objc func actionShowSettings(){
        if settingWC == nil {
            settingWC = SettingWC(windowNibName: "SettingWindow")
            settingWC?.delegate = self
            settingWC?.mouseRingRadius = sharedData.effectRingInfo.ringRadius
            settingWC?.mouseRingWidth = sharedData.effectRingInfo.ringLineWidth
            settingWC?.mouseRingAlpha = sharedData.effectRingInfo.ringLineAlpha
            settingWC?.mouseRingAniMationState = sharedData.effectRingInfo.ringAniMationState
        }
        settingWC?.window?.level = .floating
        settingWC?.showWindow(nil)
    }
    
    @objc func showAbout() {
        if aboutWC == nil {
            aboutWC = AboutWC(windowNibName: "AboutWindow")
        }
        aboutWC?.window?.level = .floating
        aboutWC?.showWindow(nil)
    }
    
    @objc func appTerminate() {
        print("appTerminate")
        NSApp.terminate(nil)
    }
    
    // MARK: - settings ui delegate method -
    func actionSelectRadius(_ raduis: CYCLE_RING_RADIUS) {
        print("[UIManager] actionSelectRadius")
        sharedData.effectRingInfo.ringRadius = raduis
        self.reloadView(radius: sharedData.effectRingInfo.ringRadius, width: sharedData.effectRingInfo.ringLineWidth, alpha: sharedData.effectRingInfo.ringLineAlpha, animationState:sharedData.effectRingInfo.ringAniMationState )
    }
    
    func actionRingWidthSlider(_ value: CGFloat) {
        print("[UIManager] actionRingWidthSlider")
        sharedData.effectRingInfo.ringLineWidth = value
        self.reloadView(radius: sharedData.effectRingInfo.ringRadius, width: sharedData.effectRingInfo.ringLineWidth, alpha: sharedData.effectRingInfo.ringLineAlpha, animationState:sharedData.effectRingInfo.ringAniMationState )
    }
    
    func actionRingAlphaSlider(_ value: CGFloat) {
        print("[UIManager] actionRingAlphaSlider")
        sharedData.effectRingInfo.ringLineAlpha = value
        self.reloadView(radius: sharedData.effectRingInfo.ringRadius, width: sharedData.effectRingInfo.ringLineWidth, alpha: sharedData.effectRingInfo.ringLineAlpha, animationState:sharedData.effectRingInfo.ringAniMationState )
    }
    
    func actionRingAnimationBtn(_ isOn:Bool) {
        if isOn {
            sharedData.effectRingInfo.ringAniMationState = CYCLE_RING_ANIMATION_STATE.START
        }else {
            sharedData.effectRingInfo.ringAniMationState = CYCLE_RING_ANIMATION_STATE.STOP
        }
        
        self.reloadView(radius: sharedData.effectRingInfo.ringRadius, width: sharedData.effectRingInfo.ringLineWidth, alpha: sharedData.effectRingInfo.ringLineAlpha, animationState:sharedData.effectRingInfo.ringAniMationState )
    }
}

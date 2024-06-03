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
        reloadViewWithInfo(sharedData.effectRingInfo)
        
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
    

    func reloadViewWithInfo(_ info:EffectRingInfo){
        print("#else reloadViewWithInfo")
        DispatchQueue.main.async {
            self.mouseTrackingWindow.window?.contentView?.subviews.removeAll()
            
            var subView : CircleViewCommonInstance? = nil
            
            switch self.sharedData.effectRingInfo.ringType {
            case CYCLE_RING_TYPE.NONE:
                subView = GradientRingView(frame: self.mouseTrackingWindow.window!.contentView!.bounds)
                break
            case CYCLE_RING_TYPE.NORMAL:
                subView = RotatingRingView(frame: self.mouseTrackingWindow.window!.contentView!.bounds)
                break
            case CYCLE_RING_TYPE.GRADATION:
                subView = GradientRingView(frame: self.mouseTrackingWindow.window!.contentView!.bounds)
                break
            }
            subView?.effectRingInfo = self.sharedData.effectRingInfo
            subView?.setupLayer()
            self.mouseTrackingWindow.window?.contentView?.addSubview(subView!)
        }
    }

    
    // MARK: - menu icon action method -
    
    @objc func actionShowSettings(){
        if settingWC == nil {
            settingWC = SettingWC(windowNibName: "SettingWindow")
            settingWC?.delegate = self
            settingWC?.effectRingInfo = sharedData.effectRingInfo
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
        self.reloadViewWithInfo(sharedData.effectRingInfo)
    }
    
    func actionRingWidthSlider(_ value: CGFloat) {
        print("[UIManager] actionRingWidthSlider")
        sharedData.effectRingInfo.ringLineWidth = value
        self.reloadViewWithInfo(sharedData.effectRingInfo)
    }
    
    func actionRingAlphaSlider(_ value: CGFloat) {
        print("[UIManager] actionRingAlphaSlider")
        sharedData.effectRingInfo.ringLineAlpha = value
        self.reloadViewWithInfo(sharedData.effectRingInfo)
    }
    
    func actionRingAnimationBtn(_ isOn:Bool) {
        if isOn {
            sharedData.effectRingInfo.ringAniMationState = CYCLE_RING_ANIMATION_STATE.START
        }else {
            sharedData.effectRingInfo.ringAniMationState = CYCLE_RING_ANIMATION_STATE.STOP
        }
        self.reloadViewWithInfo(sharedData.effectRingInfo)
    }
}

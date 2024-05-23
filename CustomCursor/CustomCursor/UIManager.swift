//
//  UIManager.swift
//  CustomCursor
//
//  Created by 박병호 on 5/22/24.
//

import Cocoa

class UIManager {
    private var appUIVisbleModule : AppUIVisbleModule?
    
    func initalize(){
        print("[UIManager] initalize")
        
        //
        let configure : AppUIVisbleConfigure! = AppUIVisbleConfigure(apaName: "", isShowDockIcon: false, appIconImage: nil, isShowMenuIcon: true, appMenuIconImage: nil)
        
        appUIVisbleModule = AppUIVisbleModule()
        appUIVisbleModule?.setVisble(configure)
    }
}

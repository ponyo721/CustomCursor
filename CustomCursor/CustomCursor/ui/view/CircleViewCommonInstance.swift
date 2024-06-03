//
//  RingView.swift
//  CustomCursor
//
//  Created by 박병호 on 6/3/24.
//

import Cocoa

public class CircleViewCommonInstance : NSView{
    var effectRingInfo : EffectRingInfo! = EffectRingInfo(ringType: .NONE, ringRadius: .MIDDLE, ringLineWidth: DEFAULT_RING_LINE_WIDTH, ringLineAlpha: DEFAULT_RING_LINE_ALPHA, ringAniMationState: .NONE)
    
    func setupLayer() {
        
    }
    

}

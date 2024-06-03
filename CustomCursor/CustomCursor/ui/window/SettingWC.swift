//
//  SettingWC.swift
//  CustomCursor
//
//  Created by 박병호 on 5/27/24.
//

import Cocoa

protocol SettingWCDelegate: AnyObject {
    func actionSelectRadius(_ raduis:CYCLE_RING_RADIUS)
    func actionRingWidthSlider(_ value:CGFloat)
    func actionRingAlphaSlider(_ value:CGFloat)
    func actionRingAnimationBtn(_ isOn:Bool)
}

public class SettingWC : NSWindowController, NSWindowDelegate{
    var delegate : SettingWCDelegate?
    var mouseRingRadius : CYCLE_RING_RADIUS = CYCLE_RING_RADIUS.MIDDLE
    var mouseRingWidth : CGFloat = DEFAULT_RING_LINE_WIDTH
    var mouseRingAlpha : CGFloat = DEFAULT_RING_LINE_ALPHA
    var mouseRingAniMationState : CYCLE_RING_ANIMATION_STATE = .NONE
    
    @IBOutlet weak var radiusComboBox: NSComboBox!
    @IBOutlet weak var ringWidthSlider: NSSlider!
    @IBOutlet weak var ringAlphaSlider: NSSlider!
    @IBOutlet weak var animationCheckBoxBtn: NSButton!
    
    public override var windowNibName: NSNib.Name? {    // load custom xib object
        return NSNib.Name("SettingWindow")
    }
    
    public override func windowDidLoad() {
        print("[SettingWC] windowDidLoad")
        
        self.initalizeUI()
    }
    
    public func windowShouldClose(_ sender: NSWindow) -> Bool {
        print("[SettingWC] windowShouldClose")
        
        return true
    }
    
    // MARK: - private -
    
    func initalizeUI(){
        radiusComboBox.removeAllItems()
        radiusComboBox.addItems(withObjectValues: ["LARGE","MIDDLE","SMALL"])
        
        switch mouseRingRadius {
        case CYCLE_RING_RADIUS.LARGE :
            radiusComboBox.selectItem(at: 0)
            
        case CYCLE_RING_RADIUS.MIDDLE :
            radiusComboBox.selectItem(at: 1)
            
        case CYCLE_RING_RADIUS.SMALL :
            radiusComboBox.selectItem(at: 2)
        }
        
        ringWidthSlider.maxValue = MAX_RING_LINE_WIDTH
        ringWidthSlider.minValue = MIN_RING_LINE_WIDTH
        ringWidthSlider.floatValue = Float(mouseRingWidth)
        
        ringAlphaSlider.maxValue = MAX_RING_LINE_ALPHA
        ringAlphaSlider.minValue = MIN_RING_LINE_ALPHA
        ringAlphaSlider.floatValue = Float(mouseRingAlpha)
        
        switch mouseRingAniMationState {
        case CYCLE_RING_ANIMATION_STATE.NONE:
            animationCheckBoxBtn.state = .on
            break
        case CYCLE_RING_ANIMATION_STATE.START:
            animationCheckBoxBtn.state = .on
            break
        case CYCLE_RING_ANIMATION_STATE.STOP:
            animationCheckBoxBtn.state = .off
            break
        }
    }
    
    // MARK: - ui action -
    
    @IBAction func actionSelectRadius(_ sender: Any) {
        print("[SettingWC] actionSelectRadius : \(radiusComboBox.indexOfSelectedItem)")
        switch radiusComboBox.indexOfSelectedItem {
        case 0 :
            delegate?.actionSelectRadius(CYCLE_RING_RADIUS.LARGE)
        case 1 :
            delegate?.actionSelectRadius(CYCLE_RING_RADIUS.MIDDLE)
        case 2 :
            delegate?.actionSelectRadius(CYCLE_RING_RADIUS.SMALL)
        default:
            delegate?.actionSelectRadius(CYCLE_RING_RADIUS.MIDDLE)
        }
    }
    
    @IBAction func actionRingWidthSlider(_ sender: Any) {
        print("[SettingWC] actionRingWidthSlider : \(ringWidthSlider.floatValue)")
        
        delegate?.actionRingWidthSlider(CGFloat(ringWidthSlider.floatValue))
    }
    
    
    @IBAction func actionRingAlphaSlider(_ sender: Any) {
        print("[SettingWC] actionRingAlphaSlider : \(ringAlphaSlider.floatValue)")
        delegate?.actionRingAlphaSlider(CGFloat(ringAlphaSlider.floatValue))
    }
    
    @IBAction func actionAnimationCheckBox(_ sender: Any) {
        
        if animationCheckBoxBtn.state == .on {
            delegate?.actionRingAnimationBtn(true)
        }else{
            delegate?.actionRingAnimationBtn(false)
        }
    }
    
}

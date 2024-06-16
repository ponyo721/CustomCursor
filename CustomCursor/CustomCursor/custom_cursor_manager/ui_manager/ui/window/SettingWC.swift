//
//  SettingWC.swift
//  CustomCursor
//
//  Created by 박병호 on 5/27/24.
//

import Cocoa

protocol SettingWCDelegate: AnyObject {
    func actionSelectRingType(_ type:CYCLE_RING_TYPE)
    func actionSelectRadius(_ raduis:CYCLE_RING_RADIUS)
    func actionRingWidthSlider(_ value:CGFloat)
    func actionRingAlphaSlider(_ value:CGFloat)
    func actionRingAnimationBtn(_ isOn:Bool)
    func setNewColorSet(colorList:[Color])
}

public class SettingWC : NSWindowController, NSWindowDelegate, ColorSetVCDelegate{
    var colorSetCount : Int = 5
    var delegate : SettingWCDelegate?
    var effectRingInfo : EffectRingInfo! = EffectRingInfo(ringType:.NONE, ringRadius: .MIDDLE, ringLineWidth: DEFAULT_RING_LINE_WIDTH, ringLineAlpha: DEFAULT_RING_LINE_ALPHA, ringAniMationState: .NONE, ringColorList: nil)
    
    private let colorSetPadding : CGFloat = 10
    private var colorSetVCList : [ColorSetVC] = []
    
    // ring shape
    @IBOutlet weak var ringTypeComboBox: NSComboBox!
    @IBOutlet weak var radiusComboBox: NSComboBox!
    @IBOutlet weak var ringWidthSlider: NSSlider!
    @IBOutlet weak var ringAlphaSlider: NSSlider!
    @IBOutlet weak var animationCheckBoxBtn: NSButton!
    
    // ring color
    @IBOutlet var colorSetViewArea: NSView!
    
    
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
        ringTypeComboBox.removeAllItems()
        ringTypeComboBox.addItems(withObjectValues: ["NORMAL","GRADATION"])
        
        switch effectRingInfo.ringType {
        case .NONE:
            ringTypeComboBox.selectItem(at: 1)
        case .NORMAL:
            ringTypeComboBox.selectItem(at: 0)
        case .GRADATION:
            ringTypeComboBox.selectItem(at: 1)
        }
        
        radiusComboBox.removeAllItems()
        radiusComboBox.addItems(withObjectValues: ["LARGE","MIDDLE","SMALL"])
        
        switch effectRingInfo.ringRadius {
        case CYCLE_RING_RADIUS.LARGE :
            radiusComboBox.selectItem(at: 0)
            
        case CYCLE_RING_RADIUS.MIDDLE :
            radiusComboBox.selectItem(at: 1)
            
        case CYCLE_RING_RADIUS.SMALL :
            radiusComboBox.selectItem(at: 2)
        }
        
        ringWidthSlider.maxValue = MAX_RING_LINE_WIDTH
        ringWidthSlider.minValue = MIN_RING_LINE_WIDTH
        ringWidthSlider.floatValue = Float(effectRingInfo.ringLineWidth)
        
        ringAlphaSlider.maxValue = MAX_RING_LINE_ALPHA
        ringAlphaSlider.minValue = MIN_RING_LINE_ALPHA
        ringAlphaSlider.floatValue = Float(effectRingInfo.ringLineAlpha)
        
        switch effectRingInfo.ringAniMationState {
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
        
        for idx in 0..<colorSetCount {
            let color : Color? = effectRingInfo.ringColorList?[idx] ?? nil
            
            let colorSetVC = ColorSetVC(nibName: ColorSetVC.className(), bundle: nil)
            colorSetVC.viewIdx = idx
            colorSetVC.colorSetTitle = "color_\(idx) :"
            colorSetVC.colorSetColor = color != nil ? color!.color : NSColor.black
            colorSetVC.isHasColor = color != nil ? true : false
            colorSetVC.delegate = self
            colorSetVC.view.frame.origin = CGPointMake(0, (colorSetVC.view.frame.size.height + colorSetPadding) * CGFloat((idx+1)))
            
            colorSetViewArea.addSubview(colorSetVC.view)
            colorSetVCList.append(colorSetVC)
        }
        
    }
    
    // MARK: - ui action -
    @IBAction func actionSelectRingType(_ sender: Any) {
        print("[SettingWC] actionSelectRingType : \(ringTypeComboBox.indexOfSelectedItem)")
        switch ringTypeComboBox.indexOfSelectedItem {
        case 0 :
            delegate?.actionSelectRingType(CYCLE_RING_TYPE.NORMAL)
        case 1 :
            delegate?.actionSelectRingType(CYCLE_RING_TYPE.GRADATION)
        default:
            delegate?.actionSelectRadius(CYCLE_RING_RADIUS.MIDDLE)
        }
    }
    
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
    
    // MARK: - ColorSetVCDelegate -
    func actionColorSetCheckBoxWithIdx(idx: Int, isOn: Bool) {
        print("[SettingWC] actionColorSetCheckBoxWithIdx : \(idx), isOn : \(isOn)")
        let colorSetVC = colorSetVCList[idx]
        colorSetVC.setColorSetWellState(isOn)
        
//        if isOn {
//            effectRingInfo.ringColorList?[idx] = Color(color: NSColor.black)
//        }else {
//            effectRingInfo.ringColorList?[idx] = Color(color: NSColor.black)
//        }
        
        self.delegate?.setNewColorSet(colorList: effectRingInfo.ringColorList ?? [])
    }
    
    func actionColorSetWellWithIdx(idx:Int, color:NSColor) {
        print("[SettingWC] actionColorSetWellWithIdx : \(idx), color : \(color)")
        effectRingInfo.ringColorList?[idx] = Color(color: color)
        
        self.delegate?.setNewColorSet(colorList: effectRingInfo.ringColorList ?? [])
    }
    
}

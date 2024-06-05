//
//  ColorSetVC.swift
//  CustomCursor
//
//  Created by 박병호 on 6/5/24.
//

import Foundation
import AppKit

protocol ColorSetVCDelegate: AnyObject {
    func actionColorSetCheckBoxWithIdx(idx:Int, isOn:Bool)
    func actionColorSetWellWithIdx(idx:Int, color:NSColor)
}

public class ColorSetVC : NSViewController{
    var delegate : ColorSetVCDelegate?
    var viewIdx : Int = 0
    var colorSetTitle : String = ""
    var colorSetColor : NSColor = NSColor.red
    var isHasColor : Bool = false
    
    @IBOutlet weak var colorSetCheckBox: NSButton!
    @IBOutlet weak var colorSetWell: NSColorWell!
    
    public override var nibName: NSNib.Name? {
        return NSNib.Name("ColorSetView")
    }
    
    public override func viewDidLoad() {
        print("[ColorSetVC] viewDidLoad")
        
        colorSetCheckBox.title = colorSetTitle
        colorSetWell.color = colorSetColor
        
        if isHasColor {
            colorSetCheckBox.state = .on
            colorSetWell.isEnabled = true
        }else {
            colorSetCheckBox.state = .off
            colorSetWell.isEnabled = false
        }
    }
    
    func setColorSetWellState(_ isEnabled:Bool) {
        if !isEnabled {
            colorSetWell.color = .black
        }else {
            colorSetWell.color = colorSetColor
        }
        colorSetWell.isEnabled = isEnabled
    }
    
    @IBAction func actionColorSetCheckBox(_ sender: Any) {
        print("[ColorSetVC] actionColorSetCheckBox")
        
        if colorSetCheckBox.state == .on{
            self.delegate?.actionColorSetCheckBoxWithIdx(idx: viewIdx, isOn: true)
        }else{
            self.delegate?.actionColorSetCheckBoxWithIdx(idx: viewIdx, isOn: false)
        }
    }
    
    @IBAction func actionColorSetWell(_ sender: NSColorWell) {
        print("[ColorSetVC] actionColorSetWell")
        let color = sender.color
        self.delegate?.actionColorSetWellWithIdx(idx: viewIdx, color: color)
    }
}

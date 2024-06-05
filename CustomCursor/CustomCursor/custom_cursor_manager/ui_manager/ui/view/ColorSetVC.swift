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
//    func actionColorSetWell(_ raduis:CYCLE_RING_RADIUS)
}

public class ColorSetVC : NSViewController{
    var delegate : ColorSetVCDelegate?
    var viewIdx : Int = 0
    
    @IBOutlet weak var colorSetCheckBox: NSButton!
    @IBOutlet weak var colorSetWell: NSColorWell!
    
    public override var nibName: NSNib.Name? {
        return NSNib.Name("ColorSetView")
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
        let color = sender.color
        dump("[ColorSetVC] actionColorSetWell \(color)")
        
    }
}

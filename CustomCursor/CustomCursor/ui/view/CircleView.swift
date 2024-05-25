//
//  CircleView.swift
//  CustomCursor
//
//  Created by 박병호 on 5/24/24.
//

import Cocoa

public class CircleView : NSView{
    
    //    public override func draw(_ dirtyRect: NSRect) {
    //        super.draw(dirtyRect)
    //
    //        let context = NSGraphicsContext.current!.cgContext
    //        context.saveGState()
    //        context.setFillColor(NSColor.red.cgColor)
    //        context.fillEllipse(in: dirtyRect)
    //        context.restoreGState()
    //    }
    
    //    override init(frame frameRect: NSRect) {
    //        super.init(frame: frameRect)
    //        self.wantsLayer = true
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        super.init(coder: coder)
    //        self.wantsLayer = true
    //    }
    //
    //    public override func draw(_ dirtyRect: NSRect) {
    //        super.draw(dirtyRect)
    //
    //        // 무지개 색상 배열
    //        let colors: [NSColor] = [
    //            .red, .orange, .yellow, .green, .blue,
    //        ]
    //
    //        guard let context = NSGraphicsContext.current?.cgContext else { return }
    //
    //        let lineWidth: CGFloat = 20.0
    //        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
    //        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    //
    //        for (index, color) in colors.enumerated() {
    //            let startAngle = CGFloat(index) * (360.0 / CGFloat(colors.count))
    //            let endAngle = CGFloat(index + 1) * (360.0 / CGFloat(colors.count))
    //            let path = NSBezierPath()
    //            path.appendArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
    //            path.lineWidth = lineWidth
    //            color.set()
    //            path.stroke()
    //        }
    //    }
    
    
    //    override init(frame frameRect: NSRect) {
    //        super.init(frame: frameRect)
    //        self.wantsLayer = true
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        super.init(coder: coder)
    //        self.wantsLayer = true
    //    }
    //
    //    public override func draw(_ dirtyRect: NSRect) {
    //        super.draw(dirtyRect)
    //
    //        // 무지개 색상 배열
    //        let colors: [NSColor] = [
    //            .red, .orange, .yellow, .green, .blue
    //        ]
    //
    //        guard let context = NSGraphicsContext.current?.cgContext else { return }
    //
    //        let lineWidth: CGFloat = 20.0
    //        let outerRadius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
    //        let innerRadius = outerRadius - lineWidth
    //        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    //
    //        for (index, color) in colors.enumerated() {
    //            let startAngle = CGFloat(index) * (360.0 / CGFloat(colors.count))
    //            let endAngle = CGFloat(index + 1) * (360.0 / CGFloat(colors.count))
    //
    //            let path = NSBezierPath()
    //            path.appendArc(withCenter: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
    //            path.lineWidth = lineWidth
    //            color.set()
    //            path.stroke()
    //        }
    //
    //        // 내부 원을 그려서 속을 뚫음
    //        let innerCirclePath = NSBezierPath()
    //        innerCirclePath.appendArc(withCenter: center, radius: innerRadius, startAngle: 0, endAngle: 360, clockwise: false)
    //        NSColor.clear.set()
    //        innerCirclePath.fill()
    //    }
    
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // 무지개 색상 배열
        let colors: [NSColor] = [
            .red.withAlphaComponent(0.2), .orange.withAlphaComponent(0.2), .yellow.withAlphaComponent(0.2), .green.withAlphaComponent(0.2), .blue.withAlphaComponent(0.2), .purple.withAlphaComponent(0.2)
        ]
        
        guard (NSGraphicsContext.current?.cgContext) != nil else { return }
        
        let lineWidth: CGFloat = 20.0
        let outerRadius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
        let innerRadius = outerRadius - lineWidth
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        for (index, color) in colors.enumerated() {
            let startAngle = CGFloat(index) * (360.0 / CGFloat(colors.count))
            let endAngle = CGFloat(index + 1) * (360.0 / CGFloat(colors.count))
            
            // 외부 원호
            let outerArcPath = NSBezierPath()
            outerArcPath.appendArc(withCenter: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            // 내부 원호
            let innerArcPath = NSBezierPath()
            innerArcPath.appendArc(withCenter: center, radius: innerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            // 링 모양을 위한 경로 구성
            let ringPath = NSBezierPath()
            ringPath.append(outerArcPath)
//            ringPath.append(innerArcPath.reversing())
            ringPath.append(innerArcPath.reversed)
            ringPath.close()
            
            color.set()
            ringPath.fill()
        }
    }
    
}

//
//  GradientRingView.swift
//  CustomCursor
//
//  Created by 박병호 on 6/3/24.

import Cocoa
import QuartzCore

class GradientRingView: CircleViewCommonInstance {
    
    private let gradientLayer = CAGradientLayer()
    private let shapeLayer = CAShapeLayer()
    
    override public func setupLayer() {
        super.setupLayer()
        self.layer?.sublayers?.removeAll()
        
        wantsLayer = true
        guard let layer = self.layer else { return }
        
        // Configure gradient layer
        gradientLayer.colors = [NSColor.red.cgColor, NSColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = bounds
        
        // Configure shape layer for masking
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - 10
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * .pi
        let path = CGMutablePath()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = path
        shapeLayer.lineWidth = effectRingInfo.ringLineWidth
        shapeLayer.fillColor = NSColor.clear.cgColor
        shapeLayer.strokeColor = NSColor.black.cgColor
        
        // Apply mask to gradient layer
        gradientLayer.mask = shapeLayer
        
        // Add gradient layer to view's layer
        layer.addSublayer(gradientLayer)
        
        // Add rotation animation
        switch effectRingInfo.ringAniMationState {
        case CYCLE_RING_ANIMATION_STATE.NONE:
            addRotationAnimation()
            break
        case CYCLE_RING_ANIMATION_STATE.START:
            addRotationAnimation()
            break
        case CYCLE_RING_ANIMATION_STATE.STOP:
            break
        }
    }
    
    func addRotationAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2 * 3.14
        rotationAnimation.duration = 2.0
        rotationAnimation.repeatCount = .infinity
        
        gradientLayer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    override func layout() {
        super.layout()
        gradientLayer.frame = bounds
    }
}

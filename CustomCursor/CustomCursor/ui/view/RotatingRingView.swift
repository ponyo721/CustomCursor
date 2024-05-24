//
//  RotatingRingView.swift
//  CustomCursor
//
//  Created by 박병호 on 5/24/24.
//

//import Cocoa
//
//class RotatingRingView: NSView {
//
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
//        self.wantsLayer = true
//        setupLayer()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.wantsLayer = true
//        setupLayer()
//    }
//
//    private func setupLayer() {
//        let ringLayer = createRingLayer()
//        self.layer?.addSublayer(ringLayer)
//        addRotationAnimation(to: ringLayer)
//    }
//
//    private func createRingLayer() -> CAShapeLayer {
//        let lineWidth: CGFloat = 10.0
//        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
//        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
//
//        let ringPath = NSBezierPath()
//        ringPath.appendArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 360, clockwise: false)
//
//        let ringLayer = CAShapeLayer()
//        ringLayer.path = ringPath.cgPath
//        ringLayer.strokeColor = NSColor.systemYellow.cgColor
//        ringLayer.fillColor = NSColor.clear.cgColor
//        ringLayer.lineWidth = lineWidth
//
//        return ringLayer
//    }
//
//    private func addRotationAnimation(to layer: CALayer) {
//        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
//        rotationAnimation.fromValue = 0
//        rotationAnimation.toValue = 2 * Double.pi
//        rotationAnimation.duration = 2 // 애니메이션 지속 시간 (초)
//        rotationAnimation.repeatCount = .infinity
//        layer.add(rotationAnimation, forKey: "rotationAnimation")
//    }
//}
//
//private extension NSBezierPath {
//    var cgPath: CGPath {
//        let path = CGMutablePath()
//        var points = [NSPoint](repeating: .zero, count: 3)
//        for i in 0..<elementCount {
//            let type = element(at: i, associatedPoints: &points)
//            switch type {
//            case .moveTo:
//                path.move(to: points[0])
//            case .lineTo:
//                path.addLine(to: points[0])
//            case .curveTo:
//                path.addCurve(to: points[2], control1: points[0], control2: points[1])
//            case .closePath:
//                path.closeSubpath()
//            @unknown default:
//                break
//            }
//        }
//        return path
//    }
//}
//



//import Cocoa
//
//class RotatingRingView: NSView {
//
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
//        self.wantsLayer = true
//        setupLayer()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.wantsLayer = true
//        setupLayer()
//    }
//
//    private func setupLayer() {
//        let ringLayer = createRingLayer()
//        self.layer?.addSublayer(ringLayer)
//        addRotationAnimation(to: ringLayer)
//    }
//
//    private func createRingLayer() -> CAShapeLayer {
//        let lineWidth: CGFloat = 10.0
//        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
//        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
//
//        let ringPath = NSBezierPath()
//        ringPath.appendArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 360, clockwise: false)
//
//        let ringLayer = CAShapeLayer()
//        ringLayer.path = ringPath.cgPath
//        ringLayer.strokeColor = NSColor.systemYellow.withAlphaComponent(0.4).cgColor
//        ringLayer.fillColor = NSColor.clear.cgColor
//        ringLayer.lineWidth = lineWidth
//        ringLayer.frame = self.bounds
//
//        return ringLayer
//    }
//
//    private func addRotationAnimation(to layer: CALayer) {
//        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        rotationAnimation.fromValue = 0
//        rotationAnimation.toValue = 2 * Double.pi
//        rotationAnimation.duration = 2 // 애니메이션 지속 시간 (초)
//        rotationAnimation.repeatCount = .infinity
//        layer.add(rotationAnimation, forKey: "rotationAnimation")
//    }
//}
//
//private extension NSBezierPath {
//    var cgPath: CGPath {
//        let path = CGMutablePath()
//        var points = [NSPoint](repeating: .zero, count: 3)
//        for i in 0..<elementCount {
//            let type = element(at: i, associatedPoints: &points)
//            switch type {
//            case .moveTo:
//                path.move(to: points[0])
//            case .lineTo:
//                path.addLine(to: points[0])
//            case .curveTo:
//                path.addCurve(to: points[2], control1: points[0], control2: points[1])
//            case .closePath:
//                path.closeSubpath()
//            @unknown default:
//                break
//            }
//        }
//        return path
//    }
//}


import Cocoa

class RotatingRingView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        setupLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        setupLayer()
    }

    private func setupLayer() {
        let ringLayer = createRingLayer()
        self.layer?.addSublayer(ringLayer)
        addRotationAnimation(to: ringLayer)
    }

    private func createRingLayer() -> CALayer {
        let lineWidth: CGFloat = 20.0
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)

        let ringLayer = CALayer()
        ringLayer.frame = self.bounds

        // 왼쪽 반쪽 (금색)
        let leftRingLayer = CAShapeLayer()
        let leftRingPath = NSBezierPath()
        leftRingPath.appendArc(withCenter: center, radius: radius, startAngle: 90, endAngle: 270, clockwise: false)
        leftRingLayer.path = leftRingPath.cgPath
        leftRingLayer.strokeColor = NSColor.systemYellow.withAlphaComponent(0.4).cgColor
        leftRingLayer.fillColor = NSColor.clear.cgColor
        leftRingLayer.lineWidth = lineWidth
        ringLayer.addSublayer(leftRingLayer)

        // 오른쪽 반쪽 (회색)
        let rightRingLayer = CAShapeLayer()
        let rightRingPath = NSBezierPath()
        rightRingPath.appendArc(withCenter: center, radius: radius, startAngle: 270, endAngle: 90, clockwise: false)
        rightRingLayer.path = rightRingPath.cgPath
        rightRingLayer.strokeColor = NSColor.systemBlue.withAlphaComponent(0.4).cgColor
        rightRingLayer.fillColor = NSColor.clear.cgColor
        rightRingLayer.lineWidth = lineWidth
        ringLayer.addSublayer(rightRingLayer)

        return ringLayer
    }

    private func addRotationAnimation(to layer: CALayer) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2 * Double.pi
        rotationAnimation.duration = 2 // 애니메이션 지속 시간 (초)
        rotationAnimation.repeatCount = .infinity
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}

private extension NSBezierPath {
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [NSPoint](repeating: .zero, count: 3)
        for i in 0..<elementCount {
            let type = element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default:
                break
            }
        }
        return path
    }
}

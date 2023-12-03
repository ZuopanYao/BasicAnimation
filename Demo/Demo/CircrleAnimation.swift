//
//  CircrleAnimation.swift
//  Demo
//
//  Created by Harvey on 2023/12/3.
//

import UIKit
import BasicAnimation

class CircrleAnimation {
    
    var anchorPoint: CGPoint = CGPoint(x: 300, y: 100.0)
    weak var sourceView: UIView?
    
    init(_ sourceView: UIView, anchorPoint: CGPoint) {
        self.sourceView = sourceView
        self.anchorPoint = anchorPoint
    }
    
    let size: CGSize = UIScreen.main.bounds.size
    let endPathSize: CGSize = CGSize(width: 60, height: 60)
    
    lazy var radius = hypot(anchorPoint.x, size.height - anchorPoint.y)
    
    lazy var initPath: CGPath = {
        let rect = CGRect(origin: anchorPoint, size: CGSize(width: radius, height: radius))
        return UIBezierPath(ovalIn: rect.insetBy(dx: -radius, dy: -radius)).cgPath
    }()
    
    lazy var endPath: CGPath = {
        UIBezierPath(ovalIn: CGRect(origin: anchorPoint, size: endPathSize)).cgPath
    }()
    
    lazy var maskLayer: CAShapeLayer = {
       let maskLayer = CAShapeLayer()
        maskLayer.path = initPath
        return maskLayer
    }()
    
    func close() {
        sourceView?.layer.mask = maskLayer
        
        let pathAnimater = BAAnimater(.path.fromValue(initPath).toValue(endPath))
        pathAnimater.fillMode(.both)
        .isRemovedOnCompletion(false)
        .duration(1.0)
        .run(on: maskLayer) { [unowned self] _ in
            sourceView?.isHidden = true
        }
        
        BAAnimater(.opacity.fromValue(1.0).toValue(0.1))
        .fillMode(.both)
        .isRemovedOnCompletion(false)
        .delay(0.75)
        .run(on: maskLayer)
    }
    
    func open() {
        sourceView?.isHidden = false
        
        let pathAnimater = BAAnimater(.path.fromValue(endPath).toValue(initPath))
        pathAnimater.duration(1.0)
        .run(on: maskLayer) { [unowned self] _ in
            sourceView?.layer.mask = nil
        }
        
        BAAnimater(.opacity.fromValue(0.1).toValue(1.0))
        .duration(1.0)
        .run(on: maskLayer)
    }
}

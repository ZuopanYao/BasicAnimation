//
//  JoinAnimater.swift
//  BasicAnimation
//
//  Created by Harvey on 2023/12/2.
//

import UIKit

public class BABaseAnimater: NSObject, CAAnimationDelegate {
    
    public var animation: CAAnimation? {
        return nil
    }
    
    var delay: Double = 0.0
    /// 延迟开始动画，单位为秒，默认为 0.0，即不延迟
    @discardableResult
    public func delay(_ value: Double) -> Self {
        delay = value
        return self
    }
    
    var duration: CFTimeInterval = 0.25
    /// 设置动画时间,默认0.25, 该参数对弹性动画无效
    @discardableResult
    public func duration(_ value: Double) -> Self {
        duration = value
        return self
    }
    
    var isReverses: Bool = false
    /// 是否启用回退动画，true = 启用，默认为false
    /// YES=启用回退动画,即由`toValue`到`fromValue`做回退动画
    @discardableResult
    public func isReverses(_ value: Bool) -> Self {
        isReverses = value
        return self
    }
    
    var repeatCount: Float = 0.0
    /// 设置动画重复次数
    @discardableResult
    public func repeatCount(_ value: Float) -> Self {
        repeatCount = value
        return self
    }
    
    var timingCurve: CAMediaTimingFunction = CAMediaTimingFunction(name: .default)
    /// 设置动画执行速度
    @discardableResult
    public func timingCurve(_ value: BATimingCurve) -> Self {
        timingCurve = value.timingFunction()
        return self
    }
    
    var fillMode: CAMediaTimingFillMode = .removed
    @discardableResult
    public func fillMode(_ value: CAMediaTimingFillMode) -> Self {
        fillMode = value
        return self
    }
    
    var isRemovedOnCompletion: Bool = true
    /// YES=动画结束时从layer移除, 默认 true
    @discardableResult
    public func isRemovedOnCompletion(_ value: Bool) -> Self {
        isRemovedOnCompletion = value
        return self
    }
    
    private var didStartTimeInterval: TimeInterval = 0.0
    public func animationDidStart(_ anim: CAAnimation) {
        #if DEBUG
        didStartTimeInterval = Date().timeIntervalSince1970
        #endif
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        #if DEBUG
        print("Animation Duration: ", Date().timeIntervalSince1970 - didStartTimeInterval)
        #endif
        animationDidStop?(flag)
    }
    
    var animationDidStop: ((Bool) -> Void)?
    /// 执行动画
    public func run(on view: UIView, animationDidStop: ((Bool) -> Void)? = nil) {
        run(on: view.layer, animationDidStop: animationDidStop)
    }
    
    /// 执行动画
    public func run(on layer: CALayer, animationDidStop: ((Bool) -> Void)? = nil) {
        self.animationDidStop = animationDidStop
    }
}

public class BAAnimater<T>: BABaseAnimater{
    
    typealias Change = (from: T, to: T)
    
    let keyPath: String
    let change: Change
    
    public init(_ animation: BAAnimation<T>) {
        self.keyPath = animation.keyPath
        self.change = (animation.fromValue!, animation.toValue!)
    }
    
    var spring: BASpring?
    /// 设置弹性因子，位置发生变动才生效
    @discardableResult
    public func spring(_ value: BASpring) -> Self {
        spring = value
        return self
    }
    
    public override var animation: CAAnimation? {
        var animation: CABasicAnimation = CABasicAnimation(keyPath: keyPath)
        
        if let spring = spring {
            let springAnimation = CASpringAnimation(keyPath: keyPath)
            springAnimation.damping = CGFloat(spring.damping)
            springAnimation.initialVelocity = CGFloat(spring.initialVelocity)
            springAnimation.mass = CGFloat(spring.mass)
            springAnimation.stiffness = CGFloat(spring.stiffness)
            animation = springAnimation
            animation.duration = springAnimation.settlingDuration
        }
        else {
            animation.duration = duration
        }
        
        animation.toValue = change.to
        animation.fromValue = change.from
        animation.fillMode = fillMode
        animation.delegate = self
        animation.autoreverses = isReverses
        animation.repeatCount = repeatCount
        animation.timingFunction = timingCurve
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        
        if delay > 0.0 {
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        }
        return animation
    }
    
    /// 执行动画
    public override func run(on layer: CALayer, animationDidStop: ((Bool) -> Void)? = nil) {
        super.run(on: layer, animationDidStop: animationDidStop)
        layer.add(animation!, forKey: keyPath)
    }
}

public class BAGroupAnimater: BABaseAnimater {
    
    private let animations: [CAAnimation]
    public init(_ animations: [CAAnimation]) {
        self.animations = animations
    }
    
    /// 执行动画
    public override func run(on layer: CALayer, animationDidStop: ((Bool) -> Void)? = nil) {
        super.run(on: layer, animationDidStop: animationDidStop)
        
        let animation: CAAnimationGroup = CAAnimationGroup()
        animation.animations = animations
        animation.duration = duration
        animation.fillMode = fillMode
        animation.delegate = self
        animation.autoreverses = isReverses
        animation.repeatCount = repeatCount
        animation.timingFunction = timingCurve
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        
        if delay > 0.0 {
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        }
        layer.add(animation, forKey: nil)
    }
}

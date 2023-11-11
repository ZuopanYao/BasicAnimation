//
//  BAAnimationController.swift
//  BasicAnimation
//
//  Created by Harvey on 2021/3/21.
//

import UIKit

protocol BAAnimationBase {
    
    /// 执行动画
    func run()
    
    /// 设置动画时间，默认为 0.25
    func duration(_ value: Float) -> Self
    
    /// 是否启用回退动画，true = 启用，默认为false
    func isReverses(_ value: Bool) -> Self
    
    /// 设置动画次数
    func repeatCount(_ value: Float) -> Self
    
    /// 延迟执行动画，单位为秒，默认不延迟
    func delay(_ value: Float) -> Self
    
    /// 设置动画执行速度
    func timingCurve(_ value: BATimingCurve) -> Self
}

public class BAAnimationController: BAAnimationBase {
    
    typealias Change = (from: Any, to: Any)
    let animation: CABasicAnimation
    let keyPath: BAKeyPath
    let change: Change
    var onView: UIView?
    var delayValue: Double = 0.0
    
    init(onView: UIView? = nil, change: Change, spring: BASpring?, keyPath: BAKeyPath) {
        
        self.keyPath = keyPath
        self.change = change
        self.onView = onView
        
        if let spring = spring {
           let springAnimation = CASpringAnimation(keyPath: keyPath.rawValue)
            springAnimation.damping = CGFloat(spring.damping)
            springAnimation.initialVelocity = CGFloat(spring.initialVelocity)
            springAnimation.mass = CGFloat(spring.mass)
            springAnimation.stiffness = CGFloat(spring.stiffness)
            self.animation = springAnimation
            self.animation.duration = springAnimation.settlingDuration
        }else {
            self.animation = CABasicAnimation(keyPath: keyPath.rawValue)
            // 每次动画时间，必须设置
            self.animation.duration = 0.25
        }
                
        // 动画初始值(状态)，必须设置
        self.animation.fromValue = change.from
        
        // 动画结束值(状态)，必须设置
        self.animation.toValue = change.to
        
        self.animation.fillMode = .forwards
        
        // YES=动画结束时从layer移除
        self.animation.isRemovedOnCompletion = false
        
        // 控制动画前后的状态
        self.animation.timingFunction = BATimingCurve.default.timingFunction()
    }
    
    public func run() {
        onView?.layer.add(animation, forKey: keyPath.rawValue)
    }
    
    /// 设置动画时间,默认0.25
    public func duration(_ value: Float) -> Self {
        
        if animation.isMember(of: CASpringAnimation.self) {
            let settlingDuration = (animation as! CASpringAnimation).settlingDuration
            guard Double(value) > settlingDuration  else {
                return self
            }
        }
        
        animation.duration = CFTimeInterval(value)
        return self
    }
    
    /// 是否启用回退动画，true = 启用，默认为false
    public func isReverses(_ value: Bool) -> Self {
        guard value else { return self }
        animation.autoreverses = true // YES=启用回退动画,即由toValue到fromValue做回退动画
        return self
    }
    
    /// 设置动画次数
    public func repeatCount(_ value: Float) -> Self {
        animation.repeatCount = value // 重复次数
        return self
    }
    
    /// 延迟执行动画，单位为秒，默认不延迟
    public func delay(_ value: Float) -> Self {
        guard value > 0.0 else { return self }
        delayValue = Double(value)
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(value)
        return self
    }
    
    /// 设置动画执行速度
    public func timingCurve(_ value: BATimingCurve) -> Self {
        animation.timingFunction = value.timingFunction()
        return self
    }
    
    public func fillMode(fillMode: CAMediaTimingFillMode) -> Self {
        animation.fillMode = fillMode
        return self
    }
    
    /// YES=动画结束时从layer移除
    public func isRemovedOnCompletion(_ isRemovedOnCompletion: Bool) -> Self {
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        return self
    }

    func totalDuration() -> Double {
        
        var single = animation.duration * Double(animation.repeatCount > 0.0 ? animation.repeatCount : 1.0)
        if animation.autoreverses {
            single = single * 2
        }
        return delayValue + single
    }
}

public class BAAnimationGroupController: BAAnimationBase {
    
    let animationGroup: CAAnimationGroup
    let keyPath: String
    
    var onView: UIView?
    
    init(onView: UIView? = nil, animations: [BAAnimationController]) {
        
        let keys = animations.map({ $0.keyPath.rawValue })
        keyPath = keys.sorted().joined()
        
        self.onView = onView
        
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animations.map({ $0.totalDuration() }).max()!
        self.animationGroup.animations = animations.map({ $0.animation })
        
        // YES=动画结束时从layer移除
        self.animationGroup.isRemovedOnCompletion = false
        
        // 控制动画前后的状态
        self.animationGroup.timingFunction = BATimingCurve.default.timingFunction()
    }
    
    public func run() {
        onView?.layer.add(animationGroup, forKey: keyPath)
    }
    
    /// 设置动画时间，默认为 0.35
    public func duration(_ value: Float) -> Self {
        animationGroup.duration = CFTimeInterval(value)
        return self
    }
    
    /// 是否启用回退动画，true = 启用，默认为false
    public func isReverses(_ value: Bool) -> Self {
        guard value else { return self }
        animationGroup.autoreverses = true // YES=启用回退动画,即由toValue到fromValue做回退动画
        return self
    }
    
    /// 设置动画次数
    public func repeatCount(_ value: Float) -> Self {
        animationGroup.repeatCount = value // 重复次数
        return self
    }
    
    /// 延迟执行动画，单位为秒，默认不延迟
    public func delay(_ value: Float) -> Self {
        guard value > 0.0 else { return self }
        animationGroup.beginTime = CACurrentMediaTime() + CFTimeInterval(value)
        return self
    }
    
    /// 设置动画执行速度
    public func timingCurve(_ value: BATimingCurve) -> Self {
        animationGroup.timingFunction = value.timingFunction()
        return self
    }
}

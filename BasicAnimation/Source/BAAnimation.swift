//
//  BAAnimation.swift
//  BasicAnimation
//
//  Created by Harvey on 2021/3/20.
//

import UIKit

public enum BAAnimation {
    
    /// X、Y 轴缩放
    case scale(from: CGPoint, to: CGPoint)
    /// X轴缩放
    case scaleX(from: Float, to: Float)
    /// Y轴缩放
    case scaleY(from: Float, to: Float)
    /// Z轴缩放
    case scaleZ(from: Float, to: Float)
    
    /// X 轴旋转
    case rotationX(from: Float, to: Float)
    /// Y 轴旋转
    case rotationY(from: Float, to: Float)
    /// Z 轴旋转
    case rotationZ(from: Float, to: Float)
    
    /// X、Y 轴平移
    case translation(from: CGSize, to: CGSize)
    /// X 轴平移
    case translationX(from: Float, to: Float)
    /// Y 轴平移
    case translationY(from: Float, to: Float)
    /// Z 轴平移
    case translationZ(from: Float, to: Float)
    /// CATransform3D
    case transform(from: CATransform3D, to: CATransform3D)
    
    ///
    case zPosition(from: Int, to: Int)
    
    /// 透明度
    case opacity(from: Float, to: Float)
    /// 背景颜色
    case backgroundColor(from: CGColor, to: CGColor)
    /// 圆角半径
    case cornerRadius(from: Float, to: Float)
    /// 边框宽度
    case borderWidth(from: Float, to: Float)
    ///
    case bounds(from: CGRect, to: CGRect)
    
    ///
    case contents(from: CGImage, to: CGImage)
    case contentsRect(from: CGRect, to: CGRect)
    
    ///
    case hidden(from: Bool, to: Bool)
    
//    /// 遮罩
//    case mask(from: CALayer, to: CALayer)
//    /// 是否将子层剪裁到层的边界
 //   case doubleSided(from: Bool, to: Bool)
//    
    /// CALayer在父层中的位置
    case position(from: CGPoint, to: CGPoint)
    
    /// 阴影颜色，要设置透明度才能生效
    case shadowColor(from: CGColor, to: CGColor)
    /// 阴影偏移，要设置透明度才能生效
    case shadowOffset(from: CGSize, to: CGSize)
    /// 阴影透明度，要设置透明度才能生效
    case shadowOpacity(from: Float, to: Float)
    /// 阴影半径，要设置透明度才能生效
    case shadowRadius(from: Float, to: Float)
    
    /// 创建动画控制器
    public func create() -> BAAnimationController {
        
        var key: BAKeyPath!
        var action: (from: Any, to: Any)!
        
        switch self {
        
        case .scale(let from, let to):
            key = .scale
            action = (from, to)
            
        case .scaleX(let from, let to):
            key = .scaleX
            action = (from, to)
            
        case .scaleY(let from, let to):
            key = .scaleY
            action = (from, to)
            
        case .scaleZ(let from, let to):
            key = .scaleZ
            action = (from, to)
            
        case .rotationX(let from, let to):
            key = .rotationX
            action = (from, to)
            
        case .rotationY(let from, let to):
            key = .rotationY
            action = (from, to)
            
        case .rotationZ(let from, let to):
            key = .rotationZ
            action = (from, to)
            
        case .translation(let from, let to):
            key = .translation
            action = (from, to)
            
        case .translationX(let from, let to):
            key = .translationX
            action = (from, to)
            
        case .translationY(let from, let to):
            key = .translationY
            action = (from, to)
            
        case .translationZ(let from, let to):
            key = .translationZ
            action = (from, to)
            
        case .zPosition(let from, let to):
            key = .zPosition
            action = (from, to)
            
        case .opacity(let from, let to):
            key = .opacity
            action = (from, to)
            
        case .backgroundColor(let from, let to):
            key = .backgroundColor
            action = (from, to)
            
        case .cornerRadius(let from, let to):
            key = .cornerRadius
            action = (from, to)
            
        case .borderWidth(let from, let to):
            key = .borderWidth
            action = (from, to)
            
        case .bounds(let from, let to):
            key = .bounds
            action = (from, to)
            
        case .contents(let from, let to):
            key = .contents
            action = (from, to)
            
        case .contentsRect(let from, let to):
            key = .contentsRect
            action = (from, to)
            
        case .hidden(let from, let to):
            key = .hidden
            action = (from, to)
            
//        case .mask(let from, let to):
//            key = .mask
//            action = (from, to)
//            
//        case .doubleSided(let from, let to):
//            key = .doubleSided
//            action = (from, to)
            
        case .position(let from, let to):
            key = .position
            action = (from, to)
            
        case .shadowColor(let from, let to):
            key = .shadowColor
            action = (from, to)
            
        case .shadowOffset(let from, let to):
            key = .shadowOffset
            action = (from, to)
            
        case .shadowOpacity(let from, let to):
            key = .shadowOpacity
            action = (from, to)
            
        case .shadowRadius(let from, let to):
            key = .shadowRadius
            action = (from, to)
            
        case .transform(let from, let to):
            key = .transform
            action = (from, to)
        }
        
        return BAAnimationController(change: action, keyPath: key)
    }
}

public extension BasicAnimation where Base: UIView {
    
    /// 创建动画控制器
    func create(animation: BAAnimation) -> BAAnimationController {
        let animation = animation.create()
        animation.onView = self.base
        return animation
    }
    
    /// 创建动画组控制器，需要注意的是在 BAAnimationController 中不可设置延迟执行(不要调用`delay`方法)
    func create(animation: [BAAnimationController]) -> BAAnimationGroupController {
        return BAAnimationGroupController(onView: self.base, animations: animation)
    }
}

public extension BasicAnimation where Base: UIView {
    
    /// 移除动一组动画
    func removeAnimation(animation: BAAnimationGroupController) {
        self.base.layer.removeAnimation(forKey: animation.keyPath)
    }
    
    /// 移除一个或多个动画
    func removeAnimation(keyPaths: [BAKeyPath]) {
        keyPaths.forEach { (keyPath) in
            self.base.layer.removeAnimation(forKey: keyPath.rawValue)
        }
    }
    
    /// 移除所有动画
    func removeAllAnimations() {
        self.base.layer.removeAllAnimations()
    }
}

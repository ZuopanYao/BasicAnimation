//
//  BAAnimation.swift
//  BasicAnimation
//
//  Created by Harvey on 2023/12/2.
//

import UIKit

public class BAAnimation<T> {
    var keyPath: String
    var fromValue: T!
    var toValue: T!
    
    init(_ keyPath: String) {
        self.keyPath = keyPath
    }
    
    @discardableResult
    public func toValue(_ value: T) -> Self {
        toValue = value
        return self
    }
    
    @discardableResult
    public func fromValue(_ value: T) -> Self {
        fromValue = value
        return self
    }
}

public extension BAAnimation {
    
    /// X、Y 轴缩放
    static var scale: BAAnimation<Float> {
        BAAnimation<Float>("transform.scale")
    }
    
    /// X 轴缩放
    static var scaleX: BAAnimation<Float> {
        BAAnimation<Float>("transform.scale.x")
    }
    
    /// Y 轴缩放
    static var scaleY: BAAnimation<Float> {
        BAAnimation<Float>("transform.scale.y")
    }
    
    /// Z 轴缩放
    static var scaleZ: BAAnimation<Float> {
        BAAnimation<Float>("transform.scale.Z")
    }
    
    /// X 轴旋转
    static var rotationX: BAAnimation<Float> {
        BAAnimation<Float>("transform.rotation.x")
    }
    
    /// Y 轴旋转
    static var rotationY: BAAnimation<Float> {
        BAAnimation<Float>("transform.rotation.y")
    }
    
    /// Z 轴旋转
    static var rotationZ: BAAnimation<Float> {
        BAAnimation<Float>("transform.rotation.z")
    }
    
    /// X、Y 轴平移
    static var translation: BAAnimation<CGPoint> {
        BAAnimation<CGPoint>("transform.translation")
    }
    
    /// X 轴平移
    static var translationX: BAAnimation<Float> {
        BAAnimation<Float>("transform.translation.x")
    }
    
    /// Y 轴平移
    static var translationY: BAAnimation<Float> {
        BAAnimation<Float>("transform.translation.y")
    }
    
    /// Z 轴平移
    static var translationZ: BAAnimation<Float> {
        BAAnimation<Float>("transform.translation.z")
    }
    
    /// CATransform3D
    static var transform: BAAnimation<CATransform3D> {
        BAAnimation<CATransform3D>("transform")
    }
    
    static var zPosition: BAAnimation<Int> {
        BAAnimation<Int>("zPosition")
    }
    
    /// 透明度
    static var opacity: BAAnimation<Float> {
        BAAnimation<Float>("opacity")
    }
    
    /// 背景色
    static var backgroundColor: BAAnimation<CGColor> {
        BAAnimation<CGColor>("backgroundColor")
    }
    
    /// 圆角半径
    static var cornerRadius: BAAnimation<Float> {
        BAAnimation<Float>("cornerRadius")
    }
    
    /// 边框宽度
    static var borderWidth: BAAnimation<Float> {
        BAAnimation<Float>("borderWidth")
    }
    
    static var bounds: BAAnimation<CGRect> {
        BAAnimation<CGRect>("bounds")
    }
    
    static var contents: BAAnimation<CGImage> {
        BAAnimation<CGImage>("contents")
    }
    
    static var contentsRect: BAAnimation<CGRect> {
        BAAnimation<CGRect>("contentsRect")
    }
    
    static var hidden: BAAnimation<Bool> {
        BAAnimation<Bool>("hidden")
    }
    
    static var position: BAAnimation<CGPoint> {
        BAAnimation<CGPoint>("position")
    }
    
    /// Only UIView.layer.mask = CAShapeLayer实例
    static var path: BAAnimation<CGPath> {
        BAAnimation<CGPath>("path")
    }
    
    /// Only UIView.layer.mask = CAShapeLayer实例
    static var strokeEnd: BAAnimation<Float> {
        BAAnimation<Float>("strokeEnd")
    }
    
    /// 阴影颜色，要设置透明度才能生效
    static var shadowColor: BAAnimation<CGColor> {
        BAAnimation<CGColor>("shadowColor")
    }
    
    /// 阴影颜色，要设置透明度才能生效
    static var shadowOffset: BAAnimation<CGSize> {
        BAAnimation<CGSize>("shadowOffset")
    }
    
    static var shadowOpacity: BAAnimation<Float> {
        BAAnimation<Float>("shadowOpacity")
    }
    
    /// 阴影颜色，要设置透明度才能生效
    static var shadowRadius: BAAnimation<Float> {
        BAAnimation<Float>("shadowRadius")
    }
}

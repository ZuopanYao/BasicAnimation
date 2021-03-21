//
//  BAKeyPath.swift
//  BasicAnimation
//
//  Created by Harvey on 2021/3/20.
//

import UIKit

public enum BAKeyPath: String {
    
    /// x、y轴缩放
    case scale = "transform.scale"
    /// x轴缩放
    case scaleX = "transform.scale.x"
    /// y轴缩放
    case scaleY = "transform.scale.y"
    /// z轴缩放
    case scaleZ = "transform.scale.Z"

    /// x旋转
    case rotationX = "transform.rotation.x"
    /// y轴旋转
    case rotationY = "transform.rotation.y"
    /// z轴旋转
    case rotationZ = "transform.rotation.z"

    /// x、y轴平面移动(CGSize)
    case translation = "transform.translation"
    /// x轴平面移动
    case translationX = "transform.translation.x"
    /// y轴平面移动
    case translationY = "transform.translation.y"
    /// z轴平面移动
    case translationZ = "transform.translation.z"
    
    /// 层级级别(值越大层级越高, 越接近顶层)
    case zPosition = "zPosition"

    /// 透明度
    case opacity = "opacity"
    /// 背景颜色
    case backgroundColor = "backgroundColor"
    /// 圆角半径
    case cornerRadius = "cornerRadius"
    /// 边框宽度
    case borderWidth = "borderWidth"
    ///
    case bounds = "bounds"
    
    ///
    case contents = "contents"
    case contentsRect = "contentsRect"
    
    /// 隐藏
    case hidden = "hidden"
    
    /// 遮罩 (CALayer)
    case mask = "mask"
    /// 是否将子层剪裁到层的边界
    case masksToBounds = "masksToBounds"
    
    /// CALayer在父层中的位置
    case position = "position"
    
    /// 阴影颜色
    case shadowColor = "shadowColor"
    /// 阴影偏移
    case shadowOffset = "shadowOffset"
    /// 阴影透明度
    case shadowOpacity = "shadowOpacity"
    /// 阴影半径
    case shadowRadius = "shadowRadius"
}

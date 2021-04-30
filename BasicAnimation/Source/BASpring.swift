//
//  BASpring.swift
//  BasicAnimation
//
//  Created by Harvey on 2021/4/30.
//

import Foundation

public struct BASpring {
    
    var mass: Float
    var stiffness: Float
    var damping: Float
    var initialVelocity: Float
    
    /// 弹性动画因素
    /// - Parameters:
    ///   - initialVelocity: 物体附着在弹簧上的初始速度，负值表示远离弹簧附着点的对象，正值表示向弹簧移动的对象，默认为 0.0
    ///   - mass: 附着在弹簧末端的物体的质量，必须大于0，默认为 1.0
    ///   - stiffness: 弹簧刚度系数，必须大于 0.0，默认为 100.0
    ///   - damping: 阻尼系数，必须大于或等于0，默认 10.0
    public init(_ initialVelocity: Float = 0.0, mass: Float = 1.0, stiffness: Float = 100.0, damping: Float = 10.0) {
        self.mass = mass
        self.damping = damping
        self.stiffness = stiffness
        self.initialVelocity = initialVelocity
    }
    
    public static let `default` = BASpring()
}

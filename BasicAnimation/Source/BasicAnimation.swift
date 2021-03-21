//
//  BAAnimation.swift
//  BasicAnimation
//
//  Created by Harvey on 2021/3/20.
//

import UIKit

public struct BasicAnimation<Base: UIView> {
    internal let base: Base!
    init(_ base: Base) {
        self.base = base
    }
}

public protocol BasicAnimationCompatible {
    associatedtype CompatibleType: UIView
    var ba: BasicAnimation<CompatibleType> { get }
}

public extension BasicAnimationCompatible {
    
    /// BasicAnimation
    var ba: BasicAnimation<CompatibleType> {
        get { return BasicAnimation(self as! CompatibleType) }
    }
}

extension UIView: BasicAnimationCompatible {
    public typealias CompatibleType = UIView
}

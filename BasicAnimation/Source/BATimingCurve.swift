//
//  BATimingCurve.swift
//  BasicAnimation
//
//  Created by Harvey on 2021/3/21.
//

import QuartzCore

public enum BATimingCurve {
    
    /// 均速（线性运行）
    case linear
    
    /// 先缓慢进入，再加速离开
    case easeIn
    
    /// 全速开始，慢慢减速
    case easeOut
    
    /// 先慢慢加速，再慢慢减速。
    case easeInEaseOut
    
    /// 默认值.先慢慢加速，再慢慢减速，但是它加速减速速度略慢
    case `default`
    
    /// 自定义
    case custom(c1x: Float, c1y: Float, c2x: Float, c2y: Float)
    
   
    func timingFunction() -> CAMediaTimingFunction {
        
        var timingFunctionName: CAMediaTimingFunctionName!
        
        switch self {
        
        case .default:
            timingFunctionName = .default
            
        case .easeIn:
            timingFunctionName = .easeIn
            
        case .easeInEaseOut:
            timingFunctionName = .easeInEaseOut
            
        case .linear:
            timingFunctionName = .linear
            
        case .easeOut:
            timingFunctionName = .easeOut
            
        case .custom(let c1x, let c1y, let c2x, let c2y):
            return CAMediaTimingFunction(controlPoints: c1x, c1y, c2x, c2y)
        }
        
        return CAMediaTimingFunction(name: timingFunctionName)
    }
}

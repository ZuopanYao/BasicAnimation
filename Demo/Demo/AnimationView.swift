//
//  AnimationView.swift
//  Demo
//
//  Created by Harvey on 2023/11/11.
//

import UIKit
import BasicAnimation

class AnimationBaseView: UIView {
    
    deinit {
        print("deinit \(Self.self)")

    }
}

class AnimationView: AnimationBaseView {
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect.init(x: 60, y: 200, width: 200, height: 200))
        view.backgroundColor = .blue
        view.layer.position = self.center
        return view
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        addSubview(contentView)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close(_:))))
    }
    
    func show() {
        UIApplication.shared.delegate?.window??.addSubview(self)
        
        let scaleAnimtion = BAAnimation.scale(from: 0.5, to: 1.0)
       
        let controller = contentView.ba
            .create(animation: scaleAnimtion)
        controller.fillMode(fillMode: .both).run()
        
        let mySpring = BASpring(3.0, mass: 1.0, stiffness: 50.0, damping: 5.0)
        let animation = BAAnimation.position(from: CGPoint(x: contentView.center.x, y: contentView.center.y - 200), to:center)
        contentView.ba.create(animation: animation, spring: mySpring).fillMode(fillMode: .both).run()
        
    }
    
    @objc func close(_ tap: UITapGestureRecognizer) {
        removeFromSuperview()
    }
    
//    deinit {
//        print("deinit \(Self.self)")
//    }
//    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

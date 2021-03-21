//
//  ViewController.swift
//  Demo
//
//  Created by Harvey on 2021/3/20.
//

import UIKit
import BasicAnimation

class ViewController: UIViewController {
    
    var aView: UIView!
    var bView: UIView!
    var cView: UIView!
    var dView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        aView = UIView(frame: CGRect(x: 100, y: 80, width: 180, height: 80))
        aView.backgroundColor = UIColor.red
        view.addSubview(aView)
        
        bView = UIView(frame: CGRect(x: 100, y: 230, width: 120, height: 120))
        bView.backgroundColor = UIColor.blue
        view.addSubview(bView)

        
        cView = UIView(frame: CGRect(x: 130, y: 400, width: 120, height: 120))
        cView.backgroundColor = UIColor.purple
        cView.layer.shadowOffset = .zero
        view.addSubview(cView)
        
        dView = UIView(frame: CGRect(x: 0, y: 00, width: 120, height: 120))
        dView.backgroundColor = UIColor.yellow
        view.addSubview(dView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// 简单动画
        aView.ba.create(animation: .scale(from: CGPoint(x: 1.0, y: 1.0), to: CGPoint(x: 0.4, y: 0.5))).delay(2.0).run()
        
        /// 自定义动画
        bView.ba.create(animation: .rotationZ(from: 0, to: Float.pi * 2.0)).duration(1.0).repeatCount(999).timingCurve(.linear).run()
        
        /// 动画组 1
        let animation1 = BAAnimation.shadowColor(from: UIColor.black.cgColor, to: UIColor.green.cgColor).create()
        let animation2 = BAAnimation.shadowRadius(from: 0.0, to: 50.0).create()
        let animation3 = BAAnimation.shadowOpacity(from: 0.2, to: 0.8).create()

        cView.ba.create(animation: [animation1, animation2, animation3]).delay(3.0).duration(2.0).repeatCount(9999).isReverses(true).run()
        
        /// 动画组 2
        let animation4 = BAAnimation.rotationZ(from: 0, to: Float.pi * 2.0).create()
        let animation5 = BAAnimation.position(from: dView.center, to: CGPoint(x: 300, y: 400)).create()

        let groupAnimation = dView.ba.create(animation: [animation4, animation5])
            
        groupAnimation.delay(3.0)
            .duration(2.0)
            .timingCurve(.easeInEaseOut)
            .repeatCount(9999)
            .isReverses(true)
            .run()
        
        // dView.ba.create(animation: groupAnimation)
    }
}


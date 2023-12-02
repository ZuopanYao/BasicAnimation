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
    var myView: UIView!
    var cView: UIView!
    var dView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        aView = UIView(frame: CGRect(x: 100, y: 80, width: 180, height: 180))
        aView.backgroundColor = UIColor.red
        view.addSubview(aView)
        
        myView = UIView(frame: CGRect(x: 100, y: 230, width: 120, height: 120))
        myView.backgroundColor = UIColor.blue
        view.addSubview(myView)

        
        cView = UIView(frame: CGRect(x: 130, y: 400, width: 120, height: 120))
        cView.backgroundColor = UIColor.purple
        cView.layer.shadowOffset = .zero
        view.addSubview(cView)
        
        dView = UIView(frame: CGRect(x: 0, y: 00, width: 120, height: 120))
        dView.backgroundColor = UIColor.yellow
        view.addSubview(dView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let btn = UIButton(type: .custom)
//        btn.setTitle("Scale", for: .normal)
//        btn.setTitleColor(.red, for: .normal)
//        btn.frame = waveView.bounds
//        view.addSubview(btn)
//        
//        btn.addTarget(self, action: #selector(dodo), for: .touchUpInside)
        
//        let scaleAnimtion = BAAnimation.scale(from: CGPoint(x: 1.0, y: 1.0), to: CGPoint(x: 0.4, y: 0.5))
//        let controller = aView.ba.create(animation: scaleAnimtion)
//        controller.delay(2.0).run()
        
        let from = UIBezierPath(ovalIn: CGRect(origin: .zero, size: CGSize(width: 180, height: 180)))
        
        let to = UIBezierPath(ovalIn: CGRect(origin: .zero, size: CGSize(width: 80, height: 80)))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = from.cgPath
//        aView.layer.mask = shapeLayer
        
        // 简单动画
        let pathAnimater = BAAnimater(.translationX.fromValue(0).toValue(100))
        pathAnimater
            .spring(BASpring(3.0, mass: 4.5, stiffness: 100, damping: 20))
//        pathAnimater.run(on: aView)
//        { [unowned self] flag in
//            print(flag)
////            aView.layer.mask = nil
//        }
        
        let saceAnimater = BAAnimater(.scale.fromValue(1.0).toValue(0.5))

        BAGroupAnimater([pathAnimater, saceAnimater].map { $0.animation })
            .duration(1.5)
            .delay(3)
            .run(on: aView) { flag in
                print(flag)
            }
        
//        aView.ba.create(animation: .scale(from: CGPoint(x: 1.0, y: 1.0), to: CGPoint(x: 0.4, y: 0.5))).delay(2.0).run()

        
        
        /// 自定义动画
//        myView.ba.create(animation: .rotationZ(from: 0, to: Float.pi * 2.0)).duration(1.0).repeatCount(999).timingCurve(.linear).run()
        
        
//        let mySpring = BASpring(10.0, mass: 2.0, stiffness: 100.0, damping: 5.0)
//        let animation = BAAnimation.position(from: myView.center, to:CGPoint(x: 200, y: 200))
//        myView.ba.create(animation: animation, spring: mySpring).run()
//        
        
      

//        /// 动画组 1
//        let animation1 = BAAnimation.shadowColor(from: UIColor.black.cgColor, to: UIColor.green.cgColor).create()
//        let animation2 = BAAnimation.shadowRadius(from: 0.0, to: 50.0).create()
//        let animation3 = BAAnimation.shadowOpacity(from: 0.2, to: 0.8).create()
//
//        cView.ba.create(animation: [animation1, animation2, animation3]).delay(3.0).duration(2.0).repeatCount(9999).isReverses(true).run()
//
//        /// 动画组 2
//        let animation4 = BAAnimation.rotationZ(from: 0, to: Float.pi * 2.0).create()
//        let animation5 = BAAnimation.position(from: dView.center, to: CGPoint(x: 300, y: 400)).create()
//
//        let groupAnimation = dView.ba.create(animation: [animation4, animation5])
//
//        groupAnimation.delay(3.0)
//            .duration(2.0)
//            .timingCurve(.easeInEaseOut)
//            .repeatCount(9999)
//            .isReverses(true)
//            .run()
        
        // dView.ba.removeAnimation(animation: groupAnimation)
    }
    
    @objc func dodo() {
        AnimationView().show()
    }
}


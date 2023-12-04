//
//  ViewController.swift
//  Demo
//
//  Created by Harvey on 2021/3/20.
//

import UIKit
import BasicAnimation

class ViewController: UIViewController {
    
    let contentView: UIView = UIView(frame: UIScreen.main.bounds)
    var myView: UIView!
    var cView: UIView!
    var dView: UIView!

    var btn1: UIButton!
    
    lazy var circrleAnimation = CircrleAnimation(contentView,
                                                 anchorPoint: CGPoint(x: 300, y: 100.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView = UIView(frame: CGRect(x: 50, y: 100, width: 120, height: 120))
        myView.backgroundColor = UIColor.purple
        view.addSubview(myView)
        
        btn1 = btnInstance
        btn1.backgroundColor = .purple
        btn1.titleLabel?.text = "Open"
        btn1.addTarget(self, action: #selector(`open`), for: .touchUpInside)
        view.addSubview(btn1)
        
        myView.removeAnimation(.scale)
        myView.layer.removeAnimation(.scale)
        
        myView.layer.removeAnimations([.backgroundColor, .shadowColor])
        myView.removeAnimations([.backgroundColor, .shadowColor])
        
        let btn = btnInstance
        contentView.addSubview(btn)
        btn.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: 60, y: 60), radius: 50, startAngle: 0, endAngle: CGFloat.pi * 2.0, clockwise: false)
       
        //UIBezierPath(arcCenter: CGPoint(x: 60, y: 60), radius: 40, startAngle: 0, endAngle: CGFloat.pi * 2.0, clockwise: false)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = bezierPath.cgPath
        maskLayer.lineWidth = 4.0
        maskLayer.lineJoin = .round
        maskLayer.lineCap = .round
        maskLayer.strokeStart = 0.0
        maskLayer.strokeEnd = 0.0
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.green.cgColor
        
        myView.layer.addSublayer(maskLayer)
        
        BAAnimater(.strokeEnd.fromValue(0.0).toValue(1.0))
            .delay(2)
            .fillMode(.both)
            .isRemovedOnCompletion(false)
            .duration(4)
            .run(on: maskLayer) { _ in
                print("--")
            }
    }
    
    var btnInstance: UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle("close", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.backgroundColor = .gray
        btn.frame = CGRect(x: 300, y: 100, width: 60, height: 60)
        return btn
    }
    
    @objc func close() {
        circrleAnimation.close()
    }
    
    @objc func `open`() {
        circrleAnimation.open()
    }
    
    @objc func dodo() {
        AnimationView().show()
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + size.width / 2.0, y: origin.y + size.height / 2.0)
    }
}

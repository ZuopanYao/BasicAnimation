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

    //这里的lazy：是懒加载 就是OC中重写get，set方法
    lazy var waveDisplaylink = CADisplayLink() //相比NSTimer下，这里用CADisplayLink主要是精确点，其频率：1/60
    lazy var firstWaveLayer = CAShapeLayer()
    lazy var secondWaveLayer = CAShapeLayer()
    /// 基础描述 正弦函数
    ///  y=Asin(ωx+φ）+ b
    ///  A : wavaA
    ///  w : 1/waveW
    ///  φ : offsetφ
    ///  b : b
    private var waveA: CGFloat = 0
    private var waveW: CGFloat = 0
    private var offsetX: CGFloat = 0
    private var b : CGFloat = 0
    //水纹的移动的速度
    var waveSpeed : CGFloat = 0
    let factor: Double = 0.8

    var waveView: UIView!
    
    private func initData(){
      waveSpeed = 0.05
        
      waveA = 60
      // 设置周期 :( 2* M_PI)/waveW = waveView.bounds.size.width 。因为涉及的是layer，所以只谈bounds,不说frame
        waveW = factor * Double.pi / waveView.bounds.size.width
        b = waveView.bounds.size.height / 10
    }
    
    private func configUI(){
        firstWaveLayer.fillColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 0.5).cgColor
        secondWaveLayer.fillColor = UIColor(red: 0.90, green:0.90, blue: 0.90, alpha: 0.5).cgColor
        waveView.layer.addSublayer(firstWaveLayer)
        waveView.layer.addSublayer(secondWaveLayer)
       waveDisplaylink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        waveDisplaylink.add(to: RunLoop.current, forMode: .common)
     }
    
    @objc private func getCurrentWave() {
      offsetX += waveSpeed
      setCurrentStatusWavePath()
    }
    
    //MARK: - 关键部分
    private func setCurrentStatusWavePath() {
      // 创建一个路径
      let firstPath = CGMutablePath()
      var firstY = waveView.bounds.size.width/factor
      firstPath.move(to: CGPoint(x: 0, y: firstY))
      for i in 0...Int(waveView.bounds.size.width) {
        firstY = waveA * sin(waveW * CGFloat(i) + offsetX) + b
        firstPath.addLine(to: CGPoint(x: CGFloat(i), y: firstY))
      }
       
      firstPath.addLine(to: CGPoint(x: waveView.bounds.size.width, y: waveView.bounds.size.height))
      firstPath.addLine(to: CGPoint(x: 0, y: waveView.bounds.size.height))
      firstPath.closeSubpath()
      firstWaveLayer.path = firstPath
       
      // 创建一个路径
      let secondPath = CGMutablePath()
      var secondY = waveView.bounds.size.width/factor
      secondPath.move(to: CGPoint(x: 0, y: secondY))
       
      for i in 0...Int(waveView.bounds.size.width) {
        secondY = waveA * sin(waveW * CGFloat(i) + offsetX - waveView.bounds.size.width/factor ) + b
        secondPath.addLine(to: CGPoint(x: CGFloat(i), y: secondY))
      }
      secondPath.addLine(to: CGPoint(x: waveView.bounds.size.width, y: waveView.bounds.size.height))
      secondPath.addLine(to: CGPoint(x: 0, y: waveView.bounds.size.height))
      secondPath.closeSubpath()
      secondWaveLayer.path = secondPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waveView = UIView(frame: view.bounds)
        view.addSubview(waveView)
        
        waveView.center = CGPoint(x: view.center.x, y: 500)
        // Do any additional setup after loading the view.
        
        aView = UIView(frame: CGRect(x: 100, y: 80, width: 180, height: 80))
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
        initData()
        configUI()
        
//        
//        let translationY = BAAnimation.translationY(from: -150.0, to: Float(view.bounds.height) - 150)
//        let controller = waveView.ba.create(animation: translationY)
//        controller.delay(5)
//            .fillMode(fillMode: .both)
//            .duration(8)
//            .isReverses(true)
//            .repeatCount(Float.infinity).run()
        
        
        
        
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
        
        /// 简单动画
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


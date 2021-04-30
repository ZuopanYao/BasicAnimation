# BasicAnimation

iOS 属性动画：缩放、旋转、平移、背景颜色、透明度、阴影等，一句代码的事

[![Platform](https://img.shields.io/cocoapods/p/BasicAnimation.svg?style=flat)](https://github.com/ZuopanYao/BasicAnimation)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/BasicAnimation.svg)](https://cocoapods.org/pods/BasicAnimation)

## Requirements / 使用条件

- iOS 10.0+
- Xcode 12.2+
- Swift 5.0+


## Installation / 安装

### CocoaPods

```
pod 'BasicAnimation'
```

### Manually / 手动安装

If you prefer not to use either of the aforementioned dependency managers, you can integrate BasicAnimation into your project manually.

如果您不喜欢以上管理依赖库的方式，则可以手动将 BasicAnimation 集成到项目中。


## Usage / 使用

### Quick Start / 快速上手

#### Example 1 / 示例 1

```swift
import BasicAnimation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let aView = UIView(frame: CGRect(x: 100, y: 80, width: 180, height: 80))
       aView.backgroundColor = UIColor.red
       view.addSubview(aView)
       
       /// 缩放动画 
       /// scale Animation
       aView.ba.create(animation: .scale(from: CGPoint(x: 1.0, y: 1.0), to: CGPoint(x: 0.4, y: 0.5))).delay(2.0).run()
    }
}
```

#### Example 2 / 示例 2

```swift
import BasicAnimation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let bView = UIView(frame: CGRect(x: 100, y: 230, width: 120, height: 120))
        bView.backgroundColor = UIColor.blue
        view.addSubview(bView)
        
          /// 旋转动画
          /// rotation Animation
        bView.ba.create(animation: .rotationZ(from: 0, to: Float.pi * 2.0)).duration(1.0).repeatCount(999).timingCurve(.linear).run()

    }
    
}
```

#### Example 3: animation group  / 示例 3

```swift
import BasicAnimation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let cView = UIView(frame: CGRect(x: 130, y: 400, width: 120, height: 120))
         cView.backgroundColor = UIColor.purple
         cView.layer.shadowOffset = .zero
         view.addSubview(cView)
         
        let animation1 = BAAnimation.shadowColor(from: UIColor.black.cgColor, to: UIColor.green.cgColor).create()
        let animation2 = BAAnimation.shadowRadius(from: 0.0, to: 50.0).create()
        let animation3 = BAAnimation.shadowOpacity(from: 0.2, to: 0.8).create()

		/// animation group 动画组
        cView.ba.create(animation: [animation1, animation2, animation3]).delay(3.0).duration(2.0).repeatCount(9999).isReverses(true).run()
        
    }
}
```


#### Example 4: animation group  / 示例 4

```swift
import BasicAnimation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dView = UIView(frame: CGRect(x: 0, y: 00, width: 120, height: 120))
        dView.backgroundColor = UIColor.yellow
        view.addSubview(dView)

          ///
        let animation4 = BAAnimation.rotationZ(from: 0, to: Float.pi * 2.0).create()
        let animation5 = BAAnimation.position(from: dView.center, to: CGPoint(x: 300, y: 400)).create()

        let groupAnimation = dView.ba.create(animation: [animation4, animation5])
     
        groupAnimation.delay(3.0)
            .duration(2.0)
            .timingCurve(.easeInEaseOut)
            .repeatCount(9999)
            .isReverses(true)
            .run()
        
        /// Maybe
        // dView.ba.removeAnimation(animation: groupAnimation)
    }
}
```

### Spring Animation

```

/// Simple
 myView.ba.create(animation: 
					 .position(from: myView.center, to:CGPoint(x: 200, y: 200)), 
				 spring: .default).run()
 
/// custom
let mySpring = BASpring(10.0, mass: 2.0, stiffness: 100.0, damping: 5.0)
myView.ba.create(animation:
                .position(from: myView.center, to:CGPoint(x: 200, y: 200)),
            spring: mySpring).run()

```

## License / 许可证

BasicAnimation is released under the MIT license. See LICENSE for details.

BasicAnimation 是在 MIT 许可下发布的，有关详情请查看该许可证。
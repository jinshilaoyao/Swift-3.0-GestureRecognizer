//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by yesway on 16/9/27.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    private var customGes = CustomGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: - 处理手势操作
    /**
     *  处理拖动手势
     *
     *  @param recognizer 拖动手势识别器对象实例
     */
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
        guard let imageView = recognizer.view else {
            return
        }
        
        imageView.superview?.bringSubview(toFront: imageView)
        
        let center = imageView.center
        let cornerRadius = imageView.frame.size.width / 2
        let translation = recognizer.translation(in: imageView)
        
        imageView.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
        recognizer.setTranslation(CGPoint(), in: self.view)
        
        if recognizer.state == .ended {
            let velocity = recognizer.velocity(in: self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMult = magnitude / 200
            
            let slideFactor = 0.1 * slideMult
            var finalPoint = CGPoint(x: center.x + (velocity.x * slideFactor), y: center.y + (velocity.y * slideFactor))
            
            finalPoint.x = min(max(finalPoint.x, cornerRadius), self.view.bounds.size.width - cornerRadius)
            finalPoint.y = min(max(finalPoint.y, cornerRadius), self.view.bounds.size.height - cornerRadius)
            
            UIView.animate(withDuration: Double(slideFactor*2.0), delay: 0, options: .curveEaseOut, animations: {
                recognizer.view?.center = finalPoint
                }, completion: nil)
        }
        
    }
    
    /**
     *  处理捏合手势
     *
     *  @param recognizer 捏合手势识别器对象实例
     */
    func handlePinch(recognizer: UIPinchGestureRecognizer) {
        
        let scale = recognizer.scale
        recognizer.view?.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    /**
     *  处理旋转手势
     *
     *  @param recognizer 旋转手势识别器对象实例
     */
    
    func handleRotation(recognizer: UIRotationGestureRecognizer) {
        recognizer.view?.transform = CGAffineTransform(rotationAngle: recognizer.rotation)
    }
    
    /**
     *  处理点按手势
     *
     *  @param recognizer 点按手势识别器对象实例
     */
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        recognizer.view?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        recognizer.view?.transform = CGAffineTransform(rotationAngle: 0)
        recognizer.view?.alpha = 1.0
    }
    
    
    /**
     *  处理长按手势
     *
     *  @param recognizer 点按手势识别器对象实例
     */

    func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        recognizer.view?.alpha = 0.5
    }
    
    /**
     *  处理轻扫手势
     *
     *  @param recognizer 轻扫手势识别器对象实例
     */
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        
        var newPoint = recognizer.view?.center
        
        switch recognizer.direction{
        case UISwipeGestureRecognizerDirection.right:
            newPoint?.y -= 20
            img1.center = newPoint!
            
            newPoint?.y += 40
            img2.center = newPoint!
            break
        case UISwipeGestureRecognizerDirection.left:
            newPoint?.y += 20
            img1.center = newPoint!
            
            newPoint?.y -= 40
            img2.center = newPoint!
            break
        case UISwipeGestureRecognizerDirection.up:
            newPoint?.x -= 20
            img1.center = newPoint!
            
            newPoint?.x += 40
            img2.center = newPoint!
            break
        case UISwipeGestureRecognizerDirection.down:
            newPoint?.x += 20
            img1.center = newPoint!
            
            newPoint?.x -= 40
            img2.center = newPoint!
            break
        default:
            break
        }
    }
    
    /**
     *  处理自定义手势
     *
     *  @param recognizer 自定义手势识别器对象实例
     */
//    - (void)handleCustomGestureRecognizer:(KMGestureRecognizer *)recognizer {
//    //代码块方式封装操作方法
//    void (^positionOperation)() = ^() {
//    CGPoint newPoint = recognizer.view.center;
//    newPoint.x -= 20.0;
//    _imgV.center = newPoint;
//    
//    newPoint.x += 40.0;
//    _imgV2.center = newPoint;
//    };
//    
//    positionOperation();
//    }
    
    func handleCustomGestureRecognizer(recognizer: CustomGestureRecognizer) {
        
        var newpoint = recognizer.view?.center
        
        newpoint?.x -= 20
        img1.center = newpoint!
        
        newpoint?.x += 40
        img2.center = newpoint!
        
    }
    
    
    // MARK: - 绑定手势操作
    /**
     *  绑定拖动手势
     *
     *  @param imgVCustom 绑定到图片视图对象实例
     */
    
    func bindPan(imgVCustom: UIImageView) {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        imgVCustom.addGestureRecognizer(recognizer)
    }
    /**
     *  绑定捏合手势
     *
     *  @param imgVCustom 绑定到图片视图对象实例
     */
    
    func bindPinch(imgVCustom: UIImageView) {
        let recognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        imgVCustom.addGestureRecognizer(recognizer)
    }
    
    
    /**
     *  绑定旋转手势
     *
     *  @param imgVCustom 绑定到图片视图对象实例
     */
    func bindRotation(imgVCustom: UIImageView) {
        let recognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        imgVCustom.addGestureRecognizer(recognizer)
    }
    
    /**
     *  绑定点按手势
     *
     *  @param imgVCustom 绑定到图片视图对象实例
     */

    
    func bindTap(imgVCustom: UIImageView) {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //    //使用一根手指双击时，才触发点按手势识别器
        recognizer.numberOfTapsRequired = 2
        recognizer.numberOfTouchesRequired = 1
        imgVCustom.addGestureRecognizer(recognizer)
    }
    
    /**
     *  绑定长按手势
     *
     *  @param imgVCustom 绑定到图片视图对象实例
     */
    
    func bindLongPress(imgVCustom: UIImageView) {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        recognizer.minimumPressDuration = 0.5
        imgVCustom.addGestureRecognizer(recognizer)
    }
    
    /**
     *  绑定轻扫手势；支持四个方向的轻扫，但是不同的方向要分别定义轻扫手势
     */
    
    func bindSwipe() {
        var recognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        recognizer.direction = .right
        view.addGestureRecognizer(recognizer)
        //设置以自定义挠痒手势优先识别
//        recognizer.require(toFail: )
        
        recognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        recognizer.direction = .left
        view.addGestureRecognizer(recognizer)
//        recognizer.require(toFail: )
    }
    
    func bindCustomGesture() {
        customGes = CustomGestureRecognizer(target: self, action: #selector(handleCustomGestureRecognizer))
        view.addGestureRecognizer(customGes)
    }
    
    
    
    func layoutUI() {
        img1.isUserInteractionEnabled = true
        img1.layer.masksToBounds = true
        img1.layer.cornerRadius = 20
        
        img2.isUserInteractionEnabled = true
        img2.layer.masksToBounds = true
        img2.layer.cornerRadius = 20
        
        bindPan(imgVCustom: img1)
        bindPan(imgVCustom: img2)
        
        bindPinch(imgVCustom: img1)
        bindPinch(imgVCustom: img2)
        
        bindRotation(imgVCustom: img1)
        bindRotation(imgVCustom: img2)
        
        bindTap(imgVCustom: img1)
        bindTap(imgVCustom: img2)
        
        bindLongPress(imgVCustom: img1)
        bindLongPress(imgVCustom: img2)
        
        bindSwipe()
        bindCustomGesture()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


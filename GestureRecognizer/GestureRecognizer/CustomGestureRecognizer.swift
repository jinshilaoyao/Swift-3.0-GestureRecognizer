//
//  CustomGestureRecognizer.swift
//  GestureRecognizer
//
//  Created by yesway on 16/9/27.
//  Copyright © 2016年 joker. All rights reserved.
//

/// UIGestureRecognizerSubclass 是 UIKit 中的一个公共头文件，但是没有包含在 UIKit 头文件中。因为你需要更新 state 属性，所以导入这个头文件是必须的，否则， 它就只是 UIGestureRecognizer 中的一个只读属性。
import UIKit.UIGestureRecognizerSubclass
enum Direction {
    case unKnow
    case Left
    case Right
}
class CustomGestureRecognizer: UIGestureRecognizer {

    private var tickleCount = 0
    private lazy var currentTickleStart = CGPoint()
    private var lastDirection: Direction = .unKnow
    
    struct Content {
        static let kMinTickleSpacing = 20.0
        static let kMaxTickleCount = 3
    }
    
    override func reset() {
        tickleCount = 0
        currentTickleStart = CGPoint()
        lastDirection = .unKnow
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else {
            return
        }
        currentTickleStart = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else {
            return
        }
        
        let tickleEnd = touch.location(in: self.view)
        let tickleSpacing = tickleEnd.x - currentTickleStart.x
        let currentDirection = tickleSpacing < 0 ? Direction.Left : Direction.Right
        
        if abs(tickleSpacing) >= CGFloat(Content.kMinTickleSpacing) {
            if (lastDirection == .unKnow || (lastDirection != currentDirection)) {
                tickleCount += 1
                currentTickleStart = tickleEnd
                lastDirection = currentDirection
                
                if (tickleCount >= Content.kMaxTickleCount && self.state == .possible) {
                    self.state = .ended
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
    
    
    
    
}

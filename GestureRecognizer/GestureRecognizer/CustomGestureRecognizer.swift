//
//  CustomGestureRecognizer.swift
//  GestureRecognizer
//
//  Created by yesway on 16/9/27.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
enum Direction {
    case unKnow
    case Left
    case Right
}
class CustomGestureRecognizer: UIGestureRecognizer {

    private var tickleCount = 0
    private lazy var currentTickleStart = CGPoint()
    private var lastDirection: Direction = .unKnow
    
    static let kMinTickleSpacing = 20.0
    static let kMaxTickleCount = 3
    
    func reset() {
        tickleCount = 0
        currentTickleStart = CGPoint()
        lastDirection = .unKnow
    }
    
    
    func touchsBegin(touchs: NSSet, withEvent: UIEvent) {
        let touch = touchs.anyObject() as? UITouch
        currentTickleStart = (touch?.location(in: self.view))!
    }
    
    
    
}

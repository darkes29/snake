//
//  Apple.swift
//  Snake
//
//  Created by Александр Ломтев on 29.07.2021.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    init(position: CGPoint) {
        super.init()
        path = UIBezierPath(ovalIn: CGRect(x:  0, y: 0, width: 10, height: 10)).cgPath
        fillColor = UIColor.red
        strokeColor = .red
        lineWidth = 5
        self.position = position 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SnakeHead.swift
//  Snake
//
//  Created by Александр Ломтев on 07.08.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategary.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategary.EdgeBody | CollisionCategary.Apple | CollisionCategary.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

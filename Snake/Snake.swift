//
//  Snake.swift
//  Snake
//
//  Created by Александр Ломтев on 29.07.2021.
//

import UIKit
import SpriteKit

class Snake: SKShapeNode {
    
    var body = [SnakeBodyPart]()
    
    let moveSpeed: CGFloat = 125.0
    var angle: CGFloat = 0.0
    
    init(atPoint point: CGPoint) {
        super.init()
        
        let head = SnakeHead(atPoint: point)
        body.append(head)
        addChild(head)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addBodyPart() {
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func move() {
        guard !body.isEmpty else {return}
        
        let head = body[0]
        moveHead(head)
        
        for index in (0 ..< body.count) where index > 0 {
            let previosBodyPart = body[index - 1]
            let currentBodyPart = body[index]
            
            moveBodyPart(previosBodyPart, currentBodyPart)
        }
    }
    
    func moveHead(_ head: SnakeBodyPart) {
        let dx = moveSpeed * sin(angle)
        let dy = moveSpeed * cos(angle)
        
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        head.run(moveAction)
    }
    func moveBodyPart(_ p: SnakeBodyPart, _ c: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1)
        c.run(moveAction)
    }
    func moveClockWise() {
        angle += CGFloat(Double.pi / 2)
    }
    
    func moveCounterClockWise() {
        angle -= CGFloat(Double.pi / 2)
    }
}



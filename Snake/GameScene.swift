//
//  GameScene.swift
//  Snake
//
//  Created by Александр Ломтев on 29.07.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
  
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.gray
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        view.showsPhysics = true
        
        
        let counterClockWise = SKShapeNode()
        counterClockWise.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockWise.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockWise.fillColor = UIColor.orange
        counterClockWise.strokeColor = UIColor.orange
        counterClockWise.lineWidth = 10
        counterClockWise.name = "counterClockWise"
        self.addChild(counterClockWise)
        
        let clockButton = SKShapeNode()
        clockButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        clockButton.fillColor = UIColor.orange
        clockButton.strokeColor = UIColor.orange
        clockButton.lineWidth = 10
        clockButton.name = "clockButtone"
        self.addChild(clockButton)
        createApple()
        
    }
    
    
    
    
   
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockWise" || touchesNode.name == "clockButtone" else{
                return
            }
            touchesNode.fillColor = .blue
            }
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockWise" || touchesNode.name == "clockButtone" else{
                return
            }
            touchesNode.fillColor = .orange
            }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5 )))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5 )))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

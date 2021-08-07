//
//  GameScene.swift
//  Snake
//
//  Created by Александр Ломтев on 29.07.2021.
//

import SpriteKit
import GameplayKit

struct CollisionCategary {
    static let Snake: UInt32 = 0x1 << 0 //0001 1
    static let SnakeHead: UInt32 = 0x1 << 1 // 0010 2
    static let Apple: UInt32 = 0x1 << 2 // 0100 4
    static let EdgeBody: UInt32 = 0x1 << 3 //1000 8
}



class GameScene: SKScene {
    var ScoreValue = 0
    var snake: Snake?
    var gameScore: SKLabelNode!
    
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
        clockButton.name = "clockButton"
        self.addChild(clockButton)
        
        gameScore = SKLabelNode(text: "Score: \(ScoreValue)")
        gameScore.name = "gameScore"
        gameScore.fontColor = .white
        gameScore.fontSize = 30.0
        gameScore.position = CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.maxY - 30)
        self.addChild(gameScore)
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollisionCategary.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategary.Snake | CollisionCategary.SnakeHead
        
        
    }
    
    
    
    
   
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockWise" || touchesNode.name == "clockButton" else{
                return
            }
            touchesNode.fillColor = .blue
            
            if touchesNode.name == "counterClockWise" {
                snake!.moveCounterClockWise()
            } else if touchesNode.name == "clockButton" {
                snake!.moveClockWise()
            }
            
            }
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockWise" || touchesNode.name == "clockButton" else{
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
        snake!.move()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategary.SnakeHead
        
        switch collisionObject {
        case CollisionCategary.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            self.ScoreValue += 1
            self.gameScore!.text = "Score: \(ScoreValue)"
            
            createApple()
        case CollisionCategary.EdgeBody:
            let scene = GameScene(size: self.size) // Whichever scene you want to restart (and are in)
            let animation = SKTransition.crossFade(withDuration: 0.8) // ...Add transition if you like
            self.view?.presentScene(scene, transition: animation)
        default:
            break
        }
    }
    
}

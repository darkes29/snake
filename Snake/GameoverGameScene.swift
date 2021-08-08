//
//  gameoverGameScence.swift
//  Snake
//
//  Created by Александр Ломтев on 08.08.2021.
//

import SpriteKit
import GameplayKit




class GameoverGameScene: SKScene {
    var restartGameLabel: SKLabelNode!
    var gameoverLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.gray
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        view.showsPhysics = true
        
        
        let restartGameButton = SKShapeNode()
        restartGameButton.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 200, height: 50)).cgPath
        restartGameButton.position = CGPoint(x: view.scene!.frame.midX-100, y: view.scene!.frame.midY)
        restartGameButton.fillColor = UIColor.orange
        restartGameButton.strokeColor = UIColor.orange
        restartGameButton.name = "restartGameButton"
        self.addChild(restartGameButton)
        
       
        
        restartGameLabel = SKLabelNode(text: "Restart game")
        restartGameLabel.name = "restartGameLabel"
        restartGameLabel.fontColor = .white
        restartGameLabel.fontSize = 30.0
        restartGameLabel.position = CGPoint(x: restartGameButton.frame.midX, y: restartGameButton.frame.midY-10)
        self.addChild(restartGameLabel)
        
        
        gameoverLabel = SKLabelNode(text: "GAME OVER! SCORE: \(GameScene.ScoreValue)")
        gameoverLabel.name = "gameoverLabel"
        gameoverLabel.fontColor = .white
        gameoverLabel.fontSize = 30.0
        gameoverLabel.position = CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.maxY-100)
        self.addChild( gameoverLabel)
        
    }
    
    
    
    
   
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKNode, touchesNode.name == "restartGameButton" || touchesNode.name == "restartGameLabel" else{
                return
            }
            
            if touchesNode.name == "restartGameButton"  || touchesNode.name == "restartGameLabel"{
                GameScene.ScoreValue = 0
                let scene = GameScene(size: self.size) // Whichever scene you want to restart (and are in)
                let animation = SKTransition.crossFade(withDuration: 0.8) // ...Add transition if you like
                self.view?.presentScene(scene, transition: animation)
            } else  {
                return
            }
            
            }
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "restartGameButton" || touchesNode.name == "restartGameLabel" else{
                return
            }
           
            }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
    }
}


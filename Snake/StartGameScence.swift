//
//  StartGameScence.swift
//  Snake
//
//  Created by Александр Ломтев on 08.08.2021.
//

import SpriteKit
import GameplayKit




class StartGameScene: SKScene {
    var snake: Snake?
    var startGameLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.gray
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        view.showsPhysics = true
        
        
        let startGameButton = SKShapeNode()
        startGameButton.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 200, height: 50)).cgPath
        startGameButton.position = CGPoint(x: view.scene!.frame.midX-100, y: view.scene!.frame.midY)
        startGameButton.fillColor = UIColor.orange
        startGameButton.strokeColor = UIColor.orange
        startGameButton.name = "startGameButton"
        self.addChild(startGameButton)
        
       
        
        startGameLabel = SKLabelNode(text: "Start game")
        startGameLabel.name = "startGameLabel"
        startGameLabel.fontColor = .white
        startGameLabel.fontSize = 30.0
        startGameLabel.position = CGPoint(x: startGameButton.frame.midX, y: startGameButton.frame.midY-10)
        self.addChild(startGameLabel)
        
    }
    
    
    
    
   
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKNode, touchesNode.name == "startGameButton" || touchesNode.name == "startGameLabel" else{
                return
            }
            
            if touchesNode.name == "startGameButton"  || touchesNode.name == "startGameLabel"{
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
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockWise" || touchesNode.name == "startGameLabel" else{
                return
            }
           
            }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
    }
}

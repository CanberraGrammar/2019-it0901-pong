//
//  GameScene.swift
//  Pong-IT0901
//
//  Created by MPP on 9/9/19.
//  Copyright © 2019 Matthew Purcell. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let BallCategory: UInt32 = 0x1 << 0
    let TopCategory: UInt32 = 0x1 << 1
    let BottomCategory: UInt32 = 0x1 << 2
    
    var topPaddle: SKSpriteNode?
    var fingerOnTopPaddle: Bool = false
    
    var bottomPaddle: SKSpriteNode?
    var fingerOnBottomPaddle: Bool = false
    
    var ball: SKSpriteNode?
    
    var gameRunning = false
        
    override func didMove(to view: SKView) {
        
        topPaddle = childNode(withName: "topPaddle") as? SKSpriteNode
        topPaddle!.physicsBody = SKPhysicsBody(rectangleOf: topPaddle!.frame.size)
        topPaddle!.physicsBody!.isDynamic = false
        
        bottomPaddle = childNode(withName: "bottomPaddle") as? SKSpriteNode
        bottomPaddle!.physicsBody = SKPhysicsBody(rectangleOf: bottomPaddle!.frame.size)
        bottomPaddle!.physicsBody!.isDynamic = false
        
        ball = childNode(withName: "ball") as? SKSpriteNode
        ball!.physicsBody = SKPhysicsBody(rectangleOf: ball!.frame.size)
        ball!.physicsBody!.restitution = 1
        ball!.physicsBody!.friction = 0
        ball!.physicsBody!.linearDamping = 0
        ball!.physicsBody!.angularDamping = 0
        ball!.physicsBody!.allowsRotation = false
        ball!.physicsBody!.categoryBitMask = BallCategory
        ball!.physicsBody!.contactTestBitMask = TopCategory | BottomCategory
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        let topNode = SKNode()
        let topLeftPoint = CGPoint(x: -(self.size.width / 2), y: self.size.height / 2)
        let topRightPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        topNode.physicsBody = SKPhysicsBody(edgeFrom: topLeftPoint, to: topRightPoint)
        topNode.physicsBody!.categoryBitMask = TopCategory
        self.addChild(topNode)
        
        let bottomNode = SKNode()
        let bottomLeftPoint = CGPoint(x: -(self.size.width / 2), y: -(self.size.height / 2))
        let bottomRightPoint = CGPoint(x: self.size.width / 2, y: -(self.size.height / 2))
        bottomNode.physicsBody = SKPhysicsBody(edgeFrom: bottomLeftPoint, to: bottomRightPoint)
        bottomNode.physicsBody!.categoryBitMask = BottomCategory
        self.addChild(bottomNode)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch  = touches.first!
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        //if touchedNode.name == "topPaddle" {
        if touchedNode == topPaddle {
            fingerOnTopPaddle = true
        }
        
        else if touchedNode == bottomPaddle {
            fingerOnBottomPaddle = true
        }
        
        if gameRunning == false {
            
            ball!.physicsBody!.applyImpulse(CGVector(dx: 8.0, dy: 8.0))

            gameRunning = true
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch  = touches.first!
        let touchLocation = touch.location(in: self)
        let previousTouchLocation = touch.previousLocation(in: self)
        
        let distanceMoved = touchLocation.x - previousTouchLocation.x
        
        if touchLocation.y > 0 && fingerOnTopPaddle {
            
            let paddleX = topPaddle!.position.x + distanceMoved
            
            if (paddleX + topPaddle!.size.width / 2) < (self.size.width / 2) && (paddleX - topPaddle!.size.width / 2) > -(self.size.width / 2) {
            
                topPaddle!.position.x = topPaddle!.position.x + distanceMoved
                
            }
            
        }
        
        else if touchLocation.y < 0 && fingerOnBottomPaddle {
            
            let paddleX = bottomPaddle!.position.x + distanceMoved
            
            if (paddleX + bottomPaddle!.size.width / 2) < (self.size.width / 2) && (paddleX - bottomPaddle!.size.width / 2) > -(self.size.width / 2) {
                
                bottomPaddle!.position.x = bottomPaddle!.position.x + distanceMoved
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if fingerOnTopPaddle {
            fingerOnTopPaddle = false
        }
        
        else if fingerOnBottomPaddle {
            fingerOnBottomPaddle = false
        }
        
    }
    
    func resetGame() {
        
        // Put the ball back in the centre of the screen
        
        // Reset the position of the paddles
        
    }
    
    func gameOver() {
        
        // Pause the game
        view!.isPaused = true
        
        // Show an alert saying "Game Over" - you need a UIAlertController
        let gameOverAlert = UIAlertController(title: "Game Over", message: nil, preferredStyle: .alert)
        let gameOverAction = UIAlertAction(title: "Okay", style: .default) { (alertAction) in
            
            // Write the code to run when the button is tapped
            self.resetGame()
            
        }
        
        gameOverAlert.addAction(gameOverAction)
        
        view!.window!.rootViewController!.present(gameOverAlert, animated: true, completion: nil)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.categoryBitMask == BottomCategory) || (contact.bodyB.categoryBitMask == BottomCategory) {
            
            print("Bottom collision")
            
            gameOver()
            
        }
        
        else if (contact.bodyA.categoryBitMask == TopCategory) || (contact.bodyB.categoryBitMask == TopCategory) {
            
            print("Top collision")
            
            gameOver()
            
        }
        
    }
    
}

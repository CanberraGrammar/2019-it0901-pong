//
//  GameScene.swift
//  Pong-IT0901
//
//  Created by MPP on 9/9/19.
//  Copyright © 2019 Matthew Purcell. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var topPaddle: SKSpriteNode?
    var fingerOnTopPaddle: Bool = false
    
    var bottomPaddle: SKSpriteNode?
    var fingerOnBottomPaddle: Bool = false
    
    var ball: SKSpriteNode?
        
    override func didMove(to view: SKView) {
        
        topPaddle = childNode(withName: "topPaddle") as? SKSpriteNode
        bottomPaddle = childNode(withName: "bottomPaddle") as? SKSpriteNode
        
        ball = childNode(withName: "ball") as? SKSpriteNode
        ball!.physicsBody = SKPhysicsBody(rectangleOf: ball!.frame.size)
        
        // self.physicsWorld.gravity = CGVector(dx: 0.2, dy: 0.2)
        
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
    
}

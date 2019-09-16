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
        
    override func didMove(to view: SKView) {
        
        topPaddle = childNode(withName: "topPaddle") as? SKSpriteNode
        bottomPaddle = childNode(withName: "bottomPaddle") as? SKSpriteNode
        
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
            topPaddle!.position.x = topPaddle!.position.x + distanceMoved
        }
        
        else if touchLocation.y < 0 && fingerOnBottomPaddle {
            bottomPaddle!.position.x = bottomPaddle!.position.x + distanceMoved
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

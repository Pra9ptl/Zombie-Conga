//
//  GameScene.swift
//  ZombieConga
//
//  Created by Parrot on 2019-01-29.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
   
    override func didMove(to view: SKView) {
        //code here
        
        //set background color to the app
        self.backgroundColor = SKColor.blue
        
        //set background image of the app
        //1. image node
        let bgNode = SKSpriteNode(imageNamed: "background1")
        
        //set position
        bgNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        //force the background to back of all the sprites
        bgNode.zPosition = -1
        //add tp screen
        addChild(bgNode)
        
        
        //add zombie sprite
        //1. image node
        let zombie = SKSpriteNode(imageNamed: "zombie1")
        
        //set position
        zombie.position = CGPoint(x: 400, y: 400)
        
        //add zombie to the screen
        addChild(zombie)
        
        //add zombie sprite
        //1. image node
        let enemy = SKSpriteNode(imageNamed: "enemy")
        
        //set position
        enemy.position = CGPoint(x: self.size.width - 200, y: self.size.height/2)
        
        //add zombie to the screen
        addChild(enemy)
    }

    
}

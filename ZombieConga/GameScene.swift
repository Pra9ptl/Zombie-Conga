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
        // Set the background color of the app
        self.backgroundColor = SKColor.black;
        
        // -----------------------------
        // 1. Add a background to the game
        // -----------------------------
        // Add a background image
        let bg = SKSpriteNode(imageNamed:"background1")
        // Set position of background to middle of screen
        bg.position = CGPoint(x: size.width/2, y: size.height/2)
        
        // Force the background image to always be at the back
        bg.zPosition = -1

        // Finally, add the background to the Scene Graph
        addChild(bg)
        
        
        // -----------------------------
        // 2. Add a zombie to the game
        // -----------------------------
        let zombie = SKSpriteNode(imageNamed: "zombie1")
        zombie.position = CGPoint(x:400, y:400)
        addChild(zombie)
    }
    
}

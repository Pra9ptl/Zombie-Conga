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
   
    // Make zombie global, so other functions can access it
    let zombie:SKSpriteNode = SKSpriteNode(imageNamed:"zombie1")
    
    override func didMove(to view: SKView) {
        // Set the background color of the app
        self.backgroundColor = SKColor.black;
        
        // -----------------------------
        // Add a background to the game
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
        // Add a zombie to the game
        // -----------------------------
        zombie.position = CGPoint(x:400, y:400)
        addChild(zombie)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // -----------------------------
        // Move the zombie to the right
        // -----------------------------
      
        // Remember:  The game loop is:
        //      - updatePositions
        //      - drawPositions
        //      - setFPS
        // In IOS, the update() function == updatePositions() function from Android game template
        let zombieX = self.zombie.position.x + 10;
        self.zombie.position = CGPoint(x: zombieX, y: self.zombie.position.y)
    }
    
}

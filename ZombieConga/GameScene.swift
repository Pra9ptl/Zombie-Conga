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
    
    // Movement variables
    var zombieMovingLeft:Bool = false;
    var zombieMovingRight:Bool = true;
    
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
        // Remember:  The game loop is:
        //      - updatePositions
        //      - drawPositions
        //      - setFPS
        // In IOS, the update() function == updatePositions() function from Android game template

        
        // --------------------------
        // Make zombie bounce off left and right walls
        // --------------------------
        // get x-position of right side of screen
        let screenRightSide = size.width
        
        // get current x-position of zombie
        var zombieX = self.zombie.position.x
        
        if (self.zombieMovingLeft == true) {
            zombieX = self.zombie.position.x - 10;
            
            if (zombieX <= 0) {
                // bounce off left wall
                self.zombieMovingRight = true;
                self.zombieMovingLeft = false;
                
            }
        }
        
        if (self.zombieMovingRight == true) {
            zombieX = self.zombie.position.x + 10;
            
            if (zombieX >= screenRightSide) {
                // bounce off right wall
                self.zombieMovingLeft = true
                self.zombieMovingRight = false
            }
        }
        
        
        self.zombie.position = CGPoint(x: zombieX, y: self.zombie.position.y)
    }
    
    
    // MARK: Detect when user taps the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // get the first "tap" on the screen
        let touch = touches.first
        
        if (touch == nil) {
            // if for some reason the "tap" return as null, then exit
            return
        }
        
        let touchLocation = touch!.location(in: self)
        print("User tapped screen at: \(touchLocation.x.rounded()),\(touchLocation.y.rounded())")
    }
    
}

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
    //sprites decalaration
    //1. image node
    let bgNode = SKSpriteNode(imageNamed: "background1")
    //add zombie sprite
    //1. image node
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    //add enemy sprite
    //1. image node
    let enemy = SKSpriteNode(imageNamed: "enemy")
   
    override func didMove(to view: SKView) {
        //code here
        
        //set background color to the app
        self.backgroundColor = SKColor.blue
        
        //set background image of the app
        
        //set position
        bgNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        //force the background to back of all the sprites
        bgNode.zPosition = -1
        
        //set position
        zombie.position = CGPoint(x: 400, y: 400)
        
        //set position
        enemy.position = CGPoint(x: self.size.width - 200, y: self.size.height/2)
        
        //add tp screen
        addChild(bgNode)
        //add zombie to the screen
        addChild(zombie)
        //add zombie to the screen
        addChild(enemy)
        
        
    }
    
    //Movement Flag
    var zombieDirection:String = "right"
    
    override func update(_ currentTime: TimeInterval) {
        //this is the same as updatePositions() from android
        //--------------------------------
        
        //p1: Make zombie move
        //1. Get zombie position
        print("zombie x: \(self.zombie.position.x)")
        print("zombie y: \(self.zombie.position.y)")
        print("------------------------")
        
        
        //3. Detect when he hits the wall
        if (self.zombieDirection == "right") {
            zombie.position = CGPoint(x:self.zombie.position.x + 10,y:400)
        }
        else if (self.zombieDirection == "left") {
            zombie.position = CGPoint(x:self.zombie.position.x - 10,y:400)
        }
        
        
        // R1:  Hit right wall, go left
        if (self.zombie.position.x >= self.size.width) {
            print("HIT THE WALL")
            self.zombieDirection = "left"
        }
        // R2:  Hight left wall, go right
        if (self.zombie.position.x <= 0) {
            self.zombieDirection = "right"
        }
        
    }
}

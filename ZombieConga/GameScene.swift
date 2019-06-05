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
    // MATH VARIABLES
    var xd:CGFloat = 0
    var yd:CGFloat = 0
    override func update(_ currentTime: TimeInterval) {
        self.zombie.position.x = self.zombie.position.x + self.xd * 10
        self.zombie.position.y = self.zombie.position.y + self.yd * 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let locationTouched = touches.first
        
        if(locationTouched == nil)
        {
            //htis is error handling
            //sometimes the mouse detection doesn't work
            //and IOS can't get the position
            return
        }
        
        let mouseposition = locationTouched!.location(in: self)
        
        print("Mouse X? \(mouseposition.x)")
        print("Mouse y? \(mouseposition.y)")
        
        //calculate those math variable (d, xd, yd)
        //(x2 - x1)
        let a = mouseposition.x - self.zombie.position.x
        //(y2-y1)
        let b = mouseposition.y - self.zombie.position.y
        //d
        let d = sqrt((a*a) + (b*b))
        
        self.xd = a/d
        self.yd = b/d
    }
}
